import 'package:littlesignals/core/constants/age_norms.dart';
import 'package:littlesignals/core/services/analysis/behavior_pattern_classifier.dart';
import 'package:littlesignals/core/services/analysis/z_score_label_provider.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/models/attention_result.dart';
import 'package:littlesignals/models/z_score_result.dart';

/// 주의력 테스트 Z점수 분석 서비스
///
/// SRP: 주의력 테스트 결과의 Z점수 분석만 담당합니다.
class AttentionZScoreAnalyzer {
  const AttentionZScoreAnalyzer._();

  /// 힌트 사용 당 MER 차감 값 (기획서: 0.5점 차감)
  /// MER은 0~1 범위이므로 0.05로 조정 (0.5/10)
  static const double _hintPenaltyPerUse = 0.05;

  /// 주의력 테스트 결과 분석
  ///
  /// [result]: 주의력 테스트 결과
  /// [ageMonths]: 아동 월령
  /// [l10n]: 다국어 리소스
  static AttentionAnalysisResult analyze({
    required AttentionResult result,
    required double ageMonths,
    required AppLocalizations l10n,
  }) {
    // MER 계산: (기준턴수 / 실제턴수)
    final actualTurns = result.totalTurns > 0
        ? result.totalTurns
        : (result.totalMoves / 2).ceil();
    double mer = actualTurns > 0
        ? AttentionAgeNorms.baselineTurns / actualTurns
        : 0.0;

    // 기획서: 힌트 사용 시 점수 가중치 차감
    if (result.hintUsedCount > 0) {
      mer = (mer - (result.hintUsedCount * _hintPenaltyPerUse)).clamp(0.0, 1.0);
    }

    // 재확인율 계산: 재확인 횟수 / 총 이동 횟수
    final revisitingRate = result.totalMoves > 0
        ? result.revisitCount / result.totalMoves
        : 0.0;

    // 평균 반응시간 계산 (초)
    final avgReactionTime = result.reactionTimesMs.isNotEmpty
        ? result.reactionTimesMs.reduce((a, b) => a + b) /
              result.reactionTimesMs.length /
              1000
        : result.durationSeconds /
              (result.totalMoves > 0 ? result.totalMoves : 1);

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
    final pattern = BehaviorPatternClassifier.classifyAttentionPattern(
      merZ: merZ,
      revisitZ: revisitZ,
      avgReactionTime: avgReactionTime,
      rtNorm: rtNorm,
    );

    return AttentionAnalysisResult(
      merZScore: ZScoreResult(
        zScore: merZ,
        label: ZScoreLabelProvider.getMerLabel(merZ, l10n),
        peerMean: merNorm.mean,
        peerStdDev: merNorm.stdDev,
        observedValue: mer,
      ),
      revisitingRateZScore: ZScoreResult(
        zScore: revisitZ,
        label: ZScoreLabelProvider.getRevisitLabel(revisitZ, l10n),
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
}


