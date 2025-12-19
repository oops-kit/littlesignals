import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlesignals/core/domain/report_calculator.dart';
import 'package:littlesignals/features/report/calculators/attention_report_calculator.dart';
import 'package:littlesignals/features/report/calculators/impulsivity_report_calculator.dart';
import 'package:littlesignals/models/app_state.dart';
import 'package:littlesignals/providers/app_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_provider.g.dart';

/// 테스트 타입에 따른 ReportCalculator를 반환하는 Provider
///
/// Strategy 패턴을 적용하여 테스트 타입별로 적절한 계산기를 주입합니다.
@riverpod
ReportCalculator reportCalculator(Ref ref) {
  final appState = ref.watch(appStateNotifierProvider);
  final isAttention = appState.activeTest == TestType.attention;

  return isAttention
      ? const AttentionReportCalculator()
      : const ImpulsivityReportCalculator();
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
