import 'package:flutter/material.dart';

/// 게임 진행 상황 표시 위젯
///
/// 화면 하단에 현재/전체 진행 상황을 표시합니다.
class GameProgressIndicator extends StatelessWidget {
  const GameProgressIndicator({
    super.key,
    required this.current,
    required this.total,
    this.color,
  });

  final int current;
  final int total;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Center(
        child: Text(
          '$current / $total',
          style: TextStyle(color: color ?? Colors.grey.shade400, fontSize: 14),
        ),
      ),
    );
  }
}
