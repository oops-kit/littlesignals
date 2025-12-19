import 'package:flutter/material.dart';

/// 레벨 표시 위젯
///
/// 현재 레벨을 화면 하단에 표시합니다.
class LevelIndicator extends StatelessWidget {
  const LevelIndicator({
    super.key,
    required this.level,
    required this.totalLevels,
    required this.levelLabel,
    this.color,
  });

  final int level;
  final int totalLevels;
  final String levelLabel;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        '$levelLabel $level / $totalLevels',
        style: TextStyle(color: color ?? Colors.grey.shade400, fontSize: 14),
      ),
    );
  }
}
