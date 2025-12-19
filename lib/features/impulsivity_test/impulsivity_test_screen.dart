import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:littlesignals/core/constants/app_constants.dart';
import 'package:littlesignals/core/theme/app_theme.dart';
import 'package:littlesignals/core/widgets/countdown_overlay.dart';
import 'package:littlesignals/core/widgets/debug_event_listener.dart';
import 'package:littlesignals/core/widgets/exit_confirm_dialog.dart';
import 'package:littlesignals/core/widgets/game_header.dart';
import 'package:littlesignals/core/widgets/game_progress_indicator.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/models/balloon_data.dart';
import 'package:littlesignals/router/app_router.dart';

import 'providers/impulsivity_test_provider.dart';
import 'providers/impulsivity_test_state.dart';
import 'widgets/balloon_positioned.dart';
import 'widgets/rules_indicator.dart';

/// 충동성 테스트 화면
///
/// SRP: UI 구성에만 집중, 디버그 로깅은 DebugEventListener에 위임
class ImpulsivityTestScreen extends HookConsumerWidget {
  const ImpulsivityTestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final testState = ref.watch(impulsivityTestControllerProvider);
    final controller = ref.read(impulsivityTestControllerProvider.notifier);

    // 게임 시작
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.startGame();
      });
      return null;
    }, []);

    // SRP: 완료 시 네비게이션을 ref.listen()으로 처리
    // 상태 변화 감지를 통한 side effect 처리 패턴
    ref.listen<ImpulsivityTestState>(impulsivityTestControllerProvider, (
      previous,
      next,
    ) {
      // 이전 상태가 미완료이고 현재 상태가 완료된 경우에만 네비게이션
      if (previous?.isCompleted != true && next.isCompleted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            context.go(AppRoutes.report);
          }
        });
      }
    });

    void handleExit() {
      ExitConfirmDialog.show(
        context: context,
        onConfirm: () => context.go(AppRoutes.modeSelection),
      );
    }

    // SRP: 디버그 로깅을 DebugEventListener에 위임
    return DebugEventListener(
      eventLogs: testState.eventLogs,
      child: Scaffold(
        backgroundColor: AppTheme.impulsivitySkyLight,
        body: SafeArea(
          child: GestureDetector(
            // 화면 전체 터치 감지 (예측 반응 측정용)
            onTapDown: (_) => controller.handleScreenTap(),
            behavior: HitTestBehavior.translucent,
            child: Stack(
              children: [
                // HUD
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: GameHeader(
                    title: l10n.balloonGame,
                    exitLabel: l10n.exit,
                    onExit: handleExit,
                    titleColor: Colors.lightBlue.shade800,
                    exitColor: Colors.lightBlue.shade400,
                  ),
                ),

                // 규칙 안내
                Positioned(
                  top: 56,
                  left: 0,
                  right: 0,
                  child: RulesIndicator(
                    blueTapText: l10n.blueBalloonTap,
                    redNoTapText: l10n.redBalloonNoTap,
                  ),
                ),

                // 카운트다운 오버레이
                if (testState.gameState == ImpulsivityGameState.countdown &&
                    testState.countdownValue != null)
                  CountdownOverlay(value: testState.countdownValue!),

                // Balloon
                if (testState.currentBalloon != null)
                  BalloonPositioned(
                    balloon: testState.currentBalloon!,
                    onTap: controller.handleBalloonClick,
                  ),

                // Progress indicator
                GameProgressIndicator(
                  current: testState.stimuliCount,
                  total: AppConstants.impulsivityTotalStimuli,
                  color: Colors.lightBlue.shade400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
