import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/models/app_state.dart';
import 'package:littlesignals/models/report_data.dart';
import 'package:littlesignals/providers/app_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_provider.g.dart';

/// 리포트 데이터를 계산하는 유틸리티 클래스
class ReportCalculator {
  const ReportCalculator._();

  /// 주의력 테스트 결과에서 리포트 데이터 생성
  static ReportData fromAttentionResult({
    required double durationSeconds,
    required int errors,
    required AppLocalizations l10n,
  }) {
    final errorPenalty = (errors * 10).clamp(0, 50).toDouble();
    final durationPenalty = (durationSeconds / 2).clamp(0.0, 40.0);
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

  /// 충동성 테스트 결과에서 리포트 데이터 생성
  static ReportData fromImpulsivityResult({
    required int commissionErrors,
    required AppLocalizations l10n,
  }) {
    final visualScore = (100.0 - (commissionErrors * 15)).clamp(10.0, 90.0);

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

/// 현재 테스트 타입 Provider
@riverpod
bool isAttentionTest(Ref ref) {
  final appState = ref.watch(appStateNotifierProvider);
  return appState.activeTest == TestType.attention;
}

/// 현재 테스트 결과가 있는지 확인하는 Provider
@riverpod
bool hasTestResult(Ref ref) {
  final appState = ref.watch(appStateNotifierProvider);
  final isAttention = appState.activeTest == TestType.attention;

  if (isAttention) {
    return appState.attentionResult != null;
  } else {
    return appState.impulsivityResult != null;
  }
}
