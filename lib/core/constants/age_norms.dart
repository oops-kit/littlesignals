/// 월령별 규준값 상수
///
/// Notion 문서(12/22 웹페이지 판단 알고리즘 구성)에 정의된
/// 연구 기반 참고 규준값입니다.
///
/// 참고문헌:
/// - Abdul Rahman A, et al. (2017) Dev Neuropsychol.
/// - Oeri N, et al. (2019) Front. Psychol.
/// - Wiebe SA, et al. (2012) Child Dev.
library;

import 'package:littlesignals/core/constants/algorithm_config.dart';

/// 주의력 테스트 월령별 규준값
class AttentionAgeNorms {
  AttentionAgeNorms._();

  /// 카드 뒤집기 과제 기준 턴 수 (3쌍 = 6카드)
  static int get baselineTurns => AttentionAlgorithmConfig.baselineTurns;

  /// 월령 구간별 MER(Memory Efficiency Ratio) 규준값
  static const List<AgeNormData> merNorms = [
    AgeNormData(
      minMonths: 36,
      maxMonths: 41,
      mean: AttentionAlgorithmConfig.mer36to41Mean,
      stdDev: AttentionAlgorithmConfig.mer36to41StdDev,
    ),
    AgeNormData(
      minMonths: 42,
      maxMonths: 47,
      mean: AttentionAlgorithmConfig.mer42to47Mean,
      stdDev: AttentionAlgorithmConfig.mer42to47StdDev,
    ),
    AgeNormData(
      minMonths: 48,
      maxMonths: 53,
      mean: AttentionAlgorithmConfig.mer48to53Mean,
      stdDev: AttentionAlgorithmConfig.mer48to53StdDev,
    ),
    AgeNormData(
      minMonths: 54,
      maxMonths: 60,
      mean: AttentionAlgorithmConfig.mer54to60Mean,
      stdDev: AttentionAlgorithmConfig.mer54to60StdDev,
    ),
  ];

  /// 월령 구간별 재확인율(Revisiting Rate) 규준값
  /// 주의: 재확인율은 낮을수록 좋으므로 Z점수 계산 시 방향 반전 필요
  static const List<AgeNormData> revisitingRateNorms = [
    AgeNormData(
      minMonths: 36,
      maxMonths: 41,
      mean: AttentionAlgorithmConfig.revisit36to41Mean,
      stdDev: AttentionAlgorithmConfig.revisit36to41StdDev,
    ),
    AgeNormData(
      minMonths: 42,
      maxMonths: 47,
      mean: AttentionAlgorithmConfig.revisit42to47Mean,
      stdDev: AttentionAlgorithmConfig.revisit42to47StdDev,
    ),
    AgeNormData(
      minMonths: 48,
      maxMonths: 53,
      mean: AttentionAlgorithmConfig.revisit48to53Mean,
      stdDev: AttentionAlgorithmConfig.revisit48to53StdDev,
    ),
    AgeNormData(
      minMonths: 54,
      maxMonths: 60,
      mean: AttentionAlgorithmConfig.revisit54to60Mean,
      stdDev: AttentionAlgorithmConfig.revisit54to60StdDev,
    ),
  ];

  /// 월령 구간별 평균 반응시간(초) 규준값
  static const List<AgeRangeNormData> reactionTimeNorms = [
    AgeRangeNormData(
      minMonths: 36,
      maxMonths: 41,
      minValue: AttentionAlgorithmConfig.reactionTime36to41Min,
      maxValue: AttentionAlgorithmConfig.reactionTime36to41Max,
    ),
    AgeRangeNormData(
      minMonths: 42,
      maxMonths: 47,
      minValue: AttentionAlgorithmConfig.reactionTime42to47Min,
      maxValue: AttentionAlgorithmConfig.reactionTime42to47Max,
    ),
    AgeRangeNormData(
      minMonths: 48,
      maxMonths: 53,
      minValue: AttentionAlgorithmConfig.reactionTime48to53Min,
      maxValue: AttentionAlgorithmConfig.reactionTime48to53Max,
    ),
    AgeRangeNormData(
      minMonths: 54,
      maxMonths: 60,
      minValue: AttentionAlgorithmConfig.reactionTime54to60Min,
      maxValue: AttentionAlgorithmConfig.reactionTime54to60Max,
    ),
  ];

