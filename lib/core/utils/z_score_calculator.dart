import 'package:littlesignals/core/services/analysis/attention_z_score_analyzer.dart';
import 'package:littlesignals/core/services/analysis/impulsivity_z_score_analyzer.dart';
import 'package:littlesignals/core/services/analysis/z_score_visual_converter.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/models/attention_result.dart';
import 'package:littlesignals/models/impulsivity_result.dart';
import 'package:littlesignals/models/z_score_result.dart';

/// Z점수 계산 유틸리티 (Facade)
///
/// 기존 API와의 호환성을 유지하면서 내부적으로 분리된 서비스들에 위임합니다.
/// SRP를 적용하여 실제 로직은 다음 클래스들에 분리되어 있습니다:
/// - AttentionZScoreAnalyzer: 주의력 테스트 Z점수 분석
/// - ImpulsivityZScoreAnalyzer: 충동성 테스트 Z점수 분석
/// - BehaviorPatternClassifier: 행동 패턴 분류
/// - ZScoreLabelProvider: Z점수 라벨 생성
/// - ZScoreVisualConverter: Z점수 시각화 변환
class ZScoreCalculator {
  const ZScoreCalculator._();

  /// 주의력 테스트 결과 분석
  ///
  /// AttentionZScoreAnalyzer에 위임합니다.
  static AttentionAnalysisResult analyzeAttentionResult({
    required AttentionResult result,
    required double ageMonths,
    required AppLocalizations l10n,
  }) {
    return AttentionZScoreAnalyzer.analyze(
      result: result,
      ageMonths: ageMonths,
      l10n: l10n,
    );
  }

  /// 충동성 테스트 결과 분석
  ///
  /// ImpulsivityZScoreAnalyzer에 위임합니다.
  static ImpulsivityAnalysisResult analyzeImpulsivityResult({
    required ImpulsivityResult result,
    required double ageMonths,
    required AppLocalizations l10n,
  }) {
    return ImpulsivityZScoreAnalyzer.analyze(
      result: result,
      ageMonths: ageMonths,
      l10n: l10n,
    );
  }

  /// Z점수를 시각화용 위치값(0-100)으로 변환
  ///
  /// ZScoreVisualConverter에 위임합니다.
  static double zScoreToVisualPosition(double zScore) {
    return ZScoreVisualConverter.toVisualPosition(zScore);
  }
}
