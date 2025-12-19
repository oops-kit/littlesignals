import 'package:flutter/material.dart';
import 'package:littlesignals/core/theme/app_theme.dart';

/// 앱 로고 위젯
class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: AppTheme.primaryBlue.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.psychology_outlined,
        size: 48,
        color: AppTheme.primaryBlue,
      ),
    );
  }
}
