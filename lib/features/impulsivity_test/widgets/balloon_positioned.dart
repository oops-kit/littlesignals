import 'package:flutter/material.dart';
import 'package:littlesignals/features/impulsivity_test/widgets/balloon.dart';
import 'package:littlesignals/models/balloon_data.dart';

/// 화면에 위치한 풍선 위젯
class BalloonPositioned extends StatelessWidget {
  const BalloonPositioned({
    super.key,
    required this.balloon,
    required this.onTap,
  });

  final BalloonData balloon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width * balloon.x / 100,
      top: MediaQuery.of(context).size.height * balloon.y / 100,
      child: Transform.translate(
        offset: const Offset(-48, -64),
        child: Balloon(
          isBlue: balloon.isBlue,
          onTap: onTap,
          tapState: balloon.tapState,
        ),
      ),
    );
  }
}
