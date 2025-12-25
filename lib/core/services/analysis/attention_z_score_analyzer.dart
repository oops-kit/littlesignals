import 'dart:developer' as dev;

import 'package:littlesignals/core/constants/age_norms.dart';
import 'package:littlesignals/core/domain/event_logger.dart';
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
  /// [logger]: 이벤트 로거 (옵션)
  static AttentionAnalysisResult analyze({
    required AttentionResult result,
    required double ageMonths,
    required AppLocalizations l10n,
    EventLogger? logger,
  }) {
    dev.log('=== 주의력 Z점수 분석 시작 ===', name: 'AttentionZScore');
    dev.log('월령: $ageMonths개월', name: 'AttentionZScore');
    
    logger?.logZScoreInfo('━━━ 주의력 Z점수 분석 ━━━');
    logger?.logZScoreInfo('📊 월령: $ageMonths개월');

    // MER 계산: (기준턴수 / 실제턴수)
    final actualTurns = result.totalTurns > 0
        ? result.totalTurns
        : (result.totalMoves / 2).ceil();
    double mer = actualTurns > 0
        ? AttentionAgeNorms.baselineTurns / actualTurns
        : 0.0;

    dev.log('MER 계산:', name: 'AttentionZScore');
    dev.log('  기준턴수: ${AttentionAgeNorms.baselineTurns}', name: 'AttentionZScore');
    dev.log('  실제턴수: $actualTurns', name: 'AttentionZScore');
    dev.log('  MER (원본): ${mer.toStringAsFixed(4)}', name: 'AttentionZScore');

    logger?.logZScoreInfo('');
    logger?.logZScoreInfo('📈 MER (기억 효율성) 계산');
    logger?.logZScoreInfo('  기준턴수: ${AttentionAgeNorms.baselineTurns}턴');
    logger?.logZScoreInfo('  실제턴수: $actualTurns턴');
    logger?.logZScoreInfo('  MER: ${mer.toStringAsFixed(4)}');

    // 기획서: 힌트 사용 시 점수 가중치 차감
    if (result.hintUsedCount > 0) {
      final beforePenalty = mer;
      mer = (mer - (result.hintUsedCount * _hintPenaltyPerUse)).clamp(0.0, 1.0);
      dev.log('  힌트 사용 횟수: ${result.hintUsedCount}', name: 'AttentionZScore');
      dev.log('  힌트 페널티 전: ${beforePenalty.toStringAsFixed(4)}', name: 'AttentionZScore');
      dev.log('  힌트 페널티 후: ${mer.toStringAsFixed(4)}', name: 'AttentionZScore');
      
      logger?.logZScoreInfo('  💡 힌트 사용: ${result.hintUsedCount}회');
      logger?.logZScoreInfo('  페널티 적용 후 MER: ${mer.toStringAsFixed(4)}');
    }

    // 재확인율 계산: 재확인 횟수 / 총 이동 횟수
    final revisitingRate = result.totalMoves > 0
        ? result.revisitCount / result.totalMoves
        : 0.0;

    dev.log('재확인율 계산:', name: 'AttentionZScore');
    dev.log('  재확인 횟수: ${result.revisitCount}', name: 'AttentionZScore');
    dev.log('  총 이동 횟수: ${result.totalMoves}', name: 'AttentionZScore');
    dev.log('  재확인율: ${revisitingRate.toStringAsFixed(4)}', name: 'AttentionZScore');

    logger?.logZScoreInfo('');
    logger?.logZScoreInfo('🔄 재확인율 계산');
    logger?.logZScoreInfo('  재확인 횟수: ${result.revisitCount}회');
    logger?.logZScoreInfo('  총 이동 횟수: ${result.totalMoves}회');
    logger?.logZScoreInfo('  재확인율: ${(revisitingRate * 100).toStringAsFixed(1)}%');

    // 평균 반응시간 계산 (초)
    final avgReactionTime = result.reactionTimesMs.isNotEmpty
        ? result.reactionTimesMs.reduce((a, b) => a + b) /
              result.reactionTimesMs.length /
              1000
        : result.durationSeconds /
              (result.totalMoves > 0 ? result.totalMoves : 1);

    dev.log('평균 반응시간: ${avgReactionTime.toStringAsFixed(2)}초', name: 'AttentionZScore');
    
    logger?.logZScoreInfo('');
    logger?.logZScoreInfo('⏱️ 평균 반응시간: ${avgReactionTime.toStringAsFixed(2)}초');

    // 규준값 가져오기
    final merNorm = AttentionAgeNorms.getMerNorm(ageMonths);
    final revisitNorm = AttentionAgeNorms.getRevisitingRateNorm(ageMonths);
    final rtNorm = AttentionAgeNorms.getReactionTimeNorm(ageMonths);

    dev.log('규준값:', name: 'AttentionZScore');
    dev.log('  MER 또래평균(μ): ${merNorm.mean.toStringAsFixed(4)}, 표준편차(σ): ${merNorm.stdDev.toStringAsFixed(4)}', name: 'AttentionZScore');
    dev.log('  재확인율 또래평균(μ): ${revisitNorm.mean.toStringAsFixed(4)}, 표준편차(σ): ${revisitNorm.stdDev.toStringAsFixed(4)}', name: 'AttentionZScore');
    dev.log('  반응시간 정상범위: ${rtNorm.minValue.toStringAsFixed(2)}초 ~ ${rtNorm.maxValue.toStringAsFixed(2)}초', name: 'AttentionZScore');

    logger?.logZScoreInfo('');
    logger?.logZScoreInfo('📐 또래 규준값 (${merNorm.minMonths}~${merNorm.maxMonths}개월)');
    logger?.logZScoreInfo('  MER 평균(μ): ${merNorm.mean.toStringAsFixed(4)}');
    logger?.logZScoreInfo('  MER 표준편차(σ): ${merNorm.stdDev.toStringAsFixed(4)}');
    logger?.logZScoreInfo('  재확인율 평균(μ): ${(revisitNorm.mean * 100).toStringAsFixed(1)}%');
    logger?.logZScoreInfo('  재확인율 표준편차(σ): ${(revisitNorm.stdDev * 100).toStringAsFixed(1)}%');
    logger?.logZScoreInfo('  반응시간 정상범위: ${rtNorm.minValue.toStringAsFixed(1)}~${rtNorm.maxValue.toStringAsFixed(1)}초');

    // Z점수 계산
    final merZ = merNorm.calculateZScore(mer);
    final revisitZ = revisitNorm.calculateZScore(
      revisitingRate,
      invertDirection: true,
    );

    dev.log('Z점수 계산 결과:', name: 'AttentionZScore');
    dev.log('  MER Z점수: ${merZ.toStringAsFixed(3)}', name: 'AttentionZScore');
    dev.log('  재확인율 Z점수: ${revisitZ.toStringAsFixed(3)}', name: 'AttentionZScore');
    
    logger?.logZScoreInfo('');
    logger?.logZScoreInfo('📊 Z점수 계산 결과');
    logger?.logZScoreInfo('  MER Z점수: ${merZ.toStringAsFixed(3)}');
    logger?.logZScoreInfo('  재확인율 Z점수: ${revisitZ.toStringAsFixed(3)}');

    // 행동 패턴 분류
    final pattern = BehaviorPatternClassifier.classifyAttentionPattern(
      merZ: merZ,
      revisitZ: revisitZ,
      avgReactionTime: avgReactionTime,
      rtNorm: rtNorm,
    );

    final merLabel = ZScoreLabelProvider.getMerLabel(merZ, l10n);
    final revisitLabel = ZScoreLabelProvider.getRevisitLabel(revisitZ, l10n);

    dev.log('MER 라벨: $merLabel', name: 'AttentionZScore');
    dev.log('재확인율 라벨: $revisitLabel', name: 'AttentionZScore');
    dev.log('행동 패턴: ${pattern.name}', name: 'AttentionZScore');
    dev.log('=== 주의력 Z점수 분석 완료 ===\n', name: 'AttentionZScore');

    if (logger != null) {
      logger.logZScoreInfo('');
      logger.logZScoreInfo('🎯 행동 패턴: ${_getPatternKoreanName(pattern)}');
      logger.logZScoreInfo('━━━━━━━━━━━━━━━━━━');
    }

    return AttentionAnalysisResult(
      merZScore: ZScoreResult(
        zScore: merZ,
        label: merLabel,
        peerMean: merNorm.mean,
        peerStdDev: merNorm.stdDev,
        observedValue: mer,
      ),
      revisitingRateZScore: ZScoreResult(
        zScore: revisitZ,
        label: revisitLabel,
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

  /// 행동 패턴 한국어 이름 반환
  static String _getPatternKoreanName(AttentionBehaviorPattern pattern) {
    switch (pattern) {
      case AttentionBehaviorPattern.carefulExplorer:
        return '신중한 탐험가';
      case AttentionBehaviorPattern.quickProcessor:
        return '빠른 처리자';
      case AttentionBehaviorPattern.energeticExplorer:
        return '활발한 탐험가';
      case AttentionBehaviorPattern.diligentTrier:
        return '끈기있는 도전자';
    }
  }
}


