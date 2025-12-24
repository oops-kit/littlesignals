import 'package:littlesignals/core/constants/app_constants.dart';
import 'package:littlesignals/core/domain/event_logger.dart';
import 'package:littlesignals/core/services/impulsivity/balloon_tap_handler.dart';
import 'package:littlesignals/core/utils/balloon_spawn_controller.dart';
import 'package:littlesignals/core/utils/countdown_controller.dart';
import 'package:littlesignals/core/utils/event_log_recorder.dart';
import 'package:littlesignals/models/balloon_data.dart';
import 'package:littlesignals/models/impulsivity_result.dart';
import 'package:littlesignals/providers/app_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'impulsivity_test_state.dart';

part 'impulsivity_test_provider.g.dart';

/// 충동성 테스트 컨트롤러
///
/// 게임 흐름을 조율하고, 세부 로직은 전문 서비스에 위임합니다.
/// SRP: 게임 흐름 조율에만 집중
/// DIP: EventLogger, BalloonTapHandler는 인터페이스/서비스를 통해 사용
@riverpod
class ImpulsivityTestController extends _$ImpulsivityTestController {
  CountdownController? _countdownController;
  BalloonSpawnController? _balloonController;
  late EventLogger _logRecorder;
  late BalloonTapHandler _tapHandler;
  bool _isDisposed = false;

  @override
  ImpulsivityTestState build() {
    // DIP: 의존성 초기화
    _logRecorder = EventLogRecorder();

    // SRP: 전문 서비스 초기화
    _tapHandler = BalloonTapHandler(logger: _logRecorder);

    ref.onDispose(() {
      _isDisposed = true;
      _countdownController?.dispose();
      _balloonController?.dispose();
    });

    return ImpulsivityTestState(startTime: DateTime.now());
  }

  /// 게임 시작 (카운트다운 후)
  void startGame() {
    state = state.copyWith(
      gameState: ImpulsivityGameState.countdown,
      countdownValue: 3,
    );

    _countdownController = CountdownController(
      startValue: 3,
      onTick: (value) {
        state = state.copyWith(countdownValue: value);
      },
      onComplete: _startPlaying,
    );
    _countdownController!.start();
  }

  void _startPlaying() {
    _logRecorder.logTestStart('풍선 놀이 시작! 🎈');

    state = state.copyWith(
      gameState: ImpulsivityGameState.playing,
      countdownValue: null,
      startTime: DateTime.now(),
      eventLogs: _logRecorder.logs,
    );

    _initBalloonController();
    _scheduleNextBalloon();
  }

  void _initBalloonController() {
    _balloonController = BalloonSpawnController(
      minIntervalMs: AppConstants.impulsivityMinIntervalMs,
      maxIntervalMs: AppConstants.impulsivityMaxIntervalMs,
      balloonDurationMs: AppConstants.impulsivityBalloonDurationMs,
      blueRatio: AppConstants.impulsivityBlueRatio,
      onSpawn: (balloon) {
        state = state.copyWith(currentBalloon: balloon);
      },
      onTimeout: _handleTimeout,
    );
  }

  void _scheduleNextBalloon() {
    if (_isDisposed) return;
    if (state.gameState != ImpulsivityGameState.playing) return;
    if (state.stimuliCount >= AppConstants.impulsivityTotalStimuli) {
      _finishTest();
      return;
    }

    _balloonController?.scheduleNext();
  }

  void _handleTimeout(int balloonId, bool isBlue) {
    if (_isDisposed) return;
    if (state.currentBalloon?.id != balloonId) return;

    // SRP: 타임아웃 처리를 BalloonTapHandler에 위임
    _tapHandler.handleTimeout(
      isBlue: isBlue,
      currentOmissionErrors: state.omissionErrors,
    );

    final newOmissionErrors = isBlue
        ? state.omissionErrors + 1
        : state.omissionErrors;

    // 타임아웃 상태로 변경 (페이드아웃 애니메이션용)
    final updatedBalloon = state.currentBalloon?.copyWith(
      tapState: BalloonTapState.timeout,
    );

    state = state.copyWith(
      currentBalloon: updatedBalloon,
      stimuliCount: state.stimuliCount + 1,
      omissionErrors: newOmissionErrors,
      eventLogs: _logRecorder.logs,
    );

    // 짧은 딜레이 후 풍선 제거 및 다음 풍선 스케줄
    Future.delayed(const Duration(milliseconds: 200), () {
      if (_isDisposed) return;
      state = state.copyWith(currentBalloon: null);
      _scheduleNextBalloon();
    });
  }

