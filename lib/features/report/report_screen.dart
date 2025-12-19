import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:littlesignals/core/theme/app_theme.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/models/app_state.dart';
import 'package:littlesignals/providers/app_state_provider.dart';
import 'package:littlesignals/router/app_router.dart';

import 'providers/report_provider.dart';
import 'widgets/behavior_style_card.dart';
import 'widgets/observe_another_button.dart';
import 'widgets/parenting_tips_card.dart';
import 'widgets/result_chart.dart';

/// 리포트 화면
///
/// 테스트 결과를 시각적으로 보여주는 화면입니다.
class ReportScreen extends ConsumerWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final appState = ref.watch(appStateNotifierProvider);
    final isAttention = appState.activeTest == TestType.attention;

    final attentionResult = appState.attentionResult;
    final impulsivityResult = appState.impulsivityResult;

    // #region agent log
    developer.log(
      '[DEBUG][HypA,B] ReportScreen build: '
      'activeTest=${appState.activeTest}, '
      'isAttention=$isAttention, '
      'attentionResult=${attentionResult != null}, '
      'impulsivityResult=${impulsivityResult != null}',
      name: 'ReportScreen',
    );
    // #endregion

    if (isAttention && attentionResult == null) {
      // #region agent log
      developer.log(
        '[DEBUG][HypC] Loading: isAttention=true, attentionResult=null',
        name: 'ReportScreen',
      );
      // #endregion
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (!isAttention && impulsivityResult == null) {
      // #region agent log
      developer.log(
        '[DEBUG][HypA,B] Loading: isAttention=false, impulsivityResult=null',
        name: 'ReportScreen',
      );
      // #endregion
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final reportData = isAttention
        ? ReportCalculator.fromAttentionResult(
            durationSeconds: attentionResult!.durationSeconds,
            errors: attentionResult.errors,
            l10n: l10n,
          )
        : ReportCalculator.fromImpulsivityResult(
            commissionErrors: impulsivityResult!.commissionErrors,
            l10n: l10n,
          );

    void handleObserveAnother() {
      ref.read(appStateNotifierProvider.notifier).clearActiveTest();
      context.go(AppRoutes.modeSelection);
    }

    return Scaffold(
      backgroundColor: AppTheme.slateLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 16),
              _PageTitle(title: l10n.observationSummary),
              const SizedBox(height: 24),
              BehaviorStyleCard(
                label: l10n.behaviorStyle,
                title: reportData.title,
                description: reportData.description,
              ),
              const SizedBox(height: 16),
              ResultChart(
                score: reportData.visualScore,
                label: l10n.typicalRangeForAge,
                lowLabel: reportData.lowLabel,
                highLabel: reportData.highLabel,
                description: l10n.comparisonDesc,
              ),
              const SizedBox(height: 16),
              ParentingTipsCard(
                title: l10n.parentingTips,
                tips: reportData.tips,
              ),
              const SizedBox(height: 24),
              ObserveAnotherButton(
                label: l10n.observeAnotherTrait,
                onPressed: handleObserveAnother,
              ),
              const SizedBox(height: 24),
              _DisclaimerText(text: l10n.disclaimer),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageTitle extends StatelessWidget {
  const _PageTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.headlineMedium);
  }
}

class _DisclaimerText extends StatelessWidget {
  const _DisclaimerText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(
        context,
      ).textTheme.bodySmall?.copyWith(color: AppTheme.slate400),
    );
  }
}
