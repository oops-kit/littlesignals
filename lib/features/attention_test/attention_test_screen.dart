import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:littlesignals/core/theme/app_theme.dart';
import 'package:littlesignals/core/widgets/countdown_overlay.dart';
import 'package:littlesignals/core/widgets/debug_event_listener.dart';
import 'package:littlesignals/core/widgets/exit_confirm_dialog.dart';
import 'package:littlesignals/core/widgets/game_header.dart';
import 'package:littlesignals/features/attention_test/providers/attention_test_provider.dart';
import 'package:littlesignals/features/attention_test/providers/attention_test_state.dart';
import 'package:littlesignals/features/attention_test/widgets/card_grid.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/router/app_router.dart';

/// 주의력 테스트 화면
///
/// SRP: UI 구성에만 집중, 디버그 로깅은 DebugEventListener에 위임
class AttentionTestScreen extends HookConsumerWidget {
  const AttentionTestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final testState = ref.watch(attentionTestControllerProvider);
    final controller = ref.read(attentionTestControllerProvider.notifier);

    // 게임 시작
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.startGame();
      });
      return null;
    }, []);

    // SRP: 완료 시 네비게이션을 ref.listen()으로 처리
    // 상태 변화 감지를 통한 side effect 처리 패턴
    ref.listen<AttentionTestState>(attentionTestControllerProvider, (
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

    // 기획서: 3x2 격자 (3쌍) 고정
    const columns = 3;

    // SRP: 디버그 로깅을 DebugEventListener에 위임
    return DebugEventListener(
      eventLogs: testState.eventLogs,
      child: Scaffold(
        backgroundColor: AppTheme.attentionOrangeLight,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  GameHeader(
                    title: l10n.findAnimalFriends,
                    exitLabel: l10n.exit,
                    onExit: handleExit,
                    titleColor: Colors.orange.shade800,
                    exitColor: Colors.orange.shade400,
                  ),
                  Expanded(
                    child: CardGrid(
                      cards: testState.cards,
                      columns: columns,
                      hintCardId: testState.hintCardId,
                      onCardTap: controller.handleCardClick,
                    ),
                  ),
                  // 기획서: 3쌍 고정, 레벨 시스템 없음
                  const SizedBox(height: 16),
                ],
              ),
              // 카운트다운 오버레이
              if (testState.gameState == AttentionGameState.countdown &&
                  testState.countdownValue != null)
                CountdownOverlay(
                  value: testState.countdownValue!,
                  circleColor: Colors.orange.shade500,
                ),
            ],
          ),
        ),
      ),
    );
  }
}


