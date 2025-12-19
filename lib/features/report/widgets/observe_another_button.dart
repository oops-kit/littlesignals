import 'package:flutter/material.dart';
import 'package:littlesignals/core/theme/app_theme.dart';

/// 다른 특성 관찰하기 버튼
class ObserveAnotherButton extends StatelessWidget {
  const ObserveAnotherButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: const BorderSide(color: AppTheme.slate200),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: AppTheme.slate600,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
