import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:littlesignals/core/domain/test_result.dart';
import 'package:littlesignals/core/theme/app_theme.dart';
import 'package:littlesignals/features/report/providers/report_provider.dart';
import 'package:littlesignals/features/report/widgets/debug_metrics_card.dart';
import 'package:littlesignals/features/report/widgets/impulsivity_data_card.dart';
import 'package:littlesignals/features/report/widgets/key_metrics_card.dart';
import 'package:littlesignals/features/report/widgets/observation_data_card.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/models/app_state.dart';
import 'package:littlesignals/providers/app_state_provider.dart';

/// 결과 디버그 화면
///
/// 테스트 결과의 상세 메트릭과 디버그 정보를 보여주는 화면입니다.
class ResultDebugScreen extends ConsumerWidget {
  const ResultDebugScreen({super.key});

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

    if (testResult == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Strategy 패턴을 통한 리포트 데이터 계산 (월령 정보 포함)
    final reportData = calculator.calculate(
      testResult,
      l10n,
      ageMonths: childProfile?.ageMonths,
    );

    return Scaffold(
      backgroundColor: AppTheme.slateLight,
      appBar: AppBar(
        title: Text(l10n.resultDebugTitle),
        backgroundColor: AppTheme.slateLight,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 16),
              // 디버그 모드에서만 표시되는 내부 계산값 카드
              DebugMetricsCard(
                attentionResult: attentionResult,
                impulsivityResult: impulsivityResult,
                attentionAnalysis: reportData.attentionAnalysis,
                impulsivityAnalysis: reportData.impulsivityAnalysis,
              ),
              const SizedBox(height: 16),
              // 핵심 지표 카드 (Z점수 분석 결과가 있을 때)
              if (reportData.attentionAnalysis != null ||
                  reportData.impulsivityAnalysis != null) ...[
                KeyMetricsCard(
                  attentionAnalysis: reportData.attentionAnalysis,
                  impulsivityAnalysis: reportData.impulsivityAnalysis,
                ),
                const SizedBox(height: 16),
              ],
              // 테스트별 관찰 데이터 포인트 표시
              if (isAttention && attentionResult != null) ...[
                ObservationDataCard(result: attentionResult),
                const SizedBox(height: 16),
              ],
              if (!isAttention && impulsivityResult != null) ...[
                ImpulsivityDataCard(result: impulsivityResult),
                const SizedBox(height: 16),
              ],
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

