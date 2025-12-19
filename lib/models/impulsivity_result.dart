import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:littlesignals/core/domain/test_result.dart';
import 'package:littlesignals/models/test_event_log.dart';

part 'impulsivity_result.freezed.dart';
part 'impulsivity_result.g.dart';

@freezed
abstract class ImpulsivityResult
    with _$ImpulsivityResult
    implements TestResult {
  const factory ImpulsivityResult({
    required double reactionTimeAverage,
    required int commissionErrors,
    required int omissionErrors,
    required int totalStimuli,
    required String completionStatus,

    /// 예측 반응 횟수 (풍선이 뜨기 전에 화면을 누른 횟수)
    @Default(0) int anticipatoryResponses,

    /// 개별 반응 시간 목록 (분석용)
    @Default([]) List<int> reactionTimes,

    /// 테스트 중 발생한 이벤트 로그
    @Default([]) List<TestEventLog> eventLogs,
  }) = _ImpulsivityResult;

  const ImpulsivityResult._();

  factory ImpulsivityResult.fromJson(Map<String, dynamic> json) =>
      _$ImpulsivityResultFromJson(json);

  /// TestResult 인터페이스 구현
  /// ImpulsivityResult는 durationSeconds 필드가 없으므로 반응 시간 기반으로 계산
  @override
  double get durationSeconds => reactionTimes.isNotEmpty
      ? reactionTimes.reduce((a, b) => a + b) / 1000.0
      : 0.0;

  @override
  String get completionStatusString => completionStatus;

  @override
  bool get isCompleted => completionStatus == 'completed';
}
