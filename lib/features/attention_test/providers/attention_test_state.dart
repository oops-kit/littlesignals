import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:littlesignals/models/card_data.dart';

part 'attention_test_state.freezed.dart';

/// 주의력 테스트의 상태
@freezed
abstract class AttentionTestState with _$AttentionTestState {
  const factory AttentionTestState({
    @Default(1) int level,
    @Default([]) List<CardData> cards,
    @Default([]) List<int> flippedCardIds,
    @Default(false) bool isProcessing,
    @Default(null) DateTime? startTime,
    @Default(0) int moves,
    @Default(0) int errors,
    @Default(null) int? hintCardId,
    @Default(false) bool isCompleted,
  }) = _AttentionTestState;
}
