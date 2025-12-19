import 'package:flutter/material.dart';
import 'package:littlesignals/core/theme/app_theme.dart';

class ResultChart extends StatelessWidget {
  const ResultChart({
    super.key,
    required this.score,
    required this.label,
    required this.lowLabel,
    required this.highLabel,
    required this.description,
  });

  final double score;
  final String label;
  final String lowLabel;
  final String highLabel;
  final String description;

  @override
  Widget build(BuildContext context) {
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
