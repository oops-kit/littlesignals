import 'package:littlesignals/core/domain/report_calculator.dart';
import 'package:littlesignals/core/domain/test_result.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/models/attention_result.dart';
import 'package:littlesignals/models/report_data.dart';

/// 주의력 테스트 결과에 대한 리포트 계산기
///
/// AttentionResult를 받아서 리포트 데이터를 생성합니다.
class AttentionReportCalculator implements ReportCalculator {
  const AttentionReportCalculator();

  @override
  ReportData calculate(TestResult result, AppLocalizations l10n) {
    if (result is! AttentionResult) {
      throw ArgumentError('AttentionReportCalculator requires AttentionResult');
    }

    return _calculateFromAttention(result, l10n);
  }

  ReportData _calculateFromAttention(
    AttentionResult result,
    AppLocalizations l10n,
  ) {
    final errorPenalty = (result.errors * 10).clamp(0, 50).toDouble();
    final durationPenalty = (result.durationSeconds / 2).clamp(0.0, 40.0);
    double visualScore = 100.0 - (errorPenalty + durationPenalty);
    visualScore = visualScore.clamp(10.0, 90.0);

    final String title;
    final String description;

    if (visualScore > 40) {
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
}
