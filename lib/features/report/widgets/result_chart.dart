import 'package:flutter/material.dart';
import 'package:littlesignals/core/theme/app_theme.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/models/z_score_result.dart';

/// Z점수 기반 결과 차트 위젯
///
/// Notion 문서 설계에 따라:
/// - x축: Z점수 (-2 ~ +2 범위)
/// - 회색 띠: 또래 평균 범위 (-1 ≤ z ≤ +1)
/// - 파란 점: 내 아이 위치
/// - 숫자 Z값은 UI에 직접 노출하지 않음
class ResultChart extends StatelessWidget {
  const ResultChart({
    super.key,
    required this.score,
    required this.label,
    required this.lowLabel,
    required this.highLabel,
    required this.description,
    this.zScoreResult,
  });

  /// 시각화 점수 (0-100, Z점수 -2~+2를 변환한 값)
  final double score;

  /// 차트 제목
  final String label;

  /// 왼쪽 라벨 (낮은 값)
  final String lowLabel;

  /// 오른쪽 라벨 (높은 값)
  final String highLabel;

  /// 설명 텍스트
  final String description;

  /// Z점수 결과 (있으면 Z점수 기반 UI, 없으면 기존 UI)
  final ZScoreResult? zScoreResult;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Z점수가 있으면 새로운 UI, 없으면 기존 UI
    if (zScoreResult != null) {
      return _buildZScoreChart(context, l10n);
    }
    return _buildLegacyChart(context);
  }

  /// Z점수 기반 차트 (새로운 디자인)
  Widget _buildZScoreChart(BuildContext context, AppLocalizations l10n) {
    // Z점수를 0-100 위치로 변환 (이미 변환된 score 사용)
    final clampedScore = score.clamp(5.0, 95.0);

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
            l10n.peerRangeLabel,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.slate800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.peerRangeDesc,
            style: const TextStyle(fontSize: 12, color: AppTheme.slate500),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 100,
            child: Stack(
              children: [
                // 또래 평균 범위 회색 띠 (-1 ≤ z ≤ +1 = 25% ~ 75%)
                Positioned(
                  left: 0,
                  right: 0,
                  top: 30,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final startX = constraints.maxWidth * 0.25;
                      final width = constraints.maxWidth * 0.5;
                      return Stack(
                        children: [
                          // 전체 배경 바
                          Container(
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppTheme.slate100,
                            ),
                          ),
                          // 또래 평균 범위 회색 띠
                          Positioned(
                            left: startX,
                            child: Container(
                              width: width,
                              height: 24,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppTheme.slate200,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                // 내 아이 위치 표시
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final dotX = (clampedScore / 100) * constraints.maxWidth;
                      return SizedBox(
                        height: 60,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // "내 아이" 라벨
                            Positioned(
                              left: dotX - 30,
                              top: 0,
                              child: SizedBox(
                                width: 60,
                                child: Text(
                                  l10n.myChild,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                              ),
                            ),
                            // 파란 점
                            Positioned(
                              left: dotX - 12,
                              top: 28,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryBlue,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.15,
                                      ),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Z점수 라벨 표시 (숫자 대신 텍스트)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _buildZScoreLabel(zScoreResult!),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                lowLabel,
                style: const TextStyle(fontSize: 12, color: AppTheme.slate500),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.slate100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  l10n.peerAverage,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppTheme.slate600,
                  ),
                ),
              ),
              Text(
                highLabel,
                style: const TextStyle(fontSize: 12, color: AppTheme.slate500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Z점수 라벨 위젯 (숫자 대신 텍스트로 표시)
  Widget _buildZScoreLabel(ZScoreResult result) {
    final Color chipColor;
    if (result.isWithinPeerRange) {
      chipColor = Colors.green;
    } else if (result.isAbovePeerRange) {
      chipColor = Colors.blue;
    } else {
      chipColor = Colors.orange;
    }

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: chipColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          result.label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: _darkenColor(chipColor),
          ),
        ),
      ),
    );
  }

  /// 기존 차트 (레거시)
  Widget _buildLegacyChart(BuildContext context) {
    final clampedScore = score.clamp(5.0, 95.0);

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
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.slate800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(fontSize: 12, color: AppTheme.slate500),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 80,
            child: Stack(
              children: [
                // Background gradient bar
                Positioned(
                  left: 0,
                  right: 0,
                  top: 30,
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          Colors.amber.shade300.withValues(alpha: 0.3),
                          Colors.green.shade300.withValues(alpha: 0.3),
                          Colors.blue.shade300.withValues(alpha: 0.3),
                        ],
                      ),
                    ),
                  ),
                ),
                // Dashed line
                Positioned(
                  left: 0,
                  right: 0,
                  top: 38,
                  child: CustomPaint(
                    size: const Size(double.infinity, 4),
                    painter: _DashedLinePainter(),
                  ),
                ),
                // Indicator dot with label
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final dotX = (clampedScore / 100) * constraints.maxWidth;
                      return SizedBox(
                        height: 50,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              left: dotX - 40,
                              top: 0,
                              child: SizedBox(
                                width: 80,
                                child: Text(
                                  '내 아이',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: dotX - 10,
                              top: 28,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryBlue,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.1,
                                      ),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                lowLabel,
                style: const TextStyle(fontSize: 12, color: AppTheme.slate500),
              ),
              Text(
                highLabel,
                style: const TextStyle(fontSize: 12, color: AppTheme.slate500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _darkenColor(Color color) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness - 0.15).clamp(0.0, 1.0)).toColor();
  }
}

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.slate400
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashWidth = 4.0;
    const dashSpace = 4.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
