/// 알고리즘 설정 상수
///
/// 모든 알고리즘 관련 설정을 한 곳에서 관리합니다.
/// 테스트 알고리즘, Z점수 계산, 행동 패턴 분류 등의 설정을 포함합니다.
///
/// 참고문헌:
/// - Abdul Rahman A, et al. (2017) Dev Neuropsychol.
/// - Oeri N, et al. (2019) Front. Psychol.
/// - Wiebe SA, et al. (2012) Child Dev.
library;

// ============================================================================
// 주의력 테스트 알고리즘 설정
// ============================================================================

/// 주의력 테스트 알고리즘 설정
class AttentionAlgorithmConfig {
  AttentionAlgorithmConfig._();

  // ---------------------------------------------------------------------------
  // MER (Memory Efficiency Ratio) 계산 설정
  // ---------------------------------------------------------------------------

  /// 카드 뒤집기 과제 기준 턴 수 (3쌍 = 6카드)
  /// MER 계산 공식: baselineTurns / 실제턴수
  static const int baselineTurns = 6;

  /// 힌트 사용 당 MER 차감 값
  /// 기획서: 0.5점 차감 → MER은 0~1 범위이므로 0.05로 조정 (0.5/10)
  static const double hintPenaltyPerUse = 0.05;

  // ---------------------------------------------------------------------------
  // 월령별 MER 규준값 (평균, 표준편차)
  // ---------------------------------------------------------------------------

  /// 36-41개월 MER 규준값
  static const double mer36to41Mean = 0.42;
  static const double mer36to41StdDev = 0.15;

  /// 42-47개월 MER 규준값
  static const double mer42to47Mean = 0.55;
  static const double mer42to47StdDev = 0.14;

  /// 48-53개월 MER 규준값
  static const double mer48to53Mean = 0.68;
  static const double mer48to53StdDev = 0.12;

  /// 54-60개월 MER 규준값
  static const double mer54to60Mean = 0.78;
  static const double mer54to60StdDev = 0.10;

  // ---------------------------------------------------------------------------
  // 월령별 재확인율(Revisiting Rate) 규준값
  // 주의: 재확인율은 낮을수록 좋으므로 Z점수 계산 시 방향 반전 필요
  // ---------------------------------------------------------------------------

  /// 36-41개월 재확인율 규준값
  static const double revisit36to41Mean = 0.30;
  static const double revisit36to41StdDev = 0.10;

  /// 42-47개월 재확인율 규준값
  static const double revisit42to47Mean = 0.22;
  static const double revisit42to47StdDev = 0.08;

  /// 48-53개월 재확인율 규준값
  static const double revisit48to53Mean = 0.14;
  static const double revisit48to53StdDev = 0.06;

  /// 54-60개월 재확인율 규준값
  static const double revisit54to60Mean = 0.08;
  static const double revisit54to60StdDev = 0.05;

  // ---------------------------------------------------------------------------
  // 월령별 반응시간 규준값 (초, 최소-최대 범위)
  // ---------------------------------------------------------------------------

  /// 36-41개월 반응시간 범위 (초)
  static const double reactionTime36to41Min = 3.0;
  static const double reactionTime36to41Max = 4.5;

  /// 42-47개월 반응시간 범위 (초)
  static const double reactionTime42to47Min = 2.5;
  static const double reactionTime42to47Max = 3.5;

  /// 48-53개월 반응시간 범위 (초)
  static const double reactionTime48to53Min = 2.0;
  static const double reactionTime48to53Max = 3.0;

  /// 54-60개월 반응시간 범위 (초)
  static const double reactionTime54to60Min = 1.5;
  static const double reactionTime54to60Max = 2.5;
}

// ============================================================================
// 충동성 테스트 알고리즘 설정
// ============================================================================

/// 충동성 테스트 알고리즘 설정
class ImpulsivityAlgorithmConfig {
  ImpulsivityAlgorithmConfig._();

  // ---------------------------------------------------------------------------
  // 자극 구성 설정
  // ---------------------------------------------------------------------------

  /// No-go 자극 비율 (빨간 풍선)
  /// 기획서: 25%
  static const double noGoRatio = 0.25;

  /// Go 자극 비율 (파란 풍선)
  /// 기획서: 75%
  static const double goRatio = 0.75;

  // ---------------------------------------------------------------------------
  // 월령별 억제 비율(Inhibition Rate) 규준값
  // 참고: Wiebe SA, 2012 연구 기반
  // ---------------------------------------------------------------------------

  /// 36-47개월 억제 비율 규준값 (3세 9개월 기준)
  static const double inhibition36to47Mean = 0.74;
  static const double inhibition36to47StdDev = 0.312;

  /// 48-59개월 억제 비율 규준값 (4세 6개월 기준)
  static const double inhibition48to59Mean = 0.84;
  static const double inhibition48to59StdDev = 0.206;

  /// 60-72개월 억제 비율 규준값 (5세 3개월 기준)
  static const double inhibition60to72Mean = 0.89;
  static const double inhibition60to72StdDev = 0.137;

  // ---------------------------------------------------------------------------
  // 월령별 부주의(Omission) 비율 규준값
  // 주의: omission 비율은 낮을수록 좋으므로 Z점수 계산 시 방향 반전 필요
  // ---------------------------------------------------------------------------

