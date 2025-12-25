import 'package:flutter/material.dart';
import 'package:littlesignals/core/theme/app_theme.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/models/z_score_result.dart';

/// 결과 해석 카드 위젯
///
/// 결과가 나온 이유와 수치의 의미를 설명합니다.
class ResultInterpretationCard extends StatelessWidget {
  const ResultInterpretationCard({
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
      return _buildAttentionInterpretation(context, l10n, attentionAnalysis!);
    } else if (impulsivityAnalysis != null) {
      return _buildImpulsivityInterpretation(context, l10n, impulsivityAnalysis!);
    }

    return const SizedBox.shrink();
  }

  Widget _buildAttentionInterpretation(
    BuildContext context,
    AppLocalizations l10n,
    AttentionAnalysisResult analysis,
  ) {
    final interpretations = <_InterpretationItem>[];

    // MER 해석
    final merZ = analysis.merZScore.zScore;
    final merValue = (analysis.mer * 100).toStringAsFixed(0);
    final merPeer = (analysis.merZScore.peerMean * 100).toStringAsFixed(0);
    
    if (merZ > 1) {
      interpretations.add(_InterpretationItem(
        icon: Icons.star,
        iconColor: Colors.amber,
        title: '기억 효율 $merValue% (또래 평균 $merPeer%)',
        description: l10n.merHighExplanation,
        isPositive: true,
      ));
    } else if (merZ >= -1) {
      interpretations.add(_InterpretationItem(
        icon: Icons.check_circle,
        iconColor: Colors.green,
        title: '기억 효율 $merValue% (또래 평균 $merPeer%)',
        description: l10n.merAverageExplanation,
        isPositive: true,
      ));
    } else {
      interpretations.add(_InterpretationItem(
        icon: Icons.lightbulb_outline,
        iconColor: Colors.orange,
        title: '기억 효율 $merValue% (또래 평균 $merPeer%)',
        description: l10n.merLowExplanation,
        isPositive: false,
      ));
    }

    // 재확인율 해석
    final revisitZ = analysis.revisitingRateZScore.zScore;
    final revisitValue = (analysis.revisitingRate * 100).toStringAsFixed(0);
    final revisitPeer = (analysis.revisitingRateZScore.peerMean * 100).toStringAsFixed(0);
    
    if (revisitZ > 1) {
      interpretations.add(_InterpretationItem(
        icon: Icons.psychology,
        iconColor: Colors.blue,
        title: '재확인율 $revisitValue% (또래 평균 $revisitPeer%)',
        description: l10n.revisitLowExplanation,
        isPositive: true,
      ));
    } else if (revisitZ >= -1) {
      interpretations.add(_InterpretationItem(
        icon: Icons.check_circle,
        iconColor: Colors.green,
        title: '재확인율 $revisitValue% (또래 평균 $revisitPeer%)',
        description: l10n.revisitAverageExplanation,
        isPositive: true,
      ));
    } else {
      interpretations.add(_InterpretationItem(
        icon: Icons.lightbulb_outline,
        iconColor: Colors.orange,
        title: '재확인율 $revisitValue% (또래 평균 $revisitPeer%)',
        description: l10n.revisitHighExplanation,
        isPositive: false,
      ));
    }

    // 반응시간 해석
    final rtValue = analysis.avgReactionTime.toStringAsFixed(1);
    if (analysis.isReactionTimeNormal) {
      interpretations.add(_InterpretationItem(
        icon: Icons.timer,
        iconColor: Colors.purple,
        title: '평균 반응 시간 $rtValue초',
        description: l10n.reactionNormalExplanation,
        isPositive: true,
      ));
    } else if (analysis.avgReactionTime < 2.0) {
      interpretations.add(_InterpretationItem(
        icon: Icons.flash_on,
        iconColor: Colors.amber,
        title: '평균 반응 시간 $rtValue초',
        description: l10n.reactionFastExplanation,
        isPositive: true,
      ));
    } else {
      interpretations.add(_InterpretationItem(
        icon: Icons.hourglass_bottom,
        iconColor: Colors.teal,
        title: '평균 반응 시간 $rtValue초',
        description: l10n.reactionSlowExplanation,
        isPositive: true,
      ));
    }

    return _buildCard(context, l10n, interpretations);
  }

