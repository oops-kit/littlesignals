import 'package:flutter/material.dart';
import 'package:littlesignals/core/constants/app_constants.dart';
import 'package:littlesignals/features/calibration/widgets/calibration_bubble.dart';

/// 캘리브레이션 화면에서 버블들을 가로로 배치하는 위젯
class BubbleRow extends StatelessWidget {
  const BubbleRow({
    super.key,
    required this.poppedIndices,
    required this.onPop,
    required this.popText,
  });

  final Set<int> poppedIndices;
  final void Function(int index) onPop;
  final String popText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(AppConstants.calibrationRequiredTaps, (index) {
        final isPopped = poppedIndices.contains(index);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: CalibrationBubble(
            isPopped: isPopped,
            onTap: isPopped ? null : () => onPop(index),
            animationDelay: index * 200,
            popText: popText,
          ),
        );
      }),
    );
  }
}
