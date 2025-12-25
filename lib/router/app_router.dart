import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:littlesignals/features/attention_test/attention_test_screen.dart';
import 'package:littlesignals/features/calibration/calibration_screen.dart';
import 'package:littlesignals/features/impulsivity_test/impulsivity_test_screen.dart';
import 'package:littlesignals/features/landing/landing_screen.dart';
import 'package:littlesignals/features/mode_selection/mode_selection_screen.dart';
import 'package:littlesignals/features/report/event_debug_screen.dart';
import 'package:littlesignals/features/report/report_screen.dart';
import 'package:littlesignals/features/report/result_debug_screen.dart';
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
  static const String resultDebug = '/result-debug';
  static const String eventDebug = '/event-debug';

  static String calibrationPath(TestType testType) =>
      '/calibration/${testType.name}';
}

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.landing,
    debugLogDiagnostics: false,
    // 웹 브라우저 뒤로가기 지원을 위한 URL 전략
    routerNeglect: false,
    routes: [
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
      GoRoute(
        path: AppRoutes.modeSelection,
        name: 'modeSelection',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ModeSelectionScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: AppRoutes.resultDebug,
        name: 'resultDebug',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ResultDebugScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
        path: AppRoutes.eventDebug,
        name: 'eventDebug',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const EventDebugScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
    ],
  );
}
