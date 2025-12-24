import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:littlesignals/models/balloon_data.dart';

/// 풍선 위젯
///
/// 탭 상태에 따라 다른 애니메이션을 표시합니다:
/// - correctTap: 팡! 터지는 효과 (파란 풍선)
/// - incorrectTap: X 표시 효과 (빨간 풍선)
/// - timeout: 페이드아웃
class Balloon extends HookWidget {
  const Balloon({
    super.key,
    required this.isBlue,
    required this.onTap,
    this.tapState = BalloonTapState.none,
  });

  final bool isBlue;
  final VoidCallback onTap;
  final BalloonTapState tapState;

  @override
  Widget build(BuildContext context) {
    // 등장 애니메이션
    final scaleController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    // 팝 애니메이션 (파란 풍선 탭)
    final popController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    // X 효과 애니메이션 (빨간 풍선 탭)
    final xController = useAnimationController(
      duration: const Duration(milliseconds: 400),
    );

    // 페이드아웃 애니메이션 (타임아웃)
    final fadeController = useAnimationController(
      duration: const Duration(milliseconds: 200),
    );

    // 등장 애니메이션 시작
    useEffect(() {
      scaleController.forward();
      return null;
    }, []);

    // 탭 상태 변화 감지
    useEffect(() {
      switch (tapState) {
        case BalloonTapState.correctTap:
          popController.forward();
        case BalloonTapState.incorrectTap:
          xController.forward();
        case BalloonTapState.timeout:
          fadeController.forward();
        case BalloonTapState.none:
          break;
      }
      return null;
    }, [tapState]);

    final scaleAnimation = useAnimation(
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: scaleController, curve: Curves.elasticOut),
      ),
    );

    final popAnimation = useAnimation(
      Tween<double>(begin: 1.0, end: 1.5).animate(
        CurvedAnimation(parent: popController, curve: Curves.easeOut),
      ),
    );

    final popOpacity = useAnimation(
      Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: popController, curve: Curves.easeOut),
      ),
    );

    final xAnimation = useAnimation(
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: xController, curve: Curves.elasticOut),
      ),
    );

    final xFadeOut = useAnimation(
      Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
          parent: xController,
          curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
        ),
      ),
    );

    final fadeAnimation = useAnimation(
      Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: fadeController, curve: Curves.easeOut),
      ),
    );

    final color = isBlue ? Colors.blue.shade500 : Colors.red.shade500;

    // 최종 스케일과 투명도 계산
    double finalScale = scaleAnimation;
    double finalOpacity = 1.0;

    if (tapState == BalloonTapState.correctTap) {
      finalScale = scaleAnimation * popAnimation;
      finalOpacity = popOpacity;
    } else if (tapState == BalloonTapState.incorrectTap) {
      finalOpacity = xFadeOut;
    } else if (tapState == BalloonTapState.timeout) {
      finalOpacity = fadeAnimation;
    }

    return GestureDetector(
      onTap: tapState == BalloonTapState.none ? onTap : null,
      child: Transform.scale(
        scale: finalScale,
        child: Opacity(
          opacity: finalOpacity,
          child: SizedBox(
            width: 96,
            height: 128,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                // Balloon body
                Container(
                  width: 96,
                  height: 120,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(48),
                      topRight: Radius.circular(48),
                      bottomLeft: Radius.circular(48),
                      bottomRight: Radius.circular(48),
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Shine effect
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Container(
                          width: 24,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          transform: Matrix4.rotationZ(0.2),
                        ),
                      ),
                    ],
                  ),
                ),
                // Balloon knot
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                // String
                Positioned(
                  bottom: -40,
                  child: Container(
                    width: 2,
                    height: 48,
                    color: Colors.grey.shade400,
                  ),
                ),
                // 팝 이펙트 파티클 (파란 풍선)
                if (tapState == BalloonTapState.correctTap)
                  _PopParticles(
                    color: color,
                    progress: popController.value,
                  ),
                // X 이펙트 (빨간 풍선)
                if (tapState == BalloonTapState.incorrectTap)
                  _XEffect(
                    progress: xAnimation,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 팡 터지는 파티클 효과
class _PopParticles extends StatelessWidget {
  const _PopParticles({
    required this.color,
    required this.progress,
  });

  final Color color;
  final double progress;

  @override
  Widget build(BuildContext context) {
    if (progress == 0) return const SizedBox.shrink();

    return SizedBox(
      width: 96,
      height: 120,
      child: CustomPaint(
        painter: _ParticlePainter(
          color: color,
          progress: progress,
        ),
      ),
    );
  }
}

class _ParticlePainter extends CustomPainter {
  _ParticlePainter({
    required this.color,
    required this.progress,
  });

  final Color color;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = color.withValues(alpha: 1.0 - progress)
      ..style = PaintingStyle.fill;

    // 8개의 파티클을 원형으로 배치
    const particleCount = 8;
    const baseRadius = 8.0;
    final maxDistance = 60.0 * progress;

    for (int i = 0; i < particleCount; i++) {
      final angle = (i / particleCount) * 2 * pi;
      final distance = maxDistance;
      final particleCenter = Offset(
        center.dx + cos(angle) * distance,
        center.dy + sin(angle) * distance,
      );
      final radius = baseRadius * (1 - progress * 0.5);

      canvas.drawCircle(particleCenter, radius, paint);
    }

    // 작은 파티클 추가
    final smallPaint = Paint()
      ..color = Colors.white.withValues(alpha: 1.0 - progress)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < particleCount; i++) {
      final angle = (i / particleCount) * 2 * pi + pi / particleCount;
      final distance = maxDistance * 0.7;
      final particleCenter = Offset(
        center.dx + cos(angle) * distance,
        center.dy + sin(angle) * distance,
      );

      canvas.drawCircle(particleCenter, 4 * (1 - progress), smallPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

/// X 표시 효과 (빨간 풍선 탭 시)
class _XEffect extends StatelessWidget {
  const _XEffect({
    required this.progress,
  });

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Center(
        child: Transform.scale(
          scale: progress,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withValues(alpha: 0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.close,
                color: Colors.red,
                size: 48,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
