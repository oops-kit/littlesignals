import 'package:flutter/material.dart';
import 'package:littlesignals/features/attention_test/widgets/flip_card.dart';
import 'package:littlesignals/models/card_data.dart';

/// 카드 그리드 위젯
///
/// 주의력 테스트에서 카드들을 그리드 형태로 표시합니다.
class CardGrid extends StatelessWidget {
  const CardGrid({
    super.key,
    required this.cards,
    required this.columns,
    required this.hintCardId,
    required this.onCardTap,
    this.level = 1,
  });

  final List<CardData> cards;
  final int columns;
  final int? hintCardId;
  final void Function(int) onCardTap;

  /// 현재 레벨 (카드 key 생성에 사용)
  final int level;

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
                // 레벨 정보를 key에 포함하여 레벨 전환 시 위젯 재생성
                key: ValueKey('level-$level-card-${card.id}'),
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
