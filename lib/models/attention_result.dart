import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:littlesignals/core/domain/test_result.dart';
import 'package:littlesignals/models/test_event_log.dart';

part 'attention_result.freezed.dart';
part 'attention_result.g.dart';

enum CompletionStatus {
  @JsonValue('completed')
  completed,
  @JsonValue('abandoned')
  abandoned,
}

@freezed
abstract class AttentionResult with _$AttentionResult implements TestResult {
  const factory AttentionResult({
    required double durationSeconds,
    required int totalMoves,
    required int errors,
    required CompletionStatus completionStatus,
    // === 관찰 지표 ===
    /// 무작위 터치 횟수 (주의력 결핍 신호)
    @Default(0) int randomTapCount,

    /// 즉시 반복 오류 (작업기억 한계)
    @Default(0) int immediateRepeatErrors,

    /// 전반부 소요 시간 (초)
    @Default(0.0) double firstHalfDurationSeconds,

    /// 후반부 소요 시간 (초)
    @Default(0.0) double secondHalfDurationSeconds,

    /// 전반부 터치 횟수
    @Default(0) int firstHalfTaps,

    /// 후반부 터치 횟수
    @Default(0) int secondHalfTaps,

    /// 테스트 중 발생한 이벤트 로그
    @Default([]) List<TestEventLog> eventLogs,
  }) = _AttentionResult;

  const AttentionResult._();

  factory AttentionResult.fromJson(Map<String, dynamic> json) =>
      _$AttentionResultFromJson(json);

  /// TestResult 인터페이스 구현
  @override
  String get completionStatusString => completionStatus.name;

  @override
  bool get isCompleted => completionStatus == CompletionStatus.completed;
}
