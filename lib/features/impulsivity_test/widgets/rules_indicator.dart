import 'package:flutter/material.dart';

/// 파란/빨간 풍선 규칙 안내 위젯
class RulesIndicator extends StatelessWidget {
  const RulesIndicator({
    super.key,
    required this.blueTapText,
    required this.redNoTapText,
  });

  final String blueTapText;
  final String redNoTapText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _RuleBadge(color: Colors.blue, text: blueTapText),
          const SizedBox(width: 12),
          _RuleBadge(color: Colors.red, text: redNoTapText),
        ],
      ),
    );
  }
}

class _RuleBadge extends StatelessWidget {
  const _RuleBadge({required this.color, required this.text});

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
