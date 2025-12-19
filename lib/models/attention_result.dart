import 'package:freezed_annotation/freezed_annotation.dart';

part 'attention_result.freezed.dart';
part 'attention_result.g.dart';

enum CompletionStatus {
  @JsonValue('completed')
  completed,
  @JsonValue('abandoned')
  abandoned,
}

@freezed
abstract class AttentionResult with _$AttentionResult {
  const factory AttentionResult({
    required double durationSeconds,
    required int totalMoves,
    required int errors,
    required CompletionStatus completionStatus,
  }) = _AttentionResult;

  factory AttentionResult.fromJson(Map<String, dynamic> json) =>
      _$AttentionResultFromJson(json);
}
