import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:littlesignals/core/domain/test_result.dart';
import 'package:littlesignals/core/theme/app_theme.dart';
import 'package:littlesignals/features/report/providers/report_provider.dart';
import 'package:littlesignals/features/report/widgets/behavior_style_card.dart';
import 'package:littlesignals/features/report/widgets/observe_another_button.dart';
import 'package:littlesignals/features/report/widgets/parenting_tips_card.dart';
import 'package:littlesignals/features/report/widgets/result_chart.dart';
import 'package:littlesignals/features/report/widgets/result_interpretation_card.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/models/app_state.dart';
import 'package:littlesignals/providers/app_state_provider.dart';
import 'package:littlesignals/router/app_router.dart';

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
    final calculator = ref.watch(reportCalculatorProvider);

    final attentionResult = appState.attentionResult;
    final impulsivityResult = appState.impulsivityResult;
    final childProfile = appState.profile;

    // 테스트 결과를 TestResult 인터페이스로 추상화
    final TestResult? testResult = isAttention
        ? attentionResult
        : impulsivityResult;

    // 테스트 결과가 없으면 mode selection으로 리다이렉트
    if (testResult == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          ref.read(appStateNotifierProvider.notifier).clearActiveTest();
          context.go(AppRoutes.modeSelection);
        }
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Strategy 패턴을 통한 리포트 데이터 계산 (월령 정보 포함)
    final reportData = calculator.calculate(
      testResult,
      l10n,
      ageMonths: childProfile?.ageMonths,
    );

    void handleObserveAnother() {
      // 다른 관찰하기 시 mode selection 화면으로 이동
      ref.read(appStateNotifierProvider.notifier).clearActiveTest();
      context.go(AppRoutes.modeSelection);
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (!didPop) {
          // 뒤로가기 시 mode selection 화면으로 이동
          ref.read(appStateNotifierProvider.notifier).clearActiveTest();
          context.go(AppRoutes.modeSelection);
        }
      },
      child: Scaffold(
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
                // 결과 해석 카드 (Z점수 분석 결과가 있을 때)
                if (reportData.attentionAnalysis != null ||
                    reportData.impulsivityAnalysis != null) ...[
                  ResultInterpretationCard(
                    attentionAnalysis: reportData.attentionAnalysis,
                    impulsivityAnalysis: reportData.impulsivityAnalysis,
                  ),
                  const SizedBox(height: 16),
                ],
                ResultChart(
                  score: reportData.visualScore,
                  label: l10n.typicalRangeForAge,
                  lowLabel: reportData.lowLabel,
                  highLabel: reportData.highLabel,
                  description: l10n.comparisonDesc,
                  zScoreResult: reportData.zScoreResult,
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
                const SizedBox(height: 16),
                _GetReportButton(
                  label: l10n.getFreeReport,
                  onPressed: () {
                    // TODO: 무료 보고서 받기 기능 구현
                  },
                ),
                const SizedBox(height: 24),
                _DisclaimerText(text: l10n.disclaimer),
                const SizedBox(height: 32),
              ],
            ),
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

class _GetReportButton extends StatelessWidget {
  const _GetReportButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
          backgroundColor: AppTheme.primaryOrange,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
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
