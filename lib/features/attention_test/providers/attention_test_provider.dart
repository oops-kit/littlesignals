import 'dart:async';

import 'package:littlesignals/core/constants/app_constants.dart';
import 'package:littlesignals/core/domain/deck_generator.dart';
import 'package:littlesignals/core/domain/event_logger.dart';
import 'package:littlesignals/core/providers/core_providers.dart';
import 'package:littlesignals/core/services/attention/attention_metrics_collector.dart';
import 'package:littlesignals/core/services/attention/card_matching_service.dart';
import 'package:littlesignals/core/utils/countdown_controller.dart';
import 'package:littlesignals/core/utils/event_log_recorder.dart';
import 'package:littlesignals/core/utils/hint_timer_controller.dart';
import 'package:littlesignals/models/card_data.dart';
import 'package:littlesignals/models/attention_result.dart';
import 'package:littlesignals/providers/app_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'attention_test_state.dart';

part 'attention_test_provider.g.dart';

/// 주의력 테스트 컨트롤러
///
/// 게임 흐름을 조율하고, 세부 로직은 전문 서비스에 위임합니다.
/// SRP: 게임 흐름 조율에만 집중
/// DIP: DeckGenerator, EventLogger, 각 서비스는 인터페이스를 통해 사용
@riverpod
class AttentionTestController extends _$AttentionTestController {
  CountdownController? _countdownController;
  HintTimerController? _hintTimerController;
  late DeckGenerator _deckGenerator;
  late EventLogger _logRecorder;
  late AttentionMetricsCollector _metricsCollector;
  late CardMatchingService _matchingService;

  @override
  AttentionTestState build() {
    // DIP: Provider를 통해 의존성 주입
    _deckGenerator = ref.watch(deckGeneratorProvider);
    _logRecorder = EventLogRecorder();

    // SRP: 전문 서비스 초기화
    _metricsCollector = AttentionMetricsCollector(logger: _logRecorder);
    _matchingService = CardMatchingService(logger: _logRecorder);

    ref.onDispose(() {
      _countdownController?.dispose();
      _hintTimerController?.dispose();
    });

    return const AttentionTestState();
  }

