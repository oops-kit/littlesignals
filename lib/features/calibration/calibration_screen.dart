import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:littlesignals/core/constants/app_constants.dart';
import 'package:littlesignals/core/theme/app_theme.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/models/app_state.dart';
import 'package:littlesignals/providers/app_state_provider.dart';
import 'package:littlesignals/router/app_router.dart';

import 'widgets/bubble_row.dart';

/// 캘리브레이션 화면
///
/// 테스트 전에 사용자가 터치에 익숙해지도록 하는 워밍업 화면입니다.
class CalibrationScreen extends HookConsumerWidget {
  const CalibrationScreen({super.key, required this.testType});

  final TestType testType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final poppedCount = useState(0);

    void handlePop() {
      final newCount = poppedCount.value + 1;
      poppedCount.value = newCount;

      if (newCount >= AppConstants.calibrationRequiredTaps) {
        // #region agent log
        developer.log(
          '[DEBUG][HypA] Calibration done, navigating to: $testType, calling setActiveTest NOW',
          name: 'Calibration',
        );
        // #endregion
        // FIX: setActiveTest를 호출하여 activeTest 상태를 설정
        ref.read(appStateNotifierProvider.notifier).setActiveTest(testType);
        Future.delayed(const Duration(milliseconds: 500), () {
          if (context.mounted) {
            switch (testType) {
              case TestType.attention:
                context.go(AppRoutes.attentionTest);
              case TestType.impulsivity:
                context.go(AppRoutes.impulsivityTest);
            }
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
            _Header(title: l10n.warmUp, subtitle: l10n.warmUpDesc),
            const SizedBox(height: 48),
            SizedBox(
              height: 120,
              child: Center(
                child: BubbleRow(
                  poppedCount: poppedCount.value,
                  onPop: handlePop,
                  popText: l10n.pop,
                ),
              ),
            ),
            const SizedBox(height: 32),
            _ProgressText(
              current: poppedCount.value,
              total: AppConstants.calibrationRequiredTaps,
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class _ProgressText extends StatelessWidget {
  const _ProgressText({required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$current / $total',
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(color: AppTheme.primaryBlue),
    );
  }
}
