import 'package:littlesignals/core/constants/algorithm_config.dart';
import 'package:littlesignals/core/domain/report_calculator.dart';
import 'package:littlesignals/core/domain/test_result.dart';
import 'package:littlesignals/core/utils/z_score_calculator.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/models/attention_result.dart';
import 'package:littlesignals/models/report_data.dart';
import 'package:littlesignals/models/z_score_result.dart';

/// 주의력 테스트 결과에 대한 리포트 계산기
///
/// AttentionResult를 받아서 리포트 데이터를 생성합니다.
/// Z점수 기반 분석과 행동 패턴 분류를 수행합니다.
class AttentionReportCalculator implements ReportCalculator {
  const AttentionReportCalculator();

  @override
  ReportData calculate(
    TestResult result,
    AppLocalizations l10n, {
    double? ageMonths,
  }) {
    if (result is! AttentionResult) {
      throw ArgumentError(
        'AttentionReportCalculator requires AttentionResult',
      );
    }

    // 월령 정보가 있으면 Z점수 기반 분석 수행
    if (ageMonths != null) {
      return _calculateWithZScore(result, l10n, ageMonths);
    }

    // 월령 정보가 없으면 기존 방식 사용
    return _calculateLegacy(result, l10n);
  }

  /// Z점수 기반 리포트 계산
  ReportData _calculateWithZScore(
    AttentionResult result,
    AppLocalizations l10n,
    double ageMonths,
  ) {
    // Z점수 분석 수행
    final analysis = ZScoreCalculator.analyzeAttentionResult(
      result: result,
      ageMonths: ageMonths,
      l10n: l10n,
    );

    // 행동 패턴에 따른 제목, 설명, 팁 결정
    final (title, description, tips) = _getPatternContent(
      analysis.behaviorPattern,
      l10n,
    );

    // MER Z점수를 시각화 점수로 변환
    final visualScore = ZScoreCalculator.zScoreToVisualPosition(
      analysis.merZScore.zScore,
    );

    return ReportData(
      visualScore: visualScore,
      title: title,
      description: description,
      tips: tips,
      lowLabel: l10n.developingMemory,
      highLabel: l10n.highMemoryEfficiency,
      zScoreResult: analysis.merZScore,
      attentionAnalysis: analysis,
    );
  }

  /// 기존 방식 리포트 계산 (월령 정보 없을 때)
  ReportData _calculateLegacy(
    AttentionResult result,
    AppLocalizations l10n,
  ) {
    final errorPenalty = (result.errors *
            LegacyReportConfig.attentionErrorPenaltyPerError)
        .clamp(0, LegacyReportConfig.attentionMaxErrorPenalty)
        .toDouble();
    final durationPenalty =
        (result.durationSeconds * LegacyReportConfig.attentionDurationPenaltyRate)
            .clamp(0.0, LegacyReportConfig.attentionMaxDurationPenalty);
    double visualScore = 100.0 - (errorPenalty + durationPenalty);
    visualScore = visualScore.clamp(
      LegacyReportConfig.attentionMinScore,
      LegacyReportConfig.attentionMaxScore,
    );

    final String title;
    final String description;

    if (visualScore > LegacyReportConfig.attentionExplorerThreshold) {
      title = l10n.steadyExplorer;
      description = l10n.steadyExplorerDesc;
    } else {
      title = l10n.freeExplorer;
      description = l10n.freeExplorerDesc;
    }

    return ReportData(
      visualScore: visualScore,
      title: title,
      description: description,
      tips: [l10n.attentionTip1, l10n.attentionTip2],
      lowLabel: l10n.freeSpirit,
      highLabel: l10n.deepFocus,
    );
  }

  /// 행동 패턴에 따른 콘텐츠 반환
  (String title, String description, List<String> tips) _getPatternContent(
    AttentionBehaviorPattern pattern,
    AppLocalizations l10n,
  ) {
    switch (pattern) {
      case AttentionBehaviorPattern.carefulExplorer:
        return (
          l10n.carefulExplorerTitle,
          l10n.carefulExplorerDesc,
          [l10n.carefulExplorerTip1, l10n.carefulExplorerTip2],
        );
      case AttentionBehaviorPattern.quickProcessor:
        return (
          l10n.quickProcessorTitle,
          l10n.quickProcessorDesc,
          [l10n.quickProcessorTip1, l10n.quickProcessorTip2],
        );
      case AttentionBehaviorPattern.energeticExplorer:
        return (
          l10n.energeticExplorerTitle,
          l10n.energeticExplorerDesc,
          [l10n.energeticExplorerTip1, l10n.energeticExplorerTip2],
        );
      case AttentionBehaviorPattern.diligentTrier:
        return (
          l10n.diligentTrierTitle,
          l10n.diligentTrierDesc,
          [l10n.diligentTrierTip1, l10n.diligentTrierTip2],
        );
      case AttentionBehaviorPattern.confirmingMemory:
        return (
          l10n.confirmingMemoryTitle,
          l10n.confirmingMemoryDesc,
          [l10n.confirmingMemoryTip1, l10n.confirmingMemoryTip2],
        );
      case AttentionBehaviorPattern.intuitiveGuesser:
        return (
          l10n.intuitiveGuesserTitle,
          l10n.intuitiveGuesserDesc,
          [l10n.intuitiveGuesserTip1, l10n.intuitiveGuesserTip2],
        );
    }
  }
}