  /// 월령에 해당하는 MER 규준값 반환
  static AgeNormData getMerNorm(double ageMonths) {
    return _findNorm(merNorms, ageMonths);
  }

  /// 월령에 해당하는 재확인율 규준값 반환
  static AgeNormData getRevisitingRateNorm(double ageMonths) {
    return _findNorm(revisitingRateNorms, ageMonths);
  }

  /// 월령에 해당하는 반응시간 규준값 반환
  static AgeRangeNormData getReactionTimeNorm(double ageMonths) {
    for (final norm in reactionTimeNorms) {
      if (ageMonths >= norm.minMonths && ageMonths <= norm.maxMonths) {
        return norm;
      }
    }
    // 범위 밖이면 가장 가까운 규준 반환
    if (ageMonths < reactionTimeNorms.first.minMonths) {
      return reactionTimeNorms.first;
    }
    return reactionTimeNorms.last;
  }

  static AgeNormData _findNorm(List<AgeNormData> norms, double ageMonths) {
    for (final norm in norms) {
      if (ageMonths >= norm.minMonths && ageMonths <= norm.maxMonths) {
        return norm;
      }
    }
    // 범위 밖이면 가장 가까운 규준 반환
    if (ageMonths < norms.first.minMonths) {
      return norms.first;
    }
    return norms.last;
  }
}

/// 충동성 테스트 월령별 규준값
///
/// 참고: Wiebe SA, 2012 연구 기반
class ImpulsivityAgeNorms {
  ImpulsivityAgeNorms._();

  /// 월령별 No-go 억제 비율 규준값
  static const List<AgeNormData> inhibitionRateNorms = [
    // 3세 9개월 (45개월) 기준
    AgeNormData(
      minMonths: 36,
      maxMonths: 47,
      mean: ImpulsivityAlgorithmConfig.inhibition36to47Mean,
      stdDev: ImpulsivityAlgorithmConfig.inhibition36to47StdDev,
    ),
    // 4세 6개월 (54개월) 기준
    AgeNormData(
      minMonths: 48,
      maxMonths: 59,
      mean: ImpulsivityAlgorithmConfig.inhibition48to59Mean,
      stdDev: ImpulsivityAlgorithmConfig.inhibition48to59StdDev,
    ),
    // 5세 3개월 (63개월) 기준
    AgeNormData(
      minMonths: 60,
      maxMonths: 72,
      mean: ImpulsivityAlgorithmConfig.inhibition60to72Mean,
      stdDev: ImpulsivityAlgorithmConfig.inhibition60to72StdDev,
    ),
  ];

  /// 월령별 부주의(Omission) 비율 규준값
  /// 주의: omission 비율은 낮을수록 좋으므로 Z점수 계산 시 방향 반전 필요
  static const List<AgeNormData> omissionRateNorms = [
    // 3세 기준 - 부주의 비율이 상대적으로 높음
    AgeNormData(
      minMonths: 36,
      maxMonths: 47,
      mean: ImpulsivityAlgorithmConfig.omission36to47Mean,
      stdDev: ImpulsivityAlgorithmConfig.omission36to47StdDev,
    ),
    // 4세 기준 - 집중력 향상으로 부주의 감소
    AgeNormData(
      minMonths: 48,
      maxMonths: 59,
      mean: ImpulsivityAlgorithmConfig.omission48to59Mean,
      stdDev: ImpulsivityAlgorithmConfig.omission48to59StdDev,
    ),
    // 5세 기준 - 더욱 안정적인 집중력
    AgeNormData(
      minMonths: 60,
      maxMonths: 72,
      mean: ImpulsivityAlgorithmConfig.omission60to72Mean,
      stdDev: ImpulsivityAlgorithmConfig.omission60to72StdDev,
    ),
  ];