  /// 게임 시작 (카운트다운 후)
  void startGame() {
    state = state.copyWith(
      gameState: AttentionGameState.countdown,
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
    state = state.copyWith(
      gameState: AttentionGameState.playing,
      countdownValue: null,
      startTime: DateTime.now(),
    );
    setupLevel(1);
  }

  /// 레벨 초기화
  void setupLevel(int level) {
    final pairCount = level == 1
        ? AppConstants.attentionLevel1Pairs
        : AppConstants.attentionLevel2Pairs;

    final deck = _deckGenerator.generate(pairCount);

    state = state.copyWith(
      level: level,
      cards: deck,
      flippedCardIds: [],
      isProcessing: false,
      hintCardId: null,
    );

    _startHintTimer();
  }

  void _startHintTimer() {
    _hintTimerController?.dispose();

    if (state.isProcessing || state.cards.isEmpty) return;

    _hintTimerController = HintTimerController(
      delaySeconds: AppConstants.attentionHintDelaySeconds,
      hintDurationSeconds: 1,
      onShowHint: () {
        final available = state.cards.indexWhere(
          (c) => !c.isMatched && !state.flippedCardIds.contains(c.id),
        );
        if (available != -1) {
          state = state.copyWith(hintCardId: state.cards[available].id);
        }
      },
      onHideHint: () {
        state = state.copyWith(hintCardId: null);
      },
    );
    _hintTimerController!.start();
  }

  void _cancelHintTimer() {
    _hintTimerController?.cancel();
  }

  /// 카드 클릭 처리
  ///
  /// SRP: 흐름 조율만 담당, 세부 로직은 서비스에 위임
  void handleCardClick(int cardId) {
    if (state.isProcessing) return;

    final now = DateTime.now();
    final cardIndex = state.cards.indexWhere((c) => c.id == cardId);
    if (cardIndex == -1) return;

    final card = state.cards[cardIndex];
    int randomTaps = state.randomTaps;

    // SRP: 무효 터치 감지를 MetricsCollector에 위임
    final invalidTapIncrease = _metricsCollector.checkInvalidTap(
      isFlipped: card.isFlipped,
      isMatched: card.isMatched,
    );

    if (invalidTapIncrease > 0) {
      state = state.copyWith(
        randomTaps: randomTaps + invalidTapIncrease,
        tapRecords: [
          ...state.tapRecords,
          TapRecord(timestamp: now, cardId: cardId),
        ],
        eventLogs: _logRecorder.logs,
      );
      return;
    }

    // SRP: 빠른 터치 감지를 MetricsCollector에 위임
    final rapidTapResult = _metricsCollector.checkRapidTap(
      currentTapTime: now,
      tapRecords: state.tapRecords,
    );
    randomTaps += rapidTapResult.randomTapIncrease;

    _cancelHintTimer();

    // SRP: 즉시 반복 오류 감지를 MetricsCollector에 위임
    final repeatResult = _metricsCollector.checkImmediateRepeat(
      cardId: cardId,
      recentlyFlippedCardIds: state.recentlyFlippedCardIds,
    );

    // 터치 기록 및 상태 업데이트
    final newTapRecords = [
      ...state.tapRecords,
      TapRecord(timestamp: now, cardId: cardId),
    ];

    final newRecentlyFlipped = [...state.recentlyFlippedCardIds, cardId];
    final trimmedRecentlyFlipped = newRecentlyFlipped.length > 4
        ? newRecentlyFlipped.sublist(newRecentlyFlipped.length - 4)
        : newRecentlyFlipped;

    // 전반/후반 터치 횟수 계산
    int firstHalfTaps = state.firstHalfTaps;
    int secondHalfTaps = state.secondHalfTaps;
    if (state.firstHalfEndTime == null) {
      firstHalfTaps++;
    } else {
      secondHalfTaps++;
    }

    // 카드 뒤집기
    final newCards = List<CardData>.from(state.cards);
    newCards[cardIndex] = card.copyWith(isFlipped: true);
    final newFlippedIds = [...state.flippedCardIds, cardId];

    // SRP: 카드 뒤집기 로깅을 MetricsCollector에 위임
    _metricsCollector.logCardFlip(state.level);

    state = state.copyWith(
      cards: newCards,
      flippedCardIds: newFlippedIds,
      hintCardId: null,
      randomTaps: randomTaps,
      immediateRepeatErrors:
          state.immediateRepeatErrors + repeatResult.errorIncrease,
      tapRecords: newTapRecords,
      recentlyFlippedCardIds: trimmedRecentlyFlipped,
      firstHalfTaps: firstHalfTaps,
      secondHalfTaps: secondHalfTaps,
      eventLogs: _logRecorder.logs,
    );

    if (newFlippedIds.length == 2) {
      _processMatch(newFlippedIds);
    } else {
      _startHintTimer();
    }
  }

  /// 매칭 처리
  ///
  /// SRP: CardMatchingService에 매칭 로직 위임
  void _processMatch(List<int> flippedIds) {
    state = state.copyWith(isProcessing: true, moves: state.moves + 1);

    // SRP: 매칭 확인을 CardMatchingService에 위임
    final matchResult = _matchingService.checkMatch(
      cards: state.cards,
      flippedIds: flippedIds,
      currentErrorCount: state.errors,
    );

    state = state.copyWith(eventLogs: _logRecorder.logs);

    if (matchResult == MatchResult.success) {
      Future.delayed(
        const Duration(milliseconds: AppConstants.attentionMatchDelayMs),
        () {
          // SRP: 카드 상태 업데이트를 CardMatchingService에 위임
          final updatedCards = _matchingService.markAsMatched(
            cards: state.cards,
            flippedIds: flippedIds,
          );

          state = state.copyWith(
            cards: updatedCards,
            flippedCardIds: [],
            isProcessing: false,
          );

          _checkCompletion();
        },
      );
    } else {
      state = state.copyWith(errors: state.errors + 1);

      Future.delayed(
        const Duration(milliseconds: AppConstants.attentionNoMatchDelayMs),
        () {
          // SRP: 카드 되돌리기를 CardMatchingService에 위임
          final updatedCards = _matchingService.flipBack(
            cards: state.cards,
            flippedIds: flippedIds,
          );

          state = state.copyWith(
            cards: updatedCards,
            flippedCardIds: [],
            isProcessing: false,
          );

          _startHintTimer();
        },
      );
    }
  }

  void _checkCompletion() {
    // SRP: 완료 확인을 CardMatchingService에 위임
    if (!_matchingService.isAllMatched(state.cards)) {
      _startHintTimer();
      return;
    }

    if (state.level == 1) {
      // 전반부 완료 시간 기록
      _logRecorder.logLevelComplete(1);
      state = state.copyWith(
        firstHalfEndTime: DateTime.now(),
        eventLogs: _logRecorder.logs,
      );

      // 다음 레벨로
      Future.delayed(const Duration(seconds: 1), () {
        setupLevel(2);
      });
    } else {
      // 테스트 완료
      _logRecorder.logLevelComplete(2);
      state = state.copyWith(eventLogs: _logRecorder.logs);
      _finishTest();
    }
  }

  void _finishTest() {
    final now = DateTime.now();
    final duration = state.startTime != null
        ? now.difference(state.startTime!).inMilliseconds / 1000.0
        : 0.0;

    // 전반부/후반부 시간 계산
    double firstHalfDuration = 0.0;
    double secondHalfDuration = 0.0;

    if (state.startTime != null && state.firstHalfEndTime != null) {
      firstHalfDuration =
          state.firstHalfEndTime!.difference(state.startTime!).inMilliseconds /
          1000.0;
      secondHalfDuration =
          now.difference(state.firstHalfEndTime!).inMilliseconds / 1000.0;
    }

    // 테스트 완료 로그 추가
    _logRecorder.logTestComplete(duration);
    final finalLogs = _logRecorder.logs;

    final result = AttentionResult(
      durationSeconds: duration,
      totalMoves: state.moves,
      errors: state.errors,
      completionStatus: CompletionStatus.completed,
      // 관찰 지표
      randomTapCount: state.randomTaps,
      immediateRepeatErrors: state.immediateRepeatErrors,
      firstHalfDurationSeconds: firstHalfDuration,
      secondHalfDurationSeconds: secondHalfDuration,
      firstHalfTaps: state.firstHalfTaps,
      secondHalfTaps: state.secondHalfTaps,
      eventLogs: finalLogs,
    );

    ref.read(appStateNotifierProvider.notifier).setAttentionResult(result);
    state = state.copyWith(
      gameState: AttentionGameState.finished,
      isCompleted: true,
      eventLogs: finalLogs,
    );
  }

  /// 테스트 리셋
  void reset() {
    _countdownController?.dispose();
    _countdownController = null;
    _hintTimerController?.dispose();
    _hintTimerController = null;
    _logRecorder.clear();
    state = const AttentionTestState();
  }
}
