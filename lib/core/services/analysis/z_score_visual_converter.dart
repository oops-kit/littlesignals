/// Z점수 시각화 변환 유틸리티
///
/// SRP: Z점수를 시각화용 위치값으로 변환하는 것만 담당합니다.
class ZScoreVisualConverter {
  const ZScoreVisualConverter._();

  /// Z점수를 시각화용 위치값(0-100)으로 변환
  ///
  /// Z점수 -2 ~ +2 범위를 0 ~ 100으로 매핑합니다.
  /// - Z = -2 → 0
  /// - Z = 0 → 50
  /// - Z = +2 → 100
  static double toVisualPosition(double zScore) {
    // Z점수를 -2 ~ +2 범위로 클램핑
    final clampedZ = zScore.clamp(-2.0, 2.0);
    // 0-100 범위로 변환 (0 = -2, 50 = 0, 100 = +2)
    return ((clampedZ + 2) / 4) * 100;
  }
}


