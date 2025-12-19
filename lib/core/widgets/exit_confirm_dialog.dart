import 'package:flutter/material.dart';
import 'package:littlesignals/l10n/app_localizations.dart';

/// 게임 종료 확인 다이얼로그
///
/// AttentionTest와 ImpulsivityTest에서 공통으로 사용되는 종료 확인 다이얼로그입니다.
class ExitConfirmDialog extends StatelessWidget {
  const ExitConfirmDialog({super.key, required this.onConfirm});

  final VoidCallback onConfirm;

  /// 다이얼로그를 표시하는 정적 메서드
  static Future<void> show({
    required BuildContext context,
    required VoidCallback onConfirm,
  }) {
    return showDialog(
      context: context,
      builder: (ctx) => ExitConfirmDialog(
        onConfirm: () {
          Navigator.of(ctx).pop();
          onConfirm();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.stopGame),
      content: Text(l10n.progressWillBeLost),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        TextButton(onPressed: onConfirm, child: Text(l10n.confirm)),
      ],
    );
  }
}
