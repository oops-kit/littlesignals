import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:littlesignals/core/theme/app_theme.dart';
import 'package:littlesignals/core/widgets/exit_confirm_dialog.dart';
import 'package:littlesignals/core/widgets/game_header.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/models/balloon_data.dart';
import 'package:littlesignals/core/constants/app_constants.dart';
import 'package:littlesignals/router/app_router.dart';

import 'providers/impulsivity_test_provider.dart';
import 'widgets/balloon.dart';

/// 충동성 테스트 화면
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

    // 완료 시 리포트 화면으로 이동
    useEffect(() {
      if (testState.isCompleted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            context.go(AppRoutes.report);
          }
        });
      }
      return null;
    }, [testState.isCompleted]);

    void handleExit() {
      ExitConfirmDialog.show(
        context: context,
        onConfirm: () => context.go(AppRoutes.modeSelection),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.impulsivitySkyLight,
      body: SafeArea(
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

            // Intro overlay
            if (testState.gameState == ImpulsivityGameState.intro)
              _IntroOverlay(readyText: l10n.getReady),

            // Balloon
            if (testState.currentBalloon != null)
              _BalloonPositioned(
                balloon: testState.currentBalloon!,
                onTap: controller.handleBalloonClick,
              ),

            // Progress indicator
            _ProgressIndicator(
              current: testState.stimuliCount,
              total: AppConstants.impulsivityTotalStimuli,
            ),
          ],
        ),
      ),
    );
  }
}

class _IntroOverlay extends StatelessWidget {
  const _IntroOverlay({required this.readyText});

  final String readyText;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.1),
      child: Center(
        child: Text(
          readyText,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.lightBlue.shade600,
          ),
        ),
      ),
    );
  }
}

class _BalloonPositioned extends StatelessWidget {
  const _BalloonPositioned({required this.balloon, required this.onTap});

  final BalloonData balloon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width * balloon.x / 100,
      top: MediaQuery.of(context).size.height * balloon.y / 100,
      child: Transform.translate(
        offset: const Offset(-48, -64),
        child: Balloon(isBlue: balloon.isBlue, onTap: onTap),
      ),
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator({required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Center(
        child: Text(
          '$current / $total',
          style: TextStyle(color: Colors.lightBlue.shade400, fontSize: 14),
        ),
      ),
    );
  }
}
