import 'package:flutter/material.dart';
import 'package:littlesignals/core/theme/app_theme.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/models/impulsivity_result.dart';

/// 충동성 테스트 관찰 데이터 포인트 카드 위젯
///
/// 충동성 테스트의 상세 관찰 지표를 표시합니다:
/// - 충동성 (Commission Error)
/// - 부주의 (Omission Error)
/// - 반응 시간 (Reaction Time)
class ImpulsivityDataCard extends StatelessWidget {
  const ImpulsivityDataCard({super.key, required this.result});

  final ImpulsivityResult result;

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
          _CommissionErrorSection(
            count: result.commissionErrors,
            total: result.totalStimuli,
            l10n: l10n,
          ),
          const Divider(height: 24),
          _OmissionErrorSection(
            count: result.omissionErrors,
            total: result.totalStimuli,
            l10n: l10n,
          ),
          const Divider(height: 24),
          _ReactionTimeSection(
            averageMs: result.reactionTimeAverage,
            anticipatoryResponses: result.anticipatoryResponses,
            l10n: l10n,
          ),
        ],
      ),
    );
  }
}

/// 충동성(Commission Error) 섹션
class _CommissionErrorSection extends StatelessWidget {
  const _CommissionErrorSection({
    required this.count,
    required this.total,
    required this.l10n,
  });

  final int count;
  final int total;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    // 빨간 풍선 비율은 약 30% (1 - blueRatio)
    final expectedRedBalloons = (total * 0.3).round();
    final isLow = count <= 1;
    final statusColor = isLow ? Colors.green : Colors.orange;
    final statusText = isLow
        ? l10n.impulseControlGood
        : l10n.impulseControlNeeds;

    return _DataPointRow(
      icon: Icons.flash_on,
      iconColor: Colors.red,
      title: l10n.commissionError,
      description: l10n.commissionErrorDesc,
      value: '$count${l10n.times}',
      subtitle: '${l10n.redBalloons}: ~$expectedRedBalloons${l10n.times}',
      statusText: statusText,
      statusColor: statusColor,
    );
  }
}

/// 부주의(Omission Error) 섹션
class _OmissionErrorSection extends StatelessWidget {
  const _OmissionErrorSection({
    required this.count,
    required this.total,
    required this.l10n,
  });

  final int count;
  final int total;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final isLow = count <= 1;
    final statusColor = isLow ? Colors.green : Colors.orange;
    final statusText = isLow ? l10n.attentionGood : l10n.attentionNeeds;

    return _DataPointRow(
      icon: Icons.visibility_off,
      iconColor: Colors.grey,
      title: l10n.omissionError,
      description: l10n.omissionErrorDesc,
      value: '$count${l10n.times}',
      subtitle: null,
      statusText: statusText,
      statusColor: statusColor,
    );
  }
}

/// 반응 시간 섹션
class _ReactionTimeSection extends StatelessWidget {
  const _ReactionTimeSection({
    required this.averageMs,
    required this.anticipatoryResponses,
    required this.l10n,
  });

  final double averageMs;
  final int anticipatoryResponses;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    // 예측 반응이 많으면 충동적인 것으로 판단
    final hasAnticipatoryIssue = anticipatoryResponses >= 2;
    final statusColor = hasAnticipatoryIssue ? Colors.orange : Colors.green;
    final statusText = hasAnticipatoryIssue
        ? l10n.anticipatoryResponseHigh
        : l10n.anticipatoryResponseLow;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DataPointHeader(
          icon: Icons.timer,
          iconColor: Colors.blue,
          title: l10n.reactionTime,
          description: l10n.reactionTimeDesc,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _MetricBlock(
                label: l10n.averageReactionTime,
                value: '${averageMs.toStringAsFixed(0)}ms',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MetricBlock(
                label: l10n.anticipatoryResponse,
                value: '$anticipatoryResponses${l10n.times}',
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

/// 메트릭 블록 위젯
class _MetricBlock extends StatelessWidget {
  const _MetricBlock({required this.label, required this.value});

  final String label;
  final String value;

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
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.slate600,
            ),
          ),
        ],
      ),
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
    required this.subtitle,
    required this.statusText,
    required this.statusColor,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final String value;
  final String? subtitle;
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
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.slate400,
                      ),
                    ),
                  ],
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
          color: _darken(color),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _darken(Color color) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0)).toColor();
  }
}
