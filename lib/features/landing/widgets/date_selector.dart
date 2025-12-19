import 'package:flutter/material.dart';
import 'package:littlesignals/core/theme/app_theme.dart';

/// 날짜 선택 위젯
class DateSelector extends StatelessWidget {
  const DateSelector({
    super.key,
    required this.label,
    required this.selectedDate,
    required this.onTap,
  });

  final String label;
  final DateTime? selectedDate;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppTheme.slate400,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.slateLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.slate200),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDate != null
                        ? '${selectedDate!.year}. ${selectedDate!.month}. ${selectedDate!.day}'
                        : label,
                    style: TextStyle(
                      fontSize: 16,
                      color: selectedDate != null
                          ? AppTheme.slate800
                          : AppTheme.slate400,
                    ),
                  ),
                ),
                const Icon(
                  Icons.calendar_today_outlined,
                  color: AppTheme.slate400,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
