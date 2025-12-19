import 'package:flutter/material.dart';

/// 게임 화면의 공통 헤더 위젯
///
/// 제목과 종료 버튼을 포함하는 헤더입니다.
class GameHeader extends StatelessWidget {
  const GameHeader({
    super.key,
    required this.title,
    required this.exitLabel,
    required this.onExit,
    required this.titleColor,
    required this.exitColor,
  });

  final String title;
  final String exitLabel;
  final VoidCallback onExit;
  final Color titleColor;
  final Color exitColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          TextButton(
            onPressed: onExit,
            child: Text(
              exitLabel,
              style: TextStyle(color: exitColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
