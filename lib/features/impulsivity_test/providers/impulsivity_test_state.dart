import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:littlesignals/models/balloon_data.dart';

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
  }) = _ImpulsivityTestState;
}
