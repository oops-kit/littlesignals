import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:littlesignals/models/card_data.dart';

/// 뒤집히는 카드 위젯
class FlipCard extends HookWidget {
  const FlipCard({
    super.key,
    required this.card,
    required this.isHinting,
    required this.onTap,
  });

  final CardData card;
  final bool isHinting;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final flipController = useAnimationController(
      duration: const Duration(milliseconds: 400),
    );

    final bounceController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    useEffect(() {
      if (card.isFlipped || card.isMatched) {
        flipController.forward();
      } else {
        flipController.reverse();
      }
      return null;
    }, [card.isFlipped, card.isMatched]);

    useEffect(() {
      if (isHinting) {
        bounceController.forward().then((_) {
          bounceController.reverse();
        });
      }
      return null;
    }, [isHinting]);

    final flipAnimation = useAnimation(
      Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: flipController, curve: Curves.easeInOut),
      ),
    );

    final bounceAnimation = useAnimation(
      Tween<double>(begin: 1.0, end: 1.1).animate(
        CurvedAnimation(parent: bounceController, curve: Curves.elasticOut),
      ),
    );

    final isShowingFront = flipAnimation >= 0.5;

    return GestureDetector(
      onTap: onTap,
      child: Transform.scale(
        scale: bounceAnimation,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(flipAnimation * pi),
          child: isShowingFront ? _CardFront(card: card) : const _CardBack(),
        ),
      ),
    );
  }
}

class _CardBack extends StatelessWidget {
  const _CardBack();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange.shade400,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Center(
        child: Text(
          '?',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white54,
          ),
        ),
      ),
    );
  }
}

class _CardFront extends StatelessWidget {
  const _CardFront({required this.card});

  final CardData card;

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..rotateY(pi),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: card.isMatched
                ? Colors.green.shade200
                : Colors.orange.shade200,
            width: 4,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            if (card.isMatched)
              Container(
                decoration: BoxDecoration(
                  color: Colors.yellow.shade100.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            Center(
              child: Icon(
                card.icon,
                size: 48,
                color: card.isMatched
                    ? Colors.green.shade500
                    : Colors.orange.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
