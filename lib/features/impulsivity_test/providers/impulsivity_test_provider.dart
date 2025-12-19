import 'dart:async';
import 'dart:developer' as developer;
import 'dart:math';

import 'package:littlesignals/core/constants/app_constants.dart';
import 'package:littlesignals/models/balloon_data.dart';
import 'package:littlesignals/models/impulsivity_result.dart';
import 'package:littlesignals/providers/app_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'impulsivity_test_state.dart';

part 'impulsivity_test_provider.g.dart';

/// 충동성 테스트 컨트롤러
///
/// 게임 로직을 담당합니다.
@riverpod
class ImpulsivityTestController extends _$ImpulsivityTestController {
  final Random _random = Random();
  Timer? _introTimer;
  Timer? _balloonTimer;
  Timer? _spawnTimer;
  bool _isDisposed = false;

  @override
  ImpulsivityTestState build() {
    ref.onDispose(() {
      _isDisposed = true;
      _introTimer?.cancel();
      _balloonTimer?.cancel();
      _spawnTimer?.cancel();
    });

    return const ImpulsivityTestState();
  }

  /// 게임 시작 (인트로 후)
  void startGame() {
    _introTimer = Timer(const Duration(seconds: 2), () {
      if (_isDisposed) return;
      state = state.copyWith(gameState: ImpulsivityGameState.playing);
      _scheduleNextBalloon();
    });
  }

  void _scheduleNextBalloon() {
    if (_isDisposed) return;
    if (state.gameState != ImpulsivityGameState.playing) return;
    if (state.stimuliCount >= AppConstants.impulsivityTotalStimuli) {
      _finishTest();
      return;
    }

    final delay =
        AppConstants.impulsivityMinIntervalMs +
        _random.nextInt(
          AppConstants.impulsivityMaxIntervalMs -
              AppConstants.impulsivityMinIntervalMs,
        );

    _spawnTimer = Timer(Duration(milliseconds: delay), () {
      if (_isDisposed) return;
      _spawnBalloon();
    });
  }

  void _spawnBalloon() {
    if (_isDisposed) return;

    final isBlue = _random.nextDouble() < AppConstants.impulsivityBlueRatio;
    final x = _random.nextDouble() * 60 + 20;
    final y = _random.nextDouble() * 50 + 20;

    final balloon = BalloonData(
      id: DateTime.now().millisecondsSinceEpoch,
      isBlue: isBlue,
      x: x,
      y: y,
      spawnTime: DateTime.now(),
    );

    state = state.copyWith(currentBalloon: balloon);

    _balloonTimer = Timer(
      const Duration(milliseconds: AppConstants.impulsivityBalloonDurationMs),
      () {
        if (_isDisposed) return;
        _handleTimeout(balloon.id, isBlue);
      },
    );
  }

  void _handleTimeout(int balloonId, bool isBlue) {
    if (_isDisposed) return;
    if (state.currentBalloon?.id != balloonId) return;

    final newOmissionErrors = isBlue
        ? state.omissionErrors + 1
        : state.omissionErrors;

    state = state.copyWith(
      currentBalloon: null,
      stimuliCount: state.stimuliCount + 1,
      omissionErrors: newOmissionErrors,
    );

    _scheduleNextBalloon();
  }

  /// 풍선 클릭 처리
  void handleBalloonClick() {
    if (state.currentBalloon == null) return;

    _balloonTimer?.cancel();

    final balloon = state.currentBalloon!;
    final reactionTime = DateTime.now()
        .difference(balloon.spawnTime)
        .inMilliseconds;

    if (balloon.isBlue) {
      state = state.copyWith(
        reactionTimes: [...state.reactionTimes, reactionTime],
        currentBalloon: null,
        stimuliCount: state.stimuliCount + 1,
      );
    } else {
      state = state.copyWith(
        commissionErrors: state.commissionErrors + 1,
        currentBalloon: null,
        stimuliCount: state.stimuliCount + 1,
      );
    }

    _scheduleNextBalloon();
  }

  void _finishTest() {
    if (state.isCompleted) return;
    // #region agent log
    developer.log(
      '[DEBUG][HypC,E] ImpulsivityTest _finishTest called',
      name: 'ImpulsivityTest',
    );
    // #endregion

    _balloonTimer?.cancel();
    _spawnTimer?.cancel();

    final avgRT = state.reactionTimes.isNotEmpty
        ? state.reactionTimes.reduce((a, b) => a + b) /
              state.reactionTimes.length
        : 0.0;

    final result = ImpulsivityResult(
      reactionTimeAverage: avgRT,
      commissionErrors: state.commissionErrors,
      omissionErrors: state.omissionErrors,
      totalStimuli: AppConstants.impulsivityTotalStimuli,
      completionStatus: 'completed',
    );

    // #region agent log
    developer.log(
      '[DEBUG][HypC] Before setImpulsivityResult, result=$result',
      name: 'ImpulsivityTest',
    );
    // #endregion
    ref.read(appStateNotifierProvider.notifier).setImpulsivityResult(result);
    // #region agent log
    developer.log(
      '[DEBUG][HypC] After setImpulsivityResult, setting isCompleted=true',
      name: 'ImpulsivityTest',
    );
    // #endregion

    state = state.copyWith(
      gameState: ImpulsivityGameState.finished,
      isCompleted: true,
    );
  }

  /// 테스트 리셋
  void reset() {
    _introTimer?.cancel();
    _balloonTimer?.cancel();
    _spawnTimer?.cancel();
    state = const ImpulsivityTestState();
  }
}
