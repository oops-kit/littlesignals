import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Balloon extends HookWidget {
  const Balloon({super.key, required this.isBlue, required this.onTap});

  final bool isBlue;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scaleController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    useEffect(() {
      scaleController.forward();
      return null;
    }, []);

    final scaleAnimation = useAnimation(
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: scaleController, curve: Curves.elasticOut),
      ),
    );

    final color = isBlue ? Colors.blue.shade500 : Colors.red.shade500;

    return GestureDetector(
      onTap: onTap,
      child: Transform.scale(
        scale: scaleAnimation,
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
            ],
          ),
        ),
      ),
    );
  }
}
