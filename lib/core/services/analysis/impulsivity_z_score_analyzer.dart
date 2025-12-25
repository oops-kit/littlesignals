import 'package:littlesignals/core/constants/age_norms.dart';
import 'package:littlesignals/core/services/analysis/behavior_pattern_classifier.dart';
import 'package:littlesignals/core/services/analysis/z_score_label_provider.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/models/impulsivity_result.dart';
import 'package:littlesignals/models/z_score_result.dart';

/// 충동성 테스트 Z점수 분석 서비스
///
/// SRP: 충동성 테스트 결과의 Z점수 분석만 담당합니다.
class ImpulsivityZScoreAnalyzer {
  const ImpulsivityZScoreAnalyzer._();

  /// No-go 비율 (기획서: 25%)
  static const double _noGoRatio = 0.25;

  /// 충동성 테스트 결과 분석
  ///
  /// [result]: 충동성 테스트 결과
  /// [ageMonths]: 아동 월령
  /// [l10n]: 다국어 리소스
  static ImpulsivityAnalysisResult analyze({
    required ImpulsivityResult result,
    required double ageMonths,
    required AppLocalizations l10n,
  }) {
    // No-go 자극 수 계산 (기획서: 전체의 25%)
    final noGoCount = (result.totalStimuli * _noGoRatio).round();

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
    final pattern = BehaviorPatternClassifier.classifyImpulsivityPattern(
      inhibitionZ: inhibitionZ,
      isFastReactor: isFastReactor,
    );

    return ImpulsivityAnalysisResult(
      inhibitionZScore: ZScoreResult(
        zScore: inhibitionZ,
        label: ZScoreLabelProvider.getInhibitionLabel(inhibitionZ, l10n),
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
}