  /// 풍선 클릭 처리
  ///
  /// SRP: 흐름 조율만 담당, 터치 결과 분석은 BalloonTapHandler에 위임
  void handleBalloonClick() {
    if (state.currentBalloon == null) return;
    // 이미 탭된 상태면 무시
    if (state.currentBalloon!.tapState != BalloonTapState.none) return;

    _balloonController?.clearCurrentBalloon();

    final balloon = state.currentBalloon!;

    // SRP: 터치 처리를 BalloonTapHandler에 위임
    final result = _tapHandler.handleTap(
      balloon: balloon,
      currentCommissionErrors: state.commissionErrors,
    );

    switch (result) {
      case BlueBalloonSuccess(:final reactionTimeMs):
        // 탭 상태로 변경 (팝 애니메이션용)
        final tappedBalloon = balloon.copyWith(
          tapState: BalloonTapState.correctTap,
        );
        state = state.copyWith(
          reactionTimes: [...state.reactionTimes, reactionTimeMs],
          currentBalloon: tappedBalloon,
          stimuliCount: state.stimuliCount + 1,
          eventLogs: _logRecorder.logs,
        );
      case RedBalloonError():
        // 탭 상태로 변경 (흔들림 애니메이션용)
        final tappedBalloon = balloon.copyWith(
          tapState: BalloonTapState.incorrectTap,
        );
        state = state.copyWith(
          commissionErrors: state.commissionErrors + 1,
          currentBalloon: tappedBalloon,
          stimuliCount: state.stimuliCount + 1,
          eventLogs: _logRecorder.logs,
        );
    }

    // 애니메이션 후 풍선 제거 및 다음 풍선 스케줄
    Future.delayed(const Duration(milliseconds: 400), () {
      if (_isDisposed) return;
      state = state.copyWith(currentBalloon: null);
      _scheduleNextBalloon();
    });
  }

  /// 화면 터치 처리 (풍선이 없을 때 = 예측 반응)
  ///
  /// SRP: 예측 반응 처리를 BalloonTapHandler에 위임
  void handleScreenTap() {
    if (state.gameState != ImpulsivityGameState.playing) return;

    // 풍선이 없을 때 화면을 터치하면 예측 반응으로 기록
    if (state.currentBalloon == null) {
      _tapHandler.handleAnticipatoryTap(
        currentAnticipatoryResponses: state.anticipatoryResponses,
      );
      state = state.copyWith(
        anticipatoryResponses: state.anticipatoryResponses + 1,
        eventLogs: _logRecorder.logs,
      );
    }
  }

  void _finishTest() {
    if (state.isCompleted) return;

    _balloonController?.cancel();

    final now = DateTime.now();
    final duration = state.startTime != null
        ? now.difference(state.startTime!).inMilliseconds / 1000.0
        : 0.0;

    final avgRT = state.reactionTimes.isNotEmpty
        ? state.reactionTimes.reduce((a, b) => a + b) /
              state.reactionTimes.length
        : 0.0;

    // 테스트 완료 로그 추가
    _logRecorder.logTestComplete(duration);
    final finalLogs = _logRecorder.logs;

    final result = ImpulsivityResult(
      reactionTimeAverage: avgRT,
      commissionErrors: state.commissionErrors,
      omissionErrors: state.omissionErrors,
      totalStimuli: AppConstants.impulsivityTotalStimuli,
      completionStatus: 'completed',
      anticipatoryResponses: state.anticipatoryResponses,
      reactionTimes: state.reactionTimes,
      eventLogs: finalLogs,
    );

    ref.read(appStateNotifierProvider.notifier).setImpulsivityResult(result);

    state = state.copyWith(
      gameState: ImpulsivityGameState.finished,
      isCompleted: true,
      eventLogs: finalLogs,
    );
  }

  /// 테스트 리셋
  void reset() {
    _countdownController?.dispose();
    _countdownController = null;
    _balloonController?.dispose();
    _balloonController = null;
    _logRecorder.clear();
    state = const ImpulsivityTestState();
  }
}
