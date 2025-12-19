import 'package:flutter/material.dart';
import 'package:littlesignals/core/theme/app_theme.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/models/attention_result.dart';

/// 관찰 데이터 포인트 카드 위젯
///
/// 주의력 테스트의 상세 관찰 지표를 표시합니다:
/// - 무작위 터치 (Random Tapping)
/// - 지속성 (Sustainability)
/// - 오류 유형 (Error Type)
class ObservationDataCard extends StatelessWidget {
  const ObservationDataCard({super.key, required this.result});

  final AttentionResult result;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.slate100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.observationDataPoints,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.slate600,
            ),
          ),
          const SizedBox(height: 16),
          _RandomTappingSection(count: result.randomTapCount, l10n: l10n),
          const Divider(height: 24),
          _SustainabilitySection(
            firstHalfDuration: result.firstHalfDurationSeconds,
            secondHalfDuration: result.secondHalfDurationSeconds,
            firstHalfTaps: result.firstHalfTaps,
            secondHalfTaps: result.secondHalfTaps,
            l10n: l10n,
          ),
          const Divider(height: 24),
          _ErrorTypeSection(
            immediateRepeatErrors: result.immediateRepeatErrors,
            l10n: l10n,
          ),
        ],
      ),
    );
  }
}

/// 무작위 터치 섹션
class _RandomTappingSection extends StatelessWidget {
  const _RandomTappingSection({required this.count, required this.l10n});

  final int count;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final isLow = count <= 2;
    final statusColor = isLow ? Colors.green : Colors.orange;
    final statusText = isLow ? l10n.attentionFocused : l10n.attentionRandom;

    return _DataPointRow(
      icon: Icons.touch_app,
      iconColor: Colors.orange,
      title: l10n.randomTapping,
      description: l10n.randomTappingDesc,
      value: '$count${l10n.times}',
      statusText: statusText,
      statusColor: statusColor,
    );
  }
}

/// 지속성 섹션
class _SustainabilitySection extends StatelessWidget {
  const _SustainabilitySection({
    required this.firstHalfDuration,
    required this.secondHalfDuration,
    required this.firstHalfTaps,
    required this.secondHalfTaps,
    required this.l10n,
  });

  final double firstHalfDuration;
  final double secondHalfDuration;
  final int firstHalfTaps;
  final int secondHalfTaps;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    // 후반부가 전반부보다 50% 이상 느리면 집중력 저하로 판단
    final firstHalfSpeed = firstHalfTaps > 0
        ? firstHalfDuration / firstHalfTaps
        : 0.0;
    final secondHalfSpeed = secondHalfTaps > 0
        ? secondHalfDuration / secondHalfTaps
        : 0.0;

    final isDecline = secondHalfSpeed > firstHalfSpeed * 1.5;
    final statusColor = isDecline ? Colors.orange : Colors.green;
    final statusText = isDecline
        ? l10n.sustainabilityDecline
        : l10n.sustainabilityGood;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DataPointHeader(
          icon: Icons.timeline,
          iconColor: Colors.blue,
          title: l10n.sustainability,
          description: l10n.sustainabilityDesc,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _TimeBlock(
                label: l10n.firstHalf,
                duration: firstHalfDuration,
                taps: firstHalfTaps,
                l10n: l10n,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _TimeBlock(
                label: l10n.secondHalf,
                duration: secondHalfDuration,
                taps: secondHalfTaps,
                l10n: l10n,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _StatusChip(text: statusText, color: statusColor),
      ],
    );
  }
}

/// 시간 블록 위젯
class _TimeBlock extends StatelessWidget {
  const _TimeBlock({
    required this.label,
    required this.duration,
    required this.taps,
    required this.l10n,
  });

  final String label;
  final double duration;
  final int taps;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.slateLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppTheme.slate400),
          ),
          const SizedBox(height: 4),
          Text(
            '${duration.toStringAsFixed(1)}${l10n.seconds}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.slate600,
            ),
          ),
          Text(
            '$taps${l10n.times}',
            style: const TextStyle(fontSize: 12, color: AppTheme.slate400),
          ),
        ],
      ),
    );
  }
}

/// 오류 유형 섹션
class _ErrorTypeSection extends StatelessWidget {
  const _ErrorTypeSection({
    required this.immediateRepeatErrors,
    required this.l10n,
  });

  final int immediateRepeatErrors;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final isGood = immediateRepeatErrors <= 1;
    final statusColor = isGood ? Colors.green : Colors.orange;
    final statusText = isGood
        ? l10n.workingMemoryGood
        : l10n.workingMemoryLimited;

    return _DataPointRow(
      icon: Icons.psychology,
      iconColor: Colors.purple,
      title: l10n.errorType,
      description: l10n.errorTypeDesc,
      value: '$immediateRepeatErrors${l10n.times}',
      statusText: statusText,
      statusColor: statusColor,
    );
  }
}

/// 데이터 포인트 헤더
class _DataPointHeader extends StatelessWidget {
  const _DataPointHeader({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.slate600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: AppTheme.slate400),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 데이터 포인트 행
class _DataPointRow extends StatelessWidget {
  const _DataPointRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.value,
    required this.statusText,
    required this.statusColor,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final String value;
  final String statusText;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.slate600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.slate400,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _StatusChip(text: statusText, color: statusColor),
      ],
    );
  }
}

/// 상태 칩
class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: color.shade700,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

extension on Color {
  Color get shade700 {
    final hsl = HSLColor.fromColor(this);
    return hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0)).toColor();
  }
}