  /// 36-47개월 부주의 비율 규준값
  static const double omission36to47Mean = 0.18;
  static const double omission36to47StdDev = 0.12;

  /// 48-59개월 부주의 비율 규준값
  static const double omission48to59Mean = 0.12;
  static const double omission48to59StdDev = 0.08;

  /// 60-72개월 부주의 비율 규준값
  static const double omission60to72Mean = 0.08;
  static const double omission60to72StdDev = 0.05;

  // ---------------------------------------------------------------------------
  // 월령별 반응시간 규준값 (ms)
  // ---------------------------------------------------------------------------

  /// 36-47개월 반응시간 규준값 (ms)
  static const double reactionTime36to47Mean = 934;
  static const double reactionTime36to47StdDev = 200;

  /// 48-59개월 반응시간 규준값 (ms)
  static const double reactionTime48to59Mean = 835;
  static const double reactionTime48to59StdDev = 180;

  /// 60-72개월 반응시간 규준값 (ms)
  static const double reactionTime60to72Mean = 733;
  static const double reactionTime60to72StdDev = 150;
}

// ============================================================================
// Z점수 계산 및 분류 설정
// ============================================================================

/// Z점수 분류 설정
class ZScoreConfig {
  ZScoreConfig._();

  // ---------------------------------------------------------------------------
  // Z점수 라벨 분류 임계값
  // ---------------------------------------------------------------------------

  /// 또래 평균 범위 하한 (inclusive)
  /// Z점수가 이 값 이상이고 upperThreshold 이하이면 "또래 평균"
  static const double averageLowerThreshold = -1.0;

  /// 또래 평균 범위 상한 (inclusive)
  static const double averageUpperThreshold = 1.0;

  /// 높음/우수 분류 기준
  /// Z점수가 이 값보다 크면 "높음/우수" 라벨
  static const double highThreshold = 1.0;

  /// 낮음/발달중 분류 기준
  /// Z점수가 이 값보다 작으면 "낮음/발달중" 라벨
  static const double lowThreshold = -1.0;

  // ---------------------------------------------------------------------------
  // 행동 패턴 분류 임계값
  // ---------------------------------------------------------------------------

  /// MER/억제 비율 평균 기준 (z >= 0이면 높음)
  static const double patternAverageThreshold = 0.0;
}

// ============================================================================
// 시각화 설정
// ============================================================================

/// 시각화 변환 설정
class VisualizationConfig {
  VisualizationConfig._();

  // ---------------------------------------------------------------------------
  // Z점수 → 시각적 위치 변환 설정
  // ---------------------------------------------------------------------------

  /// Z점수 클램핑 최소값
  /// 이 값보다 작은 Z점수는 이 값으로 클램핑됨
  static const double zScoreMin = -2.0;

  /// Z점수 클램핑 최대값
  /// 이 값보다 큰 Z점수는 이 값으로 클램핑됨
  static const double zScoreMax = 2.0;

  /// 시각적 위치 최소값 (Z = zScoreMin일 때)
  static const double visualPositionMin = 0.0;

  /// 시각적 위치 최대값 (Z = zScoreMax일 때)
  static const double visualPositionMax = 100.0;

  /// 시각적 위치 중앙값 (Z = 0일 때)
  static const double visualPositionCenter = 50.0;

  /// Z점수를 시각적 위치로 변환
  /// 공식: ((clampedZ - zScoreMin) / (zScoreMax - zScoreMin)) * (visualMax - visualMin) + visualMin
  static double zScoreToPosition(double zScore) {
    final clampedZ = zScore.clamp(zScoreMin, zScoreMax);
    final zRange = zScoreMax - zScoreMin;
    final visualRange = visualPositionMax - visualPositionMin;
    return ((clampedZ - zScoreMin) / zRange) * visualRange + visualPositionMin;
  }
}

// ============================================================================
// 레거시 리포트 계산 설정 (월령 정보 없을 때 사용)
// ============================================================================

/// 레거시 리포트 계산 설정
class LegacyReportConfig {
  LegacyReportConfig._();

  // ---------------------------------------------------------------------------
  // 주의력 테스트 레거시 설정
  // ---------------------------------------------------------------------------

  /// 오류당 페널티 점수
  static const double attentionErrorPenaltyPerError = 10.0;

  /// 최대 오류 페널티
  static const double attentionMaxErrorPenalty = 50.0;

  /// 소요시간 페널티 계수 (초당)
  static const double attentionDurationPenaltyRate = 0.5;

  /// 최대 소요시간 페널티
  static const double attentionMaxDurationPenalty = 40.0;

  /// 점수 범위 최소값
  static const double attentionMinScore = 10.0;

  /// 점수 범위 최대값
  static const double attentionMaxScore = 90.0;

  /// 탐험가 유형 분류 기준 점수
  static const double attentionExplorerThreshold = 40.0;

  // ---------------------------------------------------------------------------
  // 충동성 테스트 레거시 설정
  // ---------------------------------------------------------------------------

  /// Commission 오류당 페널티 점수
  static const double impulsivityErrorPenaltyPerError = 15.0;

  /// 점수 범위 최소값
  static const double impulsivityMinScore = 10.0;

  /// 점수 범위 최대값
  static const double impulsivityMaxScore = 90.0;

  /// 관찰자/리더 유형 분류 기준 점수
  static const double impulsivityObserverThreshold = 50.0;
}

