import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:littlesignals/features/attention_test/attention_test_screen.dart';
import 'package:littlesignals/features/calibration/calibration_screen.dart';
import 'package:littlesignals/features/impulsivity_test/impulsivity_test_screen.dart';
import 'package:littlesignals/features/landing/landing_screen.dart';
import 'package:littlesignals/features/mode_selection/mode_selection_screen.dart';
import 'package:littlesignals/features/report/report_screen.dart';
import 'package:littlesignals/models/app_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

abstract class AppRoutes {
  static const String landing = '/';
  static const String modeSelection = '/mode-selection';
  static const String calibration = '/calibration/:testType';
  static const String attentionTest = '/attention-test';
  static const String impulsivityTest = '/impulsivity-test';
  static const String report = '/report';

  static String calibrationPath(TestType testType) =>
      '/calibration/${testType.name}';
}

/// ShellRoute용 빈 Shell 위젯
///
/// 상태 유지를 위해 Landing 외의 모든 화면을 감싸는 역할만 수행합니다.
class _AppShell extends StatelessWidget {
  const _AppShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.landing,
    debugLogDiagnostics: false,
    routerNeglect: false,
    routes: [
      // Landing 화면은 독립 라우트
      GoRoute(
        path: AppRoutes.landing,
        name: 'landing',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LandingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      // ShellRoute: Landing 외의 모든 화면을 감싸서 상태 유지
      ShellRoute(
        builder: (context, state, child) => _AppShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.modeSelection,
            name: 'modeSelection',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const ModeSelectionScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
            ),
          ),
          GoRoute(
            path: AppRoutes.calibration,
            name: 'calibration',
            pageBuilder: (context, state) {
              final testTypeStr = state.pathParameters['testType']!;
              final testType = TestType.values.byName(testTypeStr);
              return CustomTransitionPage(
                key: state.pageKey,
                child: CalibrationScreen(testType: testType),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
              );
            },
          ),
          GoRoute(
            path: AppRoutes.attentionTest,
            name: 'attentionTest',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const AttentionTestScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
            ),
          ),
          GoRoute(
            path: AppRoutes.impulsivityTest,
            name: 'impulsivityTest',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const ImpulsivityTestScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
            ),
          ),
          GoRoute(
            path: AppRoutes.report,
            name: 'report',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const ReportScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
            ),
          ),
        ],
      ),
    ],
  );
}
