import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:littlesignals/models/balloon_data.dart';
import 'package:littlesignals/models/test_event_log.dart';

part 'impulsivity_test_state.freezed.dart';

/// 충동성 테스트의 상태
@freezed
abstract class ImpulsivityTestState with _$ImpulsivityTestState {
  const factory ImpulsivityTestState({
    @Default(ImpulsivityGameState.intro) ImpulsivityGameState gameState,
    @Default(null) BalloonData? currentBalloon,
    @Default(0) int stimuliCount,
    @Default(0) int commissionErrors,
    @Default(0) int omissionErrors,
    @Default([]) List<int> reactionTimes,
    @Default(false) bool isCompleted,

    /// 예측 반응 횟수 (풍선이 뜨기 전에 화면을 누른 횟수)
    @Default(0) int anticipatoryResponses,

    /// 테스트 시작 시간
    @Default(null) DateTime? startTime,

    /// 이벤트 로그 (테스트 중 발생한 모든 이벤트)
    @Default([]) List<TestEventLog> eventLogs,

    /// 카운트다운 값 (3, 2, 1)
    @Default(null) int? countdownValue,
  }) = _ImpulsivityTestState;
}
