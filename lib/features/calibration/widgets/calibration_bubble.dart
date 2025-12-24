import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// 캘리브레이션 화면에서 사용되는 버블 위젯
///
/// 터치하면 팡! 터지는 효과와 함께 사라집니다.
class CalibrationBubble extends HookWidget {
  const CalibrationBubble({
    super.key,
    required this.isPopped,
    required this.onTap,
    required this.animationDelay,
    required this.popText,
  });

  final bool isPopped;
  final VoidCallback? onTap;
  final int animationDelay;
  final String popText;

  @override
  Widget build(BuildContext context) {
    // 바운스 애니메이션
    final bounceController = useAnimationController(
      duration: const Duration(milliseconds: 600),
    );

    // 팝 애니메이션
    final popController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    // 팝 상태 추적
    final isPoppingState = useState(false);

    useEffect(() {
      Future.delayed(Duration(milliseconds: animationDelay), () {
        if (context.mounted && !isPopped && !isPoppingState.value) {
          bounceController.repeat(reverse: true);
        }
      });
      return null;
    }, []);

    // isPopped 상태가 true로 변경되면 팝 애니메이션 시작
    useEffect(() {
      if (isPopped && !isPoppingState.value) {
        isPoppingState.value = true;
        bounceController.stop();
        popController.forward();
      }
      return null;
    }, [isPopped]);

    final bounceAnimation = useAnimation(
      Tween<double>(
        begin: 0,
        end: -10,
      ).animate(CurvedAnimation(parent: bounceController, curve: Curves.easeInOut)),
    );

    final popScale = useAnimation(
      Tween<double>(begin: 1.0, end: 1.5).animate(
        CurvedAnimation(parent: popController, curve: Curves.easeOut),
      ),
    );

    final popOpacity = useAnimation(
      Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: popController, curve: Curves.easeOut),
      ),
    );

    // 팝 애니메이션이 완료되면 빈 공간 반환 (크기 유지하여 레이아웃 흔들림 방지)
    if (isPopped && popController.isCompleted) {
      return const SizedBox(width: 80, height: 80);
    }

    // 팝 중이거나 일반 상태
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 팝 파티클 효과
          if (isPoppingState.value)
            _PopParticles(
              color: Colors.purple.shade400,
              progress: popController.value,
            ),
          // 버블 본체
          Transform.translate(
            offset: Offset(0, isPoppingState.value ? 0 : bounceAnimation),
            child: Transform.scale(
              scale: isPoppingState.value ? popScale : 1.0,
              child: Opacity(
                opacity: isPoppingState.value ? popOpacity : 1.0,
                child: GestureDetector(
                  onTap: isPoppingState.value ? null : onTap,
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.purple.shade400,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.shade200,
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        popText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
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
      width: 80,
      height: 80,
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
    const baseRadius = 6.0;
    final maxDistance = 50.0 * progress;

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

    // 작은 파티클 추가 (흰색)
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

      canvas.drawCircle(particleCenter, 3 * (1 - progress), smallPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
