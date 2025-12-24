import 'package:littlesignals/core/domain/report_calculator.dart';
import 'package:littlesignals/core/domain/test_result.dart';
import 'package:littlesignals/core/utils/z_score_calculator.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/models/impulsivity_result.dart';
import 'package:littlesignals/models/report_data.dart';
import 'package:littlesignals/models/z_score_result.dart';

/// 충동성 테스트 결과에 대한 리포트 계산기
///
/// ImpulsivityResult를 받아서 리포트 데이터를 생성합니다.
/// Z점수 기반 분석과 4분면 행동 패턴 분류를 수행합니다.
class ImpulsivityReportCalculator implements ReportCalculator {
  const ImpulsivityReportCalculator();

  @override
  ReportData calculate(
    TestResult result,
    AppLocalizations l10n, {
    double? ageMonths,
  }) {
    if (result is! ImpulsivityResult) {
      throw ArgumentError(
        'ImpulsivityReportCalculator requires ImpulsivityResult',
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
    ImpulsivityResult result,
    AppLocalizations l10n,
    double ageMonths,
  ) {
    // Z점수 분석 수행
    final analysis = ZScoreCalculator.analyzeImpulsivityResult(
      result: result,
      ageMonths: ageMonths,
      l10n: l10n,
    );

    // 행동 패턴에 따른 제목, 설명, 팁 결정
    final (title, description, tips) = _getPatternContent(
      analysis.behaviorPattern,
      l10n,
    );

    // 억제 비율 Z점수를 시각화 점수로 변환
    final visualScore = ZScoreCalculator.zScoreToVisualPosition(
      analysis.inhibitionZScore.zScore,
    );

    return ReportData(
      visualScore: visualScore,
      title: title,
      description: description,
      tips: tips,
      lowLabel: l10n.highEnergy,
      highLabel: l10n.goodSelfControl,
      zScoreResult: analysis.inhibitionZScore,
      impulsivityAnalysis: analysis,
    );
  }

  /// 기존 방식 리포트 계산 (월령 정보 없을 때)
  ReportData _calculateLegacy(
    ImpulsivityResult result,
    AppLocalizations l10n,
  ) {
    final visualScore = (100.0 - (result.commissionErrors * 15)).clamp(
      10.0,
      90.0,
    );

    final String title;
    final String description;

    if (visualScore > 50) {
      title = l10n.carefulObserver;
      description = l10n.carefulObserverDesc;
    } else {
      title = l10n.highEnergyLeader;
      description = l10n.highEnergyLeaderDesc;
    }

    return ReportData(
      visualScore: visualScore,
      title: title,
      description: description,
      tips: [l10n.impulsivityTip1, l10n.impulsivityTip2],
      lowLabel: l10n.highEnergy,
      highLabel: l10n.calmControl,
    );
  }

  /// 행동 패턴에 따른 콘텐츠 반환
  (String title, String description, List<String> tips) _getPatternContent(
    ImpulsivityBehaviorPattern pattern,
    AppLocalizations l10n,
  ) {
    switch (pattern) {
      case ImpulsivityBehaviorPattern.quickAndControlled:
        return (
          l10n.quickAndControlledTitle,
          l10n.quickAndControlledDesc,
          [l10n.quickAndControlledTip1, l10n.quickAndControlledTip2],
        );
      case ImpulsivityBehaviorPattern.energyFirst:
        return (
          l10n.energyFirstTitle,
          l10n.energyFirstDesc,
          [l10n.energyFirstTip1, l10n.energyFirstTip2],
        );
      case ImpulsivityBehaviorPattern.calmAndStable:
        return (
          l10n.calmAndStableTitle,
          l10n.calmAndStableDesc,
          [l10n.calmAndStableTip1, l10n.calmAndStableTip2],
        );
      case ImpulsivityBehaviorPattern.learningAtOwnPace:
        return (
          l10n.learningAtOwnPaceTitle,
          l10n.learningAtOwnPaceDesc,
          [l10n.learningAtOwnPaceTip1, l10n.learningAtOwnPaceTip2],
        );
    }
  }
}
