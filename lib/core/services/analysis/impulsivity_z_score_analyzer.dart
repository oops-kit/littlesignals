import 'dart:developer' as dev;

import 'package:littlesignals/core/constants/age_norms.dart';
import 'package:littlesignals/core/constants/algorithm_config.dart';
import 'package:littlesignals/core/domain/event_logger.dart';
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

  /// 충동성 테스트 결과 분석
  ///
  /// [result]: 충동성 테스트 결과
  /// [ageMonths]: 아동 월령
  /// [l10n]: 다국어 리소스
  /// [logger]: 이벤트 로거 (옵션)
  static ImpulsivityAnalysisResult analyze({
    required ImpulsivityResult result,
    required double ageMonths,
    required AppLocalizations l10n,
    EventLogger? logger,
  }) {
    dev.log('=== 충동성 Z점수 분석 시작 ===', name: 'ImpulsivityZScore');
    dev.log('월령: $ageMonths개월', name: 'ImpulsivityZScore');

    logger?.logZScoreInfo('━━━ 충동성 Z점수 분석 ━━━');
    logger?.logZScoreInfo('📊 월령: $ageMonths개월');

    // No-go 자극 수 계산 (기획서: 전체의 25%)
    final noGoRatio = ImpulsivityAlgorithmConfig.noGoRatio;
    final noGoCount = (result.totalStimuli * noGoRatio).round();

    dev.log('자극 정보:', name: 'ImpulsivityZScore');
    dev.log('  총 자극 수: ${result.totalStimuli}', name: 'ImpulsivityZScore');
    dev.log('  No-go 자극 수 (${(noGoRatio * 100).toInt()}%): $noGoCount', name: 'ImpulsivityZScore');
    dev.log('  실수 오류: ${result.commissionErrors}', name: 'ImpulsivityZScore');
    dev.log('  누락 오류: ${result.omissionErrors}', name: 'ImpulsivityZScore');

    logger?.logZScoreInfo('');
    logger?.logZScoreInfo('🎈 자극 정보');
    logger?.logZScoreInfo('  총 자극: ${result.totalStimuli}회');
    logger?.logZScoreInfo('  파란 풍선(Go): ${result.totalStimuli - noGoCount}회');
    logger?.logZScoreInfo('  빨간 풍선(No-go): $noGoCount회');
    logger?.logZScoreInfo('  실수 오류: ${result.commissionErrors}회');
    logger?.logZScoreInfo('  누락 오류: ${result.omissionErrors}회');

    // 억제 비율 계산: (정확히 억제한 수) / (No-Go 총 수)
    final correctInhibitions = noGoCount - result.commissionErrors;
    final inhibitionRate = noGoCount > 0 ? correctInhibitions / noGoCount : 0.0;

    dev.log('억제 비율 계산:', name: 'ImpulsivityZScore');
    dev.log('  정확히 억제한 수: $correctInhibitions', name: 'ImpulsivityZScore');
    dev.log('  억제 비율: ${(inhibitionRate * 100).toStringAsFixed(1)}%', name: 'ImpulsivityZScore');

    logger?.logZScoreInfo('');
    logger?.logZScoreInfo('🛑 억제 비율 계산');
    logger?.logZScoreInfo('  정확히 억제: $correctInhibitions회');
    logger?.logZScoreInfo('  억제 비율: ${(inhibitionRate * 100).toStringAsFixed(1)}%');

    // 평균 반응시간 (ms)
    final avgReactionTime = result.reactionTimeAverage;

    dev.log('평균 반응시간: ${avgReactionTime.toStringAsFixed(0)}ms', name: 'ImpulsivityZScore');
    
    logger?.logZScoreInfo('');
    logger?.logZScoreInfo('⏱️ 평균 반응시간: ${avgReactionTime.toStringAsFixed(0)}ms');

    // Go 자극 수 계산 (파란 풍선)
    final goCount = result.totalStimuli - noGoCount;

    // 부주의 비율 계산: omissionErrors / Go자극수
    final omissionRate = goCount > 0 ? result.omissionErrors / goCount : 0.0;

    dev.log('부주의 비율 계산:', name: 'ImpulsivityZScore');
    dev.log('  Go 자극 수: $goCount', name: 'ImpulsivityZScore');
    dev.log('  부주의 비율: ${(omissionRate * 100).toStringAsFixed(1)}%', name: 'ImpulsivityZScore');

    logger?.logZScoreInfo('');
    logger?.logZScoreInfo('👀 부주의 비율 계산');
    logger?.logZScoreInfo('  Go 자극 수: $goCount');
    logger?.logZScoreInfo('  부주의 비율: ${(omissionRate * 100).toStringAsFixed(1)}%');

    // 규준값 가져오기
    final inhibitionNorm = ImpulsivityAgeNorms.getInhibitionRateNorm(ageMonths);
    final omissionNorm = ImpulsivityAgeNorms.getOmissionRateNorm(ageMonths);
    final rtNorm = ImpulsivityAgeNorms.getReactionTimeNorm(ageMonths);

    dev.log('규준값:', name: 'ImpulsivityZScore');
    dev.log('  억제비율 또래평균(μ): ${(inhibitionNorm.mean * 100).toStringAsFixed(1)}%, 표준편차(σ): ${(inhibitionNorm.stdDev * 100).toStringAsFixed(1)}%', name: 'ImpulsivityZScore');
    dev.log('  부주의비율 또래평균(μ): ${(omissionNorm.mean * 100).toStringAsFixed(1)}%, 표준편차(σ): ${(omissionNorm.stdDev * 100).toStringAsFixed(1)}%', name: 'ImpulsivityZScore');
    dev.log('  반응시간 또래평균(μ): ${rtNorm.mean.toStringAsFixed(0)}ms, 표준편차(σ): ${rtNorm.stdDev.toStringAsFixed(0)}ms', name: 'ImpulsivityZScore');

    logger?.logZScoreInfo('');
    logger?.logZScoreInfo('📐 또래 규준값 (${inhibitionNorm.minMonths}~${inhibitionNorm.maxMonths}개월)');
    logger?.logZScoreInfo('  억제비율 평균(μ): ${(inhibitionNorm.mean * 100).toStringAsFixed(1)}%');
    logger?.logZScoreInfo('  억제비율 표준편차(σ): ${(inhibitionNorm.stdDev * 100).toStringAsFixed(1)}%');
    logger?.logZScoreInfo('  부주의비율 평균(μ): ${(omissionNorm.mean * 100).toStringAsFixed(1)}%');
    logger?.logZScoreInfo('  부주의비율 표준편차(σ): ${(omissionNorm.stdDev * 100).toStringAsFixed(1)}%');
    logger?.logZScoreInfo('  반응시간 평균(μ): ${rtNorm.mean.toStringAsFixed(0)}ms');
    logger?.logZScoreInfo('  반응시간 표준편차(σ): ${rtNorm.stdDev.toStringAsFixed(0)}ms');

    // Z점수 계산
    final inhibitionZ = inhibitionNorm.calculateZScore(inhibitionRate);
    // 부주의 비율은 낮을수록 좋으므로 방향 반전
    final omissionZ = omissionNorm.calculateZScore(omissionRate, invertDirection: true);

    dev.log('억제 비율 Z점수: ${inhibitionZ.toStringAsFixed(3)}', name: 'ImpulsivityZScore');
    dev.log('부주의 비율 Z점수: ${omissionZ.toStringAsFixed(3)}', name: 'ImpulsivityZScore');
    
    logger?.logZScoreInfo('');
    logger?.logZScoreInfo('📊 Z점수 계산 결과');
    logger?.logZScoreInfo('  억제 비율 Z점수: ${inhibitionZ.toStringAsFixed(3)}');
    logger?.logZScoreInfo('  부주의 비율 Z점수: ${omissionZ.toStringAsFixed(3)}');

    // 반응시간이 또래 평균보다 빠른지 판단
    final isFastReactor = avgReactionTime < rtNorm.mean;

    dev.log('반응 속도: ${isFastReactor ? "빠름" : "느림"} (또래 평균 대비)', name: 'ImpulsivityZScore');
    
    logger?.logZScoreInfo('  반응 속도: ${isFastReactor ? "⚡ 빠름" : "🐢 느림"} (또래 대비)');

    // 행동 패턴 분류
    final pattern = BehaviorPatternClassifier.classifyImpulsivityPattern(
      inhibitionZ: inhibitionZ,
      isFastReactor: isFastReactor,
    );

    final inhibitionLabel = ZScoreLabelProvider.getInhibitionLabel(inhibitionZ, l10n);
    final omissionLabel = ZScoreLabelProvider.getOmissionLabel(omissionZ, l10n);

    dev.log('억제 비율 라벨: $inhibitionLabel', name: 'ImpulsivityZScore');
    dev.log('부주의 비율 라벨: $omissionLabel', name: 'ImpulsivityZScore');
    dev.log('행동 패턴: ${pattern.name}', name: 'ImpulsivityZScore');
    dev.log('=== 충동성 Z점수 분석 완료 ===\n', name: 'ImpulsivityZScore');

    if (logger != null) {
      logger.logZScoreInfo('');
      logger.logZScoreInfo('🎯 행동 패턴: ${_getPatternKoreanName(pattern)}');
      logger.logZScoreInfo('━━━━━━━━━━━━━━━━━━');
    }

    return ImpulsivityAnalysisResult(
      inhibitionZScore: ZScoreResult(
        zScore: inhibitionZ,
        label: inhibitionLabel,
        peerMean: inhibitionNorm.mean,
        peerStdDev: inhibitionNorm.stdDev,
        observedValue: inhibitionRate,
      ),
      omissionZScore: ZScoreResult(
        zScore: omissionZ,
        label: omissionLabel,
        peerMean: omissionNorm.mean,
        peerStdDev: omissionNorm.stdDev,
        observedValue: omissionRate,
      ),
      behaviorPattern: pattern,
      inhibitionRate: inhibitionRate,
      omissionRate: omissionRate,
      avgReactionTime: avgReactionTime,
      isFastReactor: isFastReactor,
    );
  }

  /// 행동 패턴 한국어 이름 반환
  static String _getPatternKoreanName(ImpulsivityBehaviorPattern pattern) {
    switch (pattern) {
      case ImpulsivityBehaviorPattern.quickAndControlled:
        return '빠르고 절제된';
      case ImpulsivityBehaviorPattern.energyFirst:
        return '에너지 우선형';
      case ImpulsivityBehaviorPattern.calmAndStable:
        return '차분하고 안정적';
      case ImpulsivityBehaviorPattern.learningAtOwnPace:
        return '자기 속도로 배우는';
    }
  }
}
