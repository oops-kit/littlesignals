import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:littlesignals/core/domain/test_result.dart';
import 'package:littlesignals/core/theme/app_theme.dart';
import 'package:littlesignals/features/report/widgets/event_log_card.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/models/app_state.dart';
import 'package:littlesignals/providers/app_state_provider.dart';

/// 이벤트 디버그 화면
///
/// 테스트 실행 중 발생한 이벤트 로그를 보여주는 화면입니다.
class EventDebugScreen extends ConsumerWidget {
  const EventDebugScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final appState = ref.watch(appStateNotifierProvider);
    final isAttention = appState.activeTest == TestType.attention;

    final attentionResult = appState.attentionResult;
    final impulsivityResult = appState.impulsivityResult;

    // 테스트 결과를 TestResult 인터페이스로 추상화
    final TestResult? testResult = isAttention
        ? attentionResult
        : impulsivityResult;

    if (testResult == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: AppTheme.slateLight,
      appBar: AppBar(
        title: Text(l10n.eventDebugTitle),
        backgroundColor: AppTheme.slateLight,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 16),
              // 이벤트 로그 - TestResult 인터페이스 활용
              EventLogCard(
                eventLogs: testResult.eventLogs,
                startTime: testResult.eventLogs.isNotEmpty
                    ? testResult.eventLogs.first.timestamp
                    : null,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

