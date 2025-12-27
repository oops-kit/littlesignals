import 'package:littlesignals/core/constants/algorithm_config.dart';

/// Z점수 시각화 변환 유틸리티
///
/// SRP: Z점수를 시각화용 위치값으로 변환하는 것만 담당합니다.
class ZScoreVisualConverter {
  const ZScoreVisualConverter._();

  /// Z점수를 시각화용 위치값(0-100)으로 변환
  ///
  /// Z점수 범위를 시각적 위치로 매핑합니다.
  /// - Z = zScoreMin → visualPositionMin
  /// - Z = 0 → visualPositionCenter
  /// - Z = zScoreMax → visualPositionMax
  static double toVisualPosition(double zScore) {
    return VisualizationConfig.zScoreToPosition(zScore);
  }
}