  Widget _buildImpulsivityInterpretation(
    BuildContext context,
    AppLocalizations l10n,
    ImpulsivityAnalysisResult analysis,
  ) {
    final interpretations = <_InterpretationItem>[];

    // 충동성 (억제 비율) 해석
    final inhibitionZ = analysis.inhibitionZScore.zScore;
    final inhibitionValue = (analysis.inhibitionRate * 100).toStringAsFixed(0);
    final inhibitionPeer = (analysis.inhibitionZScore.peerMean * 100).toStringAsFixed(0);
    
    if (inhibitionZ > 1) {
      interpretations.add(_InterpretationItem(
        icon: Icons.star,
        iconColor: Colors.amber,
        title: '충동성 $inhibitionValue% (또래 평균 $inhibitionPeer%)',
        description: l10n.inhibitionHighExplanation,
        isPositive: true,
      ));
    } else if (inhibitionZ >= -1) {
      interpretations.add(_InterpretationItem(
        icon: Icons.check_circle,
        iconColor: Colors.green,
        title: '충동성 $inhibitionValue% (또래 평균 $inhibitionPeer%)',
        description: l10n.inhibitionAverageExplanation,
        isPositive: true,
      ));
    } else {
      interpretations.add(_InterpretationItem(
        icon: Icons.lightbulb_outline,
        iconColor: Colors.orange,
        title: '충동성 $inhibitionValue% (또래 평균 $inhibitionPeer%)',
        description: l10n.inhibitionLowExplanation,
        isPositive: false,
      ));
    }

    // 부주의 (omission) 해석
    final omissionZ = analysis.omissionZScore.zScore;
    final omissionValue = (analysis.omissionRate * 100).toStringAsFixed(0);
    final omissionPeer = (analysis.omissionZScore.peerMean * 100).toStringAsFixed(0);
    
    if (omissionZ > 1) {
      interpretations.add(_InterpretationItem(
        icon: Icons.visibility,
        iconColor: Colors.blue,
        title: '부주의 $omissionValue% (또래 평균 $omissionPeer%)',
        description: l10n.omissionHighExplanation,
        isPositive: true,
      ));
    } else if (omissionZ >= -1) {
      interpretations.add(_InterpretationItem(
        icon: Icons.check_circle,
        iconColor: Colors.green,
        title: '부주의 $omissionValue% (또래 평균 $omissionPeer%)',
        description: l10n.omissionAverageExplanation,
        isPositive: true,
      ));
    } else {
      interpretations.add(_InterpretationItem(
        icon: Icons.lightbulb_outline,
        iconColor: Colors.orange,
        title: '부주의 $omissionValue% (또래 평균 $omissionPeer%)',
        description: l10n.omissionLowExplanation,
        isPositive: false,
      ));
    }

    // 반응시간 해석
    final rtValue = analysis.avgReactionTime.toStringAsFixed(0);
    if (analysis.isFastReactor) {
      interpretations.add(_InterpretationItem(
        icon: Icons.flash_on,
        iconColor: Colors.amber,
        title: '평균 반응 시간 ${rtValue}ms',
        description: l10n.reactionFastExplanation,
        isPositive: true,
      ));
    } else {
      interpretations.add(_InterpretationItem(
        icon: Icons.hourglass_bottom,
        iconColor: Colors.teal,
        title: '평균 반응 시간 ${rtValue}ms',
        description: l10n.reactionSlowExplanation,
        isPositive: true,
      ));
    }

    return _buildCard(context, l10n, interpretations);
  }

  Widget _buildCard(
    BuildContext context,
    AppLocalizations l10n,
    List<_InterpretationItem> interpretations,
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.indigo.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.analytics_outlined,
                  color: Colors.indigo,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                l10n.resultInterpretation,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.slate800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l10n.whyThisResult,
            style: const TextStyle(
              fontSize: 13,
              color: AppTheme.slate500,
            ),
          ),
          const SizedBox(height: 16),
          ...interpretations.map((item) => _InterpretationTile(item: item)),
        ],
      ),
    );
  }
}

class _InterpretationItem {
  const _InterpretationItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.isPositive,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final bool isPositive;
}

class _InterpretationTile extends StatelessWidget {
  const _InterpretationTile({required this.item});

  final _InterpretationItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: item.iconColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: item.iconColor.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                item.icon,
                color: item.iconColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _darkenColor(item.iconColor),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            item.description,
            style: const TextStyle(
              fontSize: 13,
              color: AppTheme.slate600,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Color _darkenColor(Color color) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness - 0.2).clamp(0.0, 1.0)).toColor();
  }
}

