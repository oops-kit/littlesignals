import 'package:littlesignals/core/domain/report_calculator.dart';
import 'package:littlesignals/core/domain/test_result.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/models/impulsivity_result.dart';
import 'package:littlesignals/models/report_data.dart';

/// 충동성 테스트 결과에 대한 리포트 계산기
///
/// ImpulsivityResult를 받아서 리포트 데이터를 생성합니다.
class ImpulsivityReportCalculator implements ReportCalculator {
  const ImpulsivityReportCalculator();

  @override
  ReportData calculate(TestResult result, AppLocalizations l10n) {
    if (result is! ImpulsivityResult) {
      throw ArgumentError(
        'ImpulsivityReportCalculator requires ImpulsivityResult',
      );
    }

    return _calculateFromImpulsivity(result, l10n);
  }

  ReportData _calculateFromImpulsivity(
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
}
