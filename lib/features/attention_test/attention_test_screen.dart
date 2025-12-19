import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:littlesignals/core/theme/app_theme.dart';
import 'package:littlesignals/core/widgets/exit_confirm_dialog.dart';
import 'package:littlesignals/core/widgets/game_header.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/router/app_router.dart';

import 'providers/attention_test_provider.dart';
import 'widgets/flip_card.dart';

/// 주의력 테스트 화면
class AttentionTestScreen extends HookConsumerWidget {
  const AttentionTestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final testState = ref.watch(attentionTestControllerProvider);
    final controller = ref.read(attentionTestControllerProvider.notifier);

    // 초기화
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.setupLevel(1);
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

    final columns = testState.level == 1 ? 3 : 4;

    return Scaffold(
      backgroundColor: AppTheme.attentionOrangeLight,
      body: SafeArea(
        child: Column(
          children: [
            GameHeader(
              title: l10n.findAnimalFriends,
              exitLabel: l10n.exit,
              onExit: handleExit,
              titleColor: Colors.orange.shade800,
              exitColor: Colors.orange.shade400,
            ),
            Expanded(
              child: _CardGrid(
                cards: testState.cards,
                columns: columns,
                hintCardId: testState.hintCardId,
                onCardTap: controller.handleCardClick,
              ),
            ),
            _LevelIndicator(level: testState.level, levelLabel: l10n.level),
          ],
        ),
      ),
    );
  }
}

class _CardGrid extends StatelessWidget {
  const _CardGrid({
    required this.cards,
    required this.columns,
    required this.hintCardId,
    required this.onCardTap,
  });

  final List cards;
  final int columns;
  final int? hintCardId;
  final void Function(int) onCardTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemCount: cards.length,
            itemBuilder: (context, index) {
              final card = cards[index];
              return FlipCard(
                key: ValueKey(card.id),
                card: card,
                isHinting: hintCardId == card.id,
                onTap: () => onCardTap(card.id),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _LevelIndicator extends StatelessWidget {
  const _LevelIndicator({required this.level, required this.levelLabel});

  final int level;
  final String levelLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        '$levelLabel $level / 2',
        style: TextStyle(color: Colors.orange.shade400, fontSize: 14),
      ),
    );
  }
}