  /// 월령별 반응시간(ms) 규준값
  static const List<AgeNormData> reactionTimeNorms = [
    // 3세 기준
    AgeNormData(
      minMonths: 36,
      maxMonths: 47,
      mean: ImpulsivityAlgorithmConfig.reactionTime36to47Mean,
      stdDev: ImpulsivityAlgorithmConfig.reactionTime36to47StdDev,
    ),
    // 4세 기준
    AgeNormData(
      minMonths: 48,
      maxMonths: 59,
      mean: ImpulsivityAlgorithmConfig.reactionTime48to59Mean,
      stdDev: ImpulsivityAlgorithmConfig.reactionTime48to59StdDev,
    ),
    // 5세 기준
    AgeNormData(
      minMonths: 60,
      maxMonths: 72,
      mean: ImpulsivityAlgorithmConfig.reactionTime60to72Mean,
      stdDev: ImpulsivityAlgorithmConfig.reactionTime60to72StdDev,
    ),
  ];

  /// 월령에 해당하는 억제 비율 규준값 반환
  static AgeNormData getInhibitionRateNorm(double ageMonths) {
    return _findNorm(inhibitionRateNorms, ageMonths);
  }

  /// 월령에 해당하는 부주의 비율 규준값 반환
  static AgeNormData getOmissionRateNorm(double ageMonths) {
    return _findNorm(omissionRateNorms, ageMonths);
  }

  /// 월령에 해당하는 반응시간 규준값 반환
  static AgeNormData getReactionTimeNorm(double ageMonths) {
    return _findNorm(reactionTimeNorms, ageMonths);
  }

  static AgeNormData _findNorm(List<AgeNormData> norms, double ageMonths) {
    for (final norm in norms) {
      if (ageMonths >= norm.minMonths && ageMonths <= norm.maxMonths) {
        return norm;
      }
    }
    // 범위 밖이면 가장 가까운 규준 반환
    if (ageMonths < norms.first.minMonths) {
      return norms.first;
    }
    return norms.last;
  }
}

/// 월령 구간별 규준 데이터 (평균 및 표준편차)
class AgeNormData {
  const AgeNormData({
    required this.minMonths,
    required this.maxMonths,
    required this.mean,
    required this.stdDev,
  });

  final int minMonths;
  final int maxMonths;
  final double mean;
  final double stdDev;

  /// Z점수 계산
  /// [observed] 관측값
  /// [invertDirection] true면 방향 반전 (낮을수록 좋은 지표용)
  double calculateZScore(double observed, {bool invertDirection = false}) {
    if (stdDev == 0) return 0;
    if (invertDirection) {
      return (mean - observed) / stdDev;
    }
    return (observed - mean) / stdDev;
  }
}

/// 월령 구간별 범위 규준 데이터 (최소-최대 범위)
class AgeRangeNormData {
  const AgeRangeNormData({
    required this.minMonths,
    required this.maxMonths,
    required this.minValue,
    required this.maxValue,
  });

  final int minMonths;
  final int maxMonths;
  final double minValue;
  final double maxValue;

  /// 값이 정상 범위 내에 있는지 확인
  bool isWithinRange(double value) {
    return value >= minValue && value <= maxValue;
  }

  /// 범위 중앙값
  double get midValue => (minValue + maxValue) / 2;

  /// 범위 기준 상대적 위치 (-1 ~ +1)
  /// -1: 최소값 이하, 0: 중앙, +1: 최대값 이상
  double getRelativePosition(double value) {
    final range = maxValue - minValue;
    if (range == 0) return 0;
    final position = (value - midValue) / (range / 2);
    return position.clamp(-2.0, 2.0);
  }
}
