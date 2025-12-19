import 'package:flutter/material.dart';

/// 카운트다운 오버레이 위젯
///
/// 게임 시작 전 3, 2, 1 카운트다운을 표시합니다.
class CountdownOverlay extends StatelessWidget {
  const CountdownOverlay({
    super.key,
    required this.value,
    this.backgroundColor,
    this.circleColor,
  });

  final int value;
  final Color? backgroundColor;
  final Color? circleColor;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Colors.black.withValues(alpha: 0.3);
    final fgColor = circleColor ?? Colors.lightBlue.shade500;

    return Container(
      color: bgColor,
      child: Center(
        child: TweenAnimationBuilder<double>(
          key: ValueKey(value),
          tween: Tween(begin: 0.5, end: 1.0),
          duration: const Duration(milliseconds: 300),
          curve: Curves.elasticOut,
          builder: (context, scale, child) {
            return Transform.scale(scale: scale, child: child);
          },
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(color: fgColor, shape: BoxShape.circle),
            child: Center(
              child: Text(
                '$value',
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
