import 'package:flutter/material.dart';
import 'package:littlesignals/core/theme/app_theme.dart';

/// 진행 상황 텍스트 위젯
///
/// "현재 / 전체" 형태로 진행 상황을 표시합니다.
class ProgressText extends StatelessWidget {
  const ProgressText({
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
    return Text(
      '$current / $total',
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(color: color ?? AppTheme.primaryBlue),
    );
  }
}
