import 'package:freezed_annotation/freezed_annotation.dart';

part 'z_score_result.freezed.dart';

/// Z점수 계산 결과 모델
///
/// 아동의 테스트 결과를 또래 규준과 비교한 Z점수 정보를 담습니다.
/// UI에서는 숫자 Z값을 직접 노출하지 않고, label만 표시합니다.
@freezed
abstract class ZScoreResult with _$ZScoreResult {
  const factory ZScoreResult({
    /// Z점수 값 (내부 계산용, UI에 직접 노출 안함)
    required double zScore,

    /// 부모용 라벨 (예: "또래 평균", "참을성이 좋음")
    required String label,

    /// 또래 평균값
    required double peerMean,

    /// 또래 표준편차
    required double peerStdDev,

    /// 아동의 관측값
    required double observedValue,
  }) = _ZScoreResult;

  const ZScoreResult._();

  /// Z점수가 또래 평균 범위 내에 있는지 (-1 ≤ z ≤ +1)
  bool get isWithinPeerRange => zScore >= -1 && zScore <= 1;

  /// Z점수가 또래 평균보다 높은지 (z > +1)
  bool get isAbovePeerRange => zScore > 1;

  /// Z점수가 또래 평균보다 낮은지 (z < -1)
  bool get isBelowPeerRange => zScore < -1;
}

/// 주의력 테스트 행동 패턴 유형
enum AttentionBehaviorPattern {
  /// 신중한 탐색가형 (MER 높음, 재확인율 낮음, 반응속도 느림)
  carefulExplorer,

  /// 빠른 처리형 (MER 높음, 재확인율 낮음, 반응속도 빠름)
  quickProcessor,

  /// 에너지 탐색형 (MER 낮음, 재확인율 높음, 반응속도 빠름)
  energeticExplorer,

  /// 성실한 시도형 (MER 낮음, 재확인율 높음, 반응속도 느림)
  diligentTrier,

  /// 확인형 기억 우수형 (MER 높음, 재확인율 높음)
  confirmingMemory,

  /// 직관적 추측형 (MER 낮음, 재확인율 낮음)
  intuitiveGuesser,
}

/// 충동성 테스트 행동 패턴 유형 (4분면 기반)
enum ImpulsivityBehaviorPattern {
  /// 빠르게 반응하지만 멈출 줄 아는 아이 (RT 빠름, 억제비율 높음)
  quickAndControlled,

  /// 에너지가 먼저 나오는 아이 (RT 빠름, 억제비율 낮음)
  energyFirst,

  /// 차분하고 안정적인 아이 (RT 느림, 억제비율 높음)
  calmAndStable,

  /// 천천히 익혀가는 단계의 아이 (RT 느림, 억제비율 낮음)
  learningAtOwnPace,
}

/// 주의력 테스트 종합 분석 결과
@freezed
abstract class AttentionAnalysisResult with _$AttentionAnalysisResult {
  const factory AttentionAnalysisResult({
    /// MER Z점수 결과
    required ZScoreResult merZScore,

    /// 재확인율 Z점수 결과
    required ZScoreResult revisitingRateZScore,

    /// 행동 패턴 유형
    required AttentionBehaviorPattern behaviorPattern,

    /// MER 값 (0-1)
    required double mer,

    /// 재확인율 (0-1)
    required double revisitingRate,

    /// 평균 반응시간 (초)
    required double avgReactionTime,

    /// 반응시간이 정상 범위 내인지
    required bool isReactionTimeNormal,
  }) = _AttentionAnalysisResult;
}

/// 충동성 테스트 종합 분석 결과
@freezed
abstract class ImpulsivityAnalysisResult with _$ImpulsivityAnalysisResult {
  const factory ImpulsivityAnalysisResult({
    /// 억제 비율 Z점수 결과 (충동성 지표)
    required ZScoreResult inhibitionZScore,

    /// 부주의 비율 Z점수 결과 (omission 지표)
    required ZScoreResult omissionZScore,

    /// 행동 패턴 유형
    required ImpulsivityBehaviorPattern behaviorPattern,

    /// 억제 비율 (0-1)
    required double inhibitionRate,

    /// 부주의 비율 (0-1)
    required double omissionRate,

    /// 평균 반응시간 (ms)
    required double avgReactionTime,

    /// 반응시간이 또래 평균보다 빠른지
    required bool isFastReactor,
  }) = _ImpulsivityAnalysisResult;
}



