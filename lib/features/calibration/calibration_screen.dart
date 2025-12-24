import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:littlesignals/core/constants/app_constants.dart';
import 'package:littlesignals/core/theme/app_theme.dart';
import 'package:littlesignals/core/widgets/progress_text.dart';
import 'package:littlesignals/core/widgets/section_header.dart';
import 'package:littlesignals/features/calibration/widgets/bubble_row.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/models/app_state.dart';
import 'package:littlesignals/providers/app_state_provider.dart';
import 'package:littlesignals/router/app_router.dart';

/// 캘리브레이션 화면
///
/// 테스트 전에 사용자가 터치에 익숙해지도록 하는 워밍업 화면입니다.
class CalibrationScreen extends HookConsumerWidget {
  const CalibrationScreen({super.key, required this.testType});

  final TestType testType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final poppedIndices = useState<Set<int>>({});

    void navigateToTest() {
      switch (testType) {
        case TestType.attention:
          context.go(AppRoutes.attentionTest);
        case TestType.impulsivity:
          context.go(AppRoutes.impulsivityTest);
      }
    }

    void handlePop(int index) {
      final newSet = {...poppedIndices.value, index};
      poppedIndices.value = newSet;

      if (newSet.length >= AppConstants.calibrationRequiredTaps) {
        // #region agent log
        developer.log(
          '[DEBUG][HypA] Calibration done, navigating to: $testType, calling setActiveTest NOW',
          name: 'Calibration',
        );
        // #endregion
        // FIX: setActiveTest를 호출하여 activeTest 상태를 설정
        ref.read(appStateNotifierProvider.notifier).setActiveTest(testType);
        // 바로 테스트 화면으로 이동 (카운트다운은 게임 화면에서)
        Future.delayed(const Duration(milliseconds: 300), () {
          if (context.mounted) {
            navigateToTest();
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: AppTheme.slateLight,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SectionHeader(title: l10n.warmUp, subtitle: l10n.warmUpDesc),
            const SizedBox(height: 48),
            SizedBox(
              height: 120,
              child: Center(
                child: BubbleRow(
                  poppedIndices: poppedIndices.value,
                  onPop: handlePop,
                  popText: l10n.pop,
                ),
              ),
            ),
            const SizedBox(height: 32),
            ProgressText(
              current: poppedIndices.value.length,
              total: AppConstants.calibrationRequiredTaps,
            ),
          ],
        ),
      ),
    );
  }
}
