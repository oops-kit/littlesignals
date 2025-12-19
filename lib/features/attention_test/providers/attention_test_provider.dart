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

    final cardIndex = state.cards.indexWhere((c) => c.id == cardId);
    if (cardIndex == -1) return;

    final card = state.cards[cardIndex];
    if (card.isFlipped || card.isMatched) return;

    _hintTimer?.cancel();

    // 카드 뒤집기
    final newCards = List<CardData>.from(state.cards);
    newCards[cardIndex] = card.copyWith(isFlipped: true);

    final newFlippedIds = [...state.flippedCardIds, cardId];

    state = state.copyWith(
      cards: newCards,
      flippedCardIds: newFlippedIds,
      hintCardId: null,
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
    final duration = state.startTime != null
        ? DateTime.now().difference(state.startTime!).inMilliseconds / 1000.0
        : 0.0;

    final result = AttentionResult(
      durationSeconds: duration,
      totalMoves: state.moves,
      errors: state.errors,
      completionStatus: CompletionStatus.completed,
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
