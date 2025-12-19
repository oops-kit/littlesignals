import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// 캘리브레이션 화면에서 사용되는 버블 위젯
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
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 600),
    );

    useEffect(() {
      Future.delayed(Duration(milliseconds: animationDelay), () {
        if (context.mounted) {
          controller.repeat(reverse: true);
        }
      });
      return null;
    }, []);

    final bounceAnimation = useAnimation(
      Tween<double>(
        begin: 0,
        end: -10,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
    );

    if (isPopped) {
      return const SizedBox(width: 64, height: 64);
    }

    return Transform.translate(
      offset: Offset(0, bounceAnimation),
      child: GestureDetector(
        onTap: onTap,
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
    );
  }
}
