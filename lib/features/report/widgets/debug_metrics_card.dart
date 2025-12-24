import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:littlesignals/core/theme/app_theme.dart';
import 'package:littlesignals/models/attention_result.dart';
import 'package:littlesignals/models/impulsivity_result.dart';
import 'package:littlesignals/models/z_score_result.dart';

/// 디버그용 상세 지표 카드
///
/// kDebugMode일 때만 표시됩니다.
/// 기획서에서 "UI에 노출하지 말라"고 한 Z점수 등 내부 계산값을 표시합니다.
class DebugMetricsCard extends StatelessWidget {
  const DebugMetricsCard({
    super.key,
    this.attentionResult,
    this.impulsivityResult,
    this.attentionAnalysis,
    this.impulsivityAnalysis,
  });

  final AttentionResult? attentionResult;
  final ImpulsivityResult? impulsivityResult;
  final AttentionAnalysisResult? attentionAnalysis;
  final ImpulsivityAnalysisResult? impulsivityAnalysis;

  @override
  Widget build(BuildContext context) {
    // 릴리즈 모드에서는 표시하지 않음
    if (!kDebugMode) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amber.shade300, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.bug_report, color: Colors.amber.shade700, size: 20),
              const SizedBox(width: 8),
              Text(
                '🔧 DEBUG MODE - 내부 계산값',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (attentionAnalysis != null) _buildAttentionDebug(),
          if (impulsivityAnalysis != null) _buildImpulsivityDebug(),
          if (attentionResult != null) _buildAttentionRawData(),
          if (impulsivityResult != null) _buildImpulsivityRawData(),
        ],
      ),
    );
  }

  Widget _buildAttentionDebug() {
    final analysis = attentionAnalysis!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('📊 주의력 Z점수 분석'),
        _debugRow('MER (원본)', analysis.mer.toStringAsFixed(4)),
        _debugRow('MER Z점수', analysis.merZScore.zScore.toStringAsFixed(3)),
        _debugRow('MER 또래평균(μ)', analysis.merZScore.peerMean.toStringAsFixed(3)),
        _debugRow('MER 표준편차(σ)', analysis.merZScore.peerStdDev.toStringAsFixed(3)),
        _debugRow('MER 라벨', analysis.merZScore.label),
        const Divider(height: 16),
        _debugRow('재확인율 (원본)', analysis.revisitingRate.toStringAsFixed(4)),
        _debugRow('재확인율 Z점수', analysis.revisitingRateZScore.zScore.toStringAsFixed(3)),
        _debugRow('재확인율 또래평균(μ)', analysis.revisitingRateZScore.peerMean.toStringAsFixed(3)),
        _debugRow('재확인율 표준편차(σ)', analysis.revisitingRateZScore.peerStdDev.toStringAsFixed(3)),
        const Divider(height: 16),
        _debugRow('평균 반응시간', '${analysis.avgReactionTime.toStringAsFixed(2)}초'),
        _debugRow('반응시간 정상범위', analysis.isReactionTimeNormal ? '✅ 예' : '❌ 아니오'),
        _debugRow('행동 패턴', analysis.behaviorPattern.name),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildImpulsivityDebug() {
    final analysis = impulsivityAnalysis!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('📊 충동성 Z점수 분석'),
        _debugRow('억제비율 (원본)', analysis.inhibitionRate.toStringAsFixed(4)),
        _debugRow('억제비율 Z점수', analysis.inhibitionZScore.zScore.toStringAsFixed(3)),
        _debugRow('억제비율 또래평균(μ)', analysis.inhibitionZScore.peerMean.toStringAsFixed(3)),
        _debugRow('억제비율 표준편차(σ)', analysis.inhibitionZScore.peerStdDev.toStringAsFixed(3)),
        _debugRow('억제비율 라벨', analysis.inhibitionZScore.label),
        const Divider(height: 16),
        _debugRow('평균 반응시간', '${analysis.avgReactionTime.toStringAsFixed(0)}ms'),
        _debugRow('빠른 반응자', analysis.isFastReactor ? '✅ 예' : '❌ 아니오'),
        _debugRow('행동 패턴', analysis.behaviorPattern.name),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildAttentionRawData() {
    final result = attentionResult!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('📝 주의력 원본 데이터'),
        _debugRow('총 소요시간', '${result.durationSeconds.toStringAsFixed(1)}초'),
        _debugRow('총 이동(터치) 횟수', '${result.totalMoves}회'),
        _debugRow('총 턴 수', '${result.totalTurns}턴'),
        _debugRow('오류 횟수', '${result.errors}회'),
        _debugRow('재확인 횟수', '${result.revisitCount}회'),
        _debugRow('확인한 카드 수', '${result.uniqueCardsRevealed}장'),
        _debugRow('힌트 사용 횟수', '${result.hintUsedCount}회'),
        _debugRow('무작위 터치', '${result.randomTapCount}회'),
        _debugRow('즉시 반복 오류', '${result.immediateRepeatErrors}회'),
        if (result.reactionTimesMs.isNotEmpty) ...[
          _debugRow('반응시간 목록', '${result.reactionTimesMs.length}개'),
          _debugRow('반응시간 평균', '${(result.reactionTimesMs.reduce((a, b) => a + b) / result.reactionTimesMs.length).toStringAsFixed(0)}ms'),
        ],
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildImpulsivityRawData() {
    final result = impulsivityResult!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('📝 충동성 원본 데이터'),
        _debugRow('총 자극 수', '${result.totalStimuli}개'),
        _debugRow('Commission 오류', '${result.commissionErrors}회 (No-go에 반응)'),
        _debugRow('Omission 오류', '${result.omissionErrors}회 (Go에 미반응)'),
        _debugRow('예측 반응', '${result.anticipatoryResponses}회'),
        _debugRow('평균 반응시간', '${result.reactionTimeAverage.toStringAsFixed(0)}ms'),
        if (result.reactionTimes.isNotEmpty) ...[
          _debugRow('반응시간 목록', '${result.reactionTimes.length}개'),
        ],
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.amber.shade900,
        ),
      ),
    );
  }

  Widget _debugRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: AppTheme.slate600,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppTheme.slate800,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

