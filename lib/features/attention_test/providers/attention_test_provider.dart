import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:littlesignals/core/constants/app_constants.dart';
import 'package:littlesignals/models/card_data.dart';
import 'package:littlesignals/models/attention_result.dart';
import 'package:littlesignals/providers/app_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'attention_test_state.dart';

part 'attention_test_provider.g.dart';

/// 무작위 터치 감지 기준 (ms)
const _rapidTapThresholdMs = 300;

/// 주의력 테스트 컨트롤러
///
/// 게임 로직을 담당합니다.
@riverpod
class AttentionTestController extends _$AttentionTestController {
  Timer? _hintTimer;

  static const _icons = [
    Icons.pets,
    Icons.cruelty_free,
    Icons.emoji_nature,
    Icons.water,
  ];

  @override
  AttentionTestState build() {
    ref.onDispose(() {
      _hintTimer?.cancel();
    });

    return AttentionTestState(startTime: DateTime.now());
  }

  /// 레벨 초기화
  void setupLevel(int level) {
    final pairCount = level == 1
        ? AppConstants.attentionLevel1Pairs
        : AppConstants.attentionLevel2Pairs;
    final selectedIcons = _icons.sublist(0, pairCount);

    List<CardData> deck = [];
    for (int i = 0; i < selectedIcons.length; i++) {
      deck.add(CardData(id: i * 2, icon: selectedIcons[i], name: 'animal-$i'));
      deck.add(
        CardData(id: i * 2 + 1, icon: selectedIcons[i], name: 'animal-$i'),
      );
    }
    deck.shuffle();

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
    _hintTimer?.cancel();

    if (state.isProcessing || state.cards.isEmpty) return;

    _hintTimer = Timer(
      const Duration(seconds: AppConstants.attentionHintDelaySeconds),
      () {
        final available = state.cards.indexWhere(
          (c) => !c.isMatched && !state.flippedCardIds.contains(c.id),
        );
        if (available != -1) {
          state = state.copyWith(hintCardId: state.cards[available].id);
          Future.delayed(const Duration(seconds: 1), () {
            state = state.copyWith(hintCardId: null);
          });
        }
      },
    );
  }

  /// 카드 클릭 처리
  void handleCardClick(int cardId) {
    if (state.isProcessing) return;

    final now = DateTime.now();
    final cardIndex = state.cards.indexWhere((c) => c.id == cardId);
    if (cardIndex == -1) return;

    final card = state.cards[cardIndex];

    // === 무작위 터치 감지 (유효하지 않은 터치 포함) ===
    int randomTaps = state.randomTaps;

    // 1. 이미 뒤집힌 카드나 매치된 카드를 터치 = 무작위 터치
    if (card.isFlipped || card.isMatched) {
      randomTaps++;
      state = state.copyWith(
        randomTaps: randomTaps,
        tapRecords: [
          ...state.tapRecords,
          TapRecord(timestamp: now, cardId: cardId),
        ],
      );
      return;
    }

    // 2. 짧은 시간 내 연속 터치 = 무작위 터치 (생각 없이 빠르게 누르는 경우)
    if (state.tapRecords.isNotEmpty) {
      final lastTap = state.tapRecords.last;
      final timeDiff = now.difference(lastTap.timestamp).inMilliseconds;
      if (timeDiff < _rapidTapThresholdMs) {
        randomTaps++;
      }
    }

    _hintTimer?.cancel();

    // === 다른 관찰 지표 수집 ===
    int immediateRepeatErrors = state.immediateRepeatErrors;

    // 즉시 반복 오류: 방금 확인한 카드를 바로 다시 터치
    // (이미 뒤집혀서 다시 뒤집힌 카드를 바로 터치하는 경우)
    if (state.recentlyFlippedCardIds.contains(cardId)) {
      immediateRepeatErrors++;
    }

    // 터치 기록 추가
    final newTapRecords = [
      ...state.tapRecords,
      TapRecord(timestamp: now, cardId: cardId),
    ];

    // 최근 뒤집은 카드 목록 업데이트 (최대 4개 유지)
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

    state = state.copyWith(
      cards: newCards,
      flippedCardIds: newFlippedIds,
      hintCardId: null,
      randomTaps: randomTaps,
      immediateRepeatErrors: immediateRepeatErrors,
      tapRecords: newTapRecords,
      recentlyFlippedCardIds: trimmedRecentlyFlipped,
      firstHalfTaps: firstHalfTaps,
      secondHalfTaps: secondHalfTaps,
    );

    if (newFlippedIds.length == 2) {
      _processMatch(newFlippedIds);
    } else {
      _startHintTimer();
    }
  }

  void _processMatch(List<int> flippedIds) {
    state = state.copyWith(isProcessing: true, moves: state.moves + 1);

    final card1 = state.cards.firstWhere((c) => c.id == flippedIds[0]);
    final card2 = state.cards.firstWhere((c) => c.id == flippedIds[1]);

    if (card1.name == card2.name) {
      // 매칭 성공
      Future.delayed(
        const Duration(milliseconds: AppConstants.attentionMatchDelayMs),
        () {
          final updatedCards = state.cards.map((c) {
            if (flippedIds.contains(c.id)) {
              return c.copyWith(isMatched: true);
            }
            return c;
          }).toList();

          state = state.copyWith(
            cards: updatedCards,
            flippedCardIds: [],
            isProcessing: false,
          );

          _checkCompletion();
        },
      );
    } else {
      // 매칭 실패
      state = state.copyWith(errors: state.errors + 1);

      Future.delayed(
        const Duration(milliseconds: AppConstants.attentionNoMatchDelayMs),
        () {
          final updatedCards = state.cards.map((c) {
            if (flippedIds.contains(c.id)) {
              return c.copyWith(isFlipped: false);
            }
            return c;
          }).toList();

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
    if (!state.cards.every((c) => c.isMatched)) {
      _startHintTimer();
      return;
    }

    if (state.level == 1) {
      // 전반부 완료 시간 기록
      state = state.copyWith(firstHalfEndTime: DateTime.now());

      // 다음 레벨로
      Future.delayed(const Duration(seconds: 1), () {
        setupLevel(2);
      });
    } else {
      // 테스트 완료
      _finishTest();
    }
  }

  void _finishTest() {
    // #region agent log
    developer.log(
      '[DEBUG][HypC,E] AttentionTest _finishTest called',
      name: 'AttentionTest',
    );
    // #endregion
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
    );

    // #region agent log
    developer.log(
      '[DEBUG][HypC] Before setAttentionResult, result=$result',
      name: 'AttentionTest',
    );
    // #endregion
    ref.read(appStateNotifierProvider.notifier).setAttentionResult(result);
    // #region agent log
    developer.log(
      '[DEBUG][HypC] After setAttentionResult, setting isCompleted=true',
      name: 'AttentionTest',
    );
    // #endregion
    state = state.copyWith(isCompleted: true);
  }

  /// 테스트 리셋
  void reset() {
    _hintTimer?.cancel();
    state = AttentionTestState(startTime: DateTime.now());
  }
}
