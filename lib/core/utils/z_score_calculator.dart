import 'package:littlesignals/core/constants/age_norms.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/models/attention_result.dart';
import 'package:littlesignals/models/impulsivity_result.dart';
import 'package:littlesignals/models/z_score_result.dart';

/// Z점수 계산 유틸리티
///
/// 아동의 테스트 결과를 월령별 규준값과 비교하여 Z점수를 계산합니다.
class ZScoreCalculator {
  const ZScoreCalculator._();

  /// 주의력 테스트 결과 분석
  static AttentionAnalysisResult analyzeAttentionResult({
    required AttentionResult result,
    required double ageMonths,
    required AppLocalizations l10n,
  }) {
    // MER 계산: (기준턴수 / 실제턴수)
    final actualTurns = result.totalTurns > 0
        ? result.totalTurns
        : (result.totalMoves / 2).ceil();
    final mer = actualTurns > 0
        ? AttentionAgeNorms.baselineTurns / actualTurns
        : 0.0;

    // 재확인율 계산: 재확인 횟수 / 총 이동 횟수
    final revisitingRate = result.totalMoves > 0
        ? result.revisitCount / result.totalMoves
        : 0.0;

    // 평균 반응시간 계산 (초)
    final avgReactionTime = result.reactionTimesMs.isNotEmpty
        ? result.reactionTimesMs.reduce((a, b) => a + b) /
            result.reactionTimesMs.length /
            1000
        : result.durationSeconds / (result.totalMoves > 0 ? result.totalMoves : 1);

    // 규준값 가져오기
    final merNorm = AttentionAgeNorms.getMerNorm(ageMonths);
    final revisitNorm = AttentionAgeNorms.getRevisitingRateNorm(ageMonths);
    final rtNorm = AttentionAgeNorms.getReactionTimeNorm(ageMonths);

    // Z점수 계산
    final merZ = merNorm.calculateZScore(mer);
    final revisitZ = revisitNorm.calculateZScore(
      revisitingRate,
      invertDirection: true,
    );

    // 행동 패턴 분류
    final pattern = _classifyAttentionPattern(
      merZ: merZ,
      revisitZ: revisitZ,
      avgReactionTime: avgReactionTime,
      rtNorm: rtNorm,
    );

    return AttentionAnalysisResult(
      merZScore: ZScoreResult(
        zScore: merZ,
        label: _getMerLabel(merZ, l10n),
        peerMean: merNorm.mean,
        peerStdDev: merNorm.stdDev,
        observedValue: mer,
      ),
      revisitingRateZScore: ZScoreResult(
        zScore: revisitZ,
        label: _getRevisitLabel(revisitZ, l10n),
        peerMean: revisitNorm.mean,
        peerStdDev: revisitNorm.stdDev,
        observedValue: revisitingRate,
      ),
      behaviorPattern: pattern,
      mer: mer,
      revisitingRate: revisitingRate,
      avgReactionTime: avgReactionTime,
      isReactionTimeNormal: rtNorm.isWithinRange(avgReactionTime),
    );
  }

  /// 충동성 테스트 결과 분석
  static ImpulsivityAnalysisResult analyzeImpulsivityResult({
    required ImpulsivityResult result,
    required double ageMonths,
    required AppLocalizations l10n,
  }) {
    // No-go 자극 수 계산 (전체의 약 30%)
    final noGoCount = (result.totalStimuli * 0.3).round();

    // 억제 비율 계산: (정확히 억제한 수) / (No-Go 총 수)
    final correctInhibitions = noGoCount - result.commissionErrors;
    final inhibitionRate = noGoCount > 0 ? correctInhibitions / noGoCount : 0.0;

    // 평균 반응시간 (ms)
    final avgReactionTime = result.reactionTimeAverage;

    // 규준값 가져오기
    final inhibitionNorm = ImpulsivityAgeNorms.getInhibitionRateNorm(ageMonths);
    final rtNorm = ImpulsivityAgeNorms.getReactionTimeNorm(ageMonths);

    // Z점수 계산
    final inhibitionZ = inhibitionNorm.calculateZScore(inhibitionRate);

    // 반응시간이 또래 평균보다 빠른지 판단
    final isFastReactor = avgReactionTime < rtNorm.mean;

    // 행동 패턴 분류
    final pattern = _classifyImpulsivityPattern(
      inhibitionZ: inhibitionZ,
      isFastReactor: isFastReactor,
    );

    return ImpulsivityAnalysisResult(
      inhibitionZScore: ZScoreResult(
        zScore: inhibitionZ,
        label: _getInhibitionLabel(inhibitionZ, l10n),
        peerMean: inhibitionNorm.mean,
        peerStdDev: inhibitionNorm.stdDev,
        observedValue: inhibitionRate,
      ),
      behaviorPattern: pattern,
      inhibitionRate: inhibitionRate,
      avgReactionTime: avgReactionTime,
      isFastReactor: isFastReactor,
    );
  }

  /// 주의력 행동 패턴 분류
  static AttentionBehaviorPattern _classifyAttentionPattern({
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
  static ImpulsivityBehaviorPattern _classifyImpulsivityPattern({
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

  /// MER Z점수에 대한 부모용 라벨
  static String _getMerLabel(double z, AppLocalizations l10n) {
    if (z >= -1 && z <= 1) {
      return l10n.peerAverage;
    } else if (z > 1) {
      return l10n.highMemoryEfficiency;
    } else {
      return l10n.developingMemory;
    }
  }

  /// 재확인율 Z점수에 대한 부모용 라벨
  static String _getRevisitLabel(double z, AppLocalizations l10n) {
    if (z >= -1 && z <= 1) {
      return l10n.peerAverage;
    } else if (z > 1) {
      return l10n.stableMemory;
    } else {
      return l10n.activeExploration;
    }
  }

  /// 억제 비율 Z점수에 대한 부모용 라벨
  static String _getInhibitionLabel(double z, AppLocalizations l10n) {
    if (z >= -1 && z <= 1) {
      return l10n.peerAverage;
    } else if (z > 1) {
      return l10n.goodSelfControl;
    } else {
      return l10n.highEnergy;
    }
  }

  /// Z점수를 시각화용 위치값(0-100)으로 변환
  /// Z점수 -2 ~ +2 범위를 0 ~ 100으로 매핑
  static double zScoreToVisualPosition(double zScore) {
    // Z점수를 -2 ~ +2 범위로 클램핑
    final clampedZ = zScore.clamp(-2.0, 2.0);
    // 0-100 범위로 변환 (0 = -2, 50 = 0, 100 = +2)
    return ((clampedZ + 2) / 4) * 100;
  }
}


