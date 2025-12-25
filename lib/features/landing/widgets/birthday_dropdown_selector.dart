import 'package:flutter/material.dart';
import 'package:littlesignals/core/theme/app_theme.dart';

/// 드롭박스 형태의 생년월일 선택 위젯
class BirthdayDropdownSelector extends StatelessWidget {
  const BirthdayDropdownSelector({
    super.key,
    required this.label,
    required this.selectedYear,
    required this.selectedMonth,
    required this.selectedDay,
    required this.onYearChanged,
    required this.onMonthChanged,
    required this.onDayChanged,
  });

  final String label;
  final int? selectedYear;
  final int? selectedMonth;
  final int? selectedDay;
  final ValueChanged<int?> onYearChanged;
  final ValueChanged<int?> onMonthChanged;
  final ValueChanged<int?> onDayChanged;

  List<int> _getYearList() {
    final now = DateTime.now();
    return List.generate(4, (index) => now.year - 2 - index);
  }

  List<int> _getMonthList() {
    return List.generate(12, (index) => index + 1);
  }

  List<int> _getDayList() {
    if (selectedYear == null || selectedMonth == null) {
      return List.generate(31, (index) => index + 1);
    }
    final daysInMonth = DateTime(selectedYear!, selectedMonth! + 1, 0).day;
    return List.generate(daysInMonth, (index) => index + 1);
  }

  @override
  Widget build(BuildContext context) {
    final years = _getYearList();
    final months = _getMonthList();
    final days = _getDayList();

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
        Row(
          children: [
            Expanded(
              flex: 2,
              child: _DropdownField(
                value: selectedYear,
                items: years,
                hint: '년',
                onChanged: onYearChanged,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _DropdownField(
                value: selectedMonth,
                items: months,
                hint: '월',
                onChanged: onMonthChanged,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _DropdownField(
                value: selectedDay,
                items: days,
                hint: '일',
                onChanged: onDayChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DropdownField extends StatelessWidget {
  const _DropdownField({
    required this.value,
    required this.items,
    required this.hint,
    required this.onChanged,
  });

  final int? value;
  final List<int> items;
  final String hint;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppTheme.slateLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.slate200),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: value,
          hint: Text(
            hint,
            style: const TextStyle(
              fontSize: 16,
              color: AppTheme.slate400,
            ),
          ),
          isExpanded: true,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: AppTheme.slate400,
          ),
          dropdownColor: AppTheme.slateLight,
          style: const TextStyle(
            fontSize: 16,
            color: AppTheme.slate800,
          ),
          items: items.map((int item) {
            return DropdownMenuItem<int>(
              value: item,
              child: Text(item.toString()),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

