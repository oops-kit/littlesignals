class AppConstants {
  AppConstants._();

  // Attention Test Constants
  /// 카드 쌍 수: 기획서 3x2 (3쌍) 고정
  static const int attentionPairCount = 3;

  /// 힌트 딜레이: 기획서 8~10초 → 8초
  static const int attentionHintDelaySeconds = 8;

  /// 정답 매칭 후 딜레이
  static const int attentionMatchDelayMs = 800;

  /// 오답 피드백 노출: 기획서 1500ms
  static const int attentionNoMatchDelayMs = 1500;

  /// 입력 차단(Cool-down): 기획서 300~500ms → 400ms
  static const int attentionCooldownMs = 400;

  // Impulsivity Test Constants
  static const int impulsivityTotalStimuli = 15;

  /// 파란 풍선(Go) 비율: 기획서 75%
  static const double impulsivityBlueRatio = 0.75;

  /// 자극 간 간격(ISI): 기획서 1500ms 고정
  static const int impulsivityIntervalMs = 1500;

  /// 자극 노출 시간: 기획서 1500ms
  static const int impulsivityBalloonDurationMs = 1500;

  // Calibration Constants
  static const int calibrationRequiredTaps = 3;

  // Age Range
  static const int minAgeMonths = 36;
  static const int maxAgeMonths = 54;
}
