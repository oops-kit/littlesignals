import 'package:flutter/material.dart';
import 'package:littlesignals/core/theme/app_theme.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/models/z_score_result.dart';

/// 핵심 지표 카드 위젯
///
/// MER, 재확인율, 억제 비율 등 주요 지표를 숫자로 표시합니다.
class KeyMetricsCard extends StatelessWidget {
  const KeyMetricsCard({
    super.key,
    this.attentionAnalysis,
    this.impulsivityAnalysis,
  });

  final AttentionAnalysisResult? attentionAnalysis;
  final ImpulsivityAnalysisResult? impulsivityAnalysis;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (attentionAnalysis != null) {
      return _buildAttentionMetrics(context, l10n, attentionAnalysis!);
    } else if (impulsivityAnalysis != null) {
      return _buildImpulsivityMetrics(context, l10n, impulsivityAnalysis!);
    }

    return const SizedBox.shrink();
  }

  Widget _buildAttentionMetrics(
    BuildContext context,
    AppLocalizations l10n,
    AttentionAnalysisResult analysis,
  ) {
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
            l10n.keyMetrics,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.slate800,
            ),
          ),
          const SizedBox(height: 16),
          // MER (Memory Efficiency Ratio)
          _MetricRow(
            icon: Icons.memory,
            iconColor: Colors.blue,
            title: l10n.memoryEfficiencyRatio,
            description: l10n.memoryEfficiencyRatioDesc,
            myValue: '${(analysis.mer * 100).toStringAsFixed(0)}%',
            peerValue: '${(analysis.merZScore.peerMean * 100).toStringAsFixed(0)}%',
            isHigherBetter: true,
            zScore: analysis.merZScore.zScore,
            l10n: l10n,
          ),
          const Divider(height: 24),
          // 재확인율 (Revisiting Rate)
          _MetricRow(
            icon: Icons.replay,
            iconColor: Colors.orange,
            title: l10n.revisitingRate,
            description: l10n.revisitingRateDesc,
            myValue: '${(analysis.revisitingRate * 100).toStringAsFixed(0)}%',
            peerValue: '${(analysis.revisitingRateZScore.peerMean * 100).toStringAsFixed(0)}%',
            isHigherBetter: false,
            zScore: analysis.revisitingRateZScore.zScore,
            l10n: l10n,
          ),
          const Divider(height: 24),
          // 평균 반응 시간
          _MetricRow(
            icon: Icons.timer,
            iconColor: Colors.purple,
            title: l10n.avgReactionTimeSec,
            description: null,
            myValue: '${analysis.avgReactionTime.toStringAsFixed(1)}초',
            peerValue: null,
            isHigherBetter: null,
            zScore: null,
            l10n: l10n,
            isNormal: analysis.isReactionTimeNormal,
          ),
        ],
      ),
    );
  }

  Widget _buildImpulsivityMetrics(
    BuildContext context,
    AppLocalizations l10n,
    ImpulsivityAnalysisResult analysis,
  ) {
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
            l10n.keyMetrics,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.slate800,
            ),
          ),
          const SizedBox(height: 16),
          // 억제 비율 (Inhibition Rate)
          _MetricRow(
            icon: Icons.pan_tool,
            iconColor: Colors.green,
            title: l10n.inhibitionRate,
            description: l10n.inhibitionRateDesc,
            myValue: '${(analysis.inhibitionRate * 100).toStringAsFixed(0)}%',
            peerValue: '${(analysis.inhibitionZScore.peerMean * 100).toStringAsFixed(0)}%',
            isHigherBetter: true,
            zScore: analysis.inhibitionZScore.zScore,
            l10n: l10n,
          ),
          const Divider(height: 24),
          // 평균 반응 시간
          _MetricRow(
            icon: Icons.timer,
            iconColor: Colors.blue,
            title: l10n.avgReactionTimeSec,
            description: null,
            myValue: '${analysis.avgReactionTime.toStringAsFixed(0)}ms',
            peerValue: null,
            isHigherBetter: null,
            zScore: null,
            l10n: l10n,
            showFastLabel: analysis.isFastReactor,
          ),
        ],
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.myValue,
    required this.peerValue,
    required this.isHigherBetter,
    required this.zScore,
    required this.l10n,
    this.isNormal,
    this.showFastLabel,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String? description;
  final String myValue;
  final String? peerValue;
  final bool? isHigherBetter;
  final double? zScore;
  final AppLocalizations l10n;
  final bool? isNormal;
  final bool? showFastLabel;

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
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.slate700,
                        ),
                      ),
                      if (isHigherBetter != null) ...[
                        const SizedBox(width: 4),
                        Text(
                          isHigherBetter! ? l10n.higherIsBetter : l10n.lowerIsBetter,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppTheme.slate400,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (description != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      description!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.slate400,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _ValueBox(
                label: l10n.myChildValue,
                value: myValue,
                isHighlighted: true,
                statusColor: _getStatusColor(),
              ),
            ),
            if (peerValue != null) ...[
              const SizedBox(width: 12),
              Expanded(
                child: _ValueBox(
                  label: l10n.peerAvgLabel,
                  value: peerValue!,
                  isHighlighted: false,
                ),
              ),
            ],
          ],
        ),
        if (showFastLabel != null) ...[
          const SizedBox(height: 8),
          _StatusChip(
            text: showFastLabel! ? '빠른 반응' : '신중한 반응',
            color: showFastLabel! ? Colors.orange : Colors.green,
          ),
        ],
        if (isNormal != null) ...[
          const SizedBox(height: 8),
          _StatusChip(
            text: isNormal! ? '정상 범위' : '범위 외',
            color: isNormal! ? Colors.green : Colors.orange,
          ),
        ],
      ],
    );
  }

  Color? _getStatusColor() {
    if (zScore == null) return null;
    if (zScore! >= -1 && zScore! <= 1) return Colors.green;
    if (zScore! > 1) return Colors.blue;
    return Colors.orange;
  }
}

class _ValueBox extends StatelessWidget {
  const _ValueBox({
    required this.label,
    required this.value,
    required this.isHighlighted,
    this.statusColor,
  });

  final String label;
  final String value;
  final bool isHighlighted;
  final Color? statusColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isHighlighted
            ? (statusColor?.withValues(alpha: 0.1) ?? AppTheme.primaryBlue.withValues(alpha: 0.1))
            : AppTheme.slate100,
        borderRadius: BorderRadius.circular(12),
        border: isHighlighted
            ? Border.all(
                color: statusColor?.withValues(alpha: 0.3) ?? AppTheme.primaryBlue.withValues(alpha: 0.3),
              )
            : null,
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isHighlighted ? (statusColor ?? AppTheme.primaryBlue) : AppTheme.slate400,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isHighlighted ? (statusColor ?? AppTheme.primaryBlue) : AppTheme.slate600,
            ),
          ),
        ],
      ),
    );
  }
}

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
          color: _darkenColor(color),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _darkenColor(Color color) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness - 0.15).clamp(0.0, 1.0)).toColor();
  }
}

