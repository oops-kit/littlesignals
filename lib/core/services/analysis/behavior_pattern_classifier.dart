import 'package:littlesignals/core/constants/age_norms.dart';
import 'package:littlesignals/models/z_score_result.dart';

/// 행동 패턴 분류 서비스
///
/// SRP: Z점수 기반 행동 패턴 분류만 담당합니다.
class BehaviorPatternClassifier {
  const BehaviorPatternClassifier._();

  /// 주의력 행동 패턴 분류
  ///
  /// [merZ]: MER Z점수
  /// [revisitZ]: 재확인율 Z점수 (방향 반전 적용됨)
  /// [avgReactionTime]: 평균 반응시간 (초)
  /// [rtNorm]: 반응시간 규준값
  static AttentionBehaviorPattern classifyAttentionPattern({
    required double merZ,
    required double revisitZ,
    required double avgReactionTime,
    required AgeRangeNormData rtNorm,
  }) {
    // MER이 평균 이상인지 (z >= 0)
    final isHighMer = merZ >= 0;
    // 재확인율이 평균 이하인지 (z >= 0, 방향 반전 적용됨)
    final isLowRevisit = revisitZ >= 0;
    // 반응시간이 느린지 (중앙값보다 높음)
    final isSlowReaction = avgReactionTime > rtNorm.midValue;

    if (isHighMer && isLowRevisit) {
      // MER 높고 재확인율 낮음
      return isSlowReaction
          ? AttentionBehaviorPattern.carefulExplorer
          : AttentionBehaviorPattern.quickProcessor;
    } else {
      // MER 낮거나 재확인율 높음
      return isSlowReaction
          ? AttentionBehaviorPattern.diligentTrier
          : AttentionBehaviorPattern.energeticExplorer;
    }
  }

  /// 충동성 행동 패턴 분류 (4분면)
  ///
  /// [inhibitionZ]: 억제 비율 Z점수
  /// [isFastReactor]: 반응시간이 또래 평균보다 빠른지
  static ImpulsivityBehaviorPattern classifyImpulsivityPattern({
    required double inhibitionZ,
    required bool isFastReactor,
  }) {
    // 억제 비율이 평균 이상인지 (z >= 0)
    final isHighInhibition = inhibitionZ >= 0;

    if (isFastReactor) {
      // 반응 빠름
      return isHighInhibition
          ? ImpulsivityBehaviorPattern.quickAndControlled
          : ImpulsivityBehaviorPattern.energyFirst;
    } else {
      // 반응 느림
      return isHighInhibition
          ? ImpulsivityBehaviorPattern.calmAndStable
          : ImpulsivityBehaviorPattern.learningAtOwnPace;
    }
  }
}

