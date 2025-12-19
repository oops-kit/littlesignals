import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:littlesignals/core/theme/app_theme.dart';
import 'package:littlesignals/core/widgets/section_header.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/models/app_state.dart';
import 'package:littlesignals/router/app_router.dart';

import 'widgets/test_mode_card.dart';

/// 모드 선택 화면
///
/// 주의력 테스트와 충동성 테스트 중 하나를 선택합니다.
class ModeSelectionScreen extends StatelessWidget {
  const ModeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    void handleSelectMode(TestType testType) {
      // #region agent log
      developer.log(
        '[DEBUG][HypA] Mode selected: $testType (setActiveTest NOT called!)',
        name: 'ModeSelection',
      );
      // #endregion
      context.go(AppRoutes.calibrationPath(testType));
    }

    return Scaffold(
      backgroundColor: AppTheme.slateLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              SectionHeader(
                title: l10n.selectObservation,
                subtitle: l10n.selectActivityDesc,
                alignment: CrossAxisAlignment.start,
              ),
              const SizedBox(height: 32),
              Expanded(
                child: _TestModeCards(
                  attentionTitle: l10n.attentionTitle,
                  attentionDesc: l10n.attentionDesc,
                  impulsivityTitle: l10n.impulsivityTitle,
                  impulsivityDesc: l10n.impulsivityDesc,
                  onSelectAttention: () => handleSelectMode(TestType.attention),
                  onSelectImpulsivity: () =>
                      handleSelectMode(TestType.impulsivity),
                ),
              ),
              const SizedBox(height: 24),
              _NoticeText(text: l10n.doNotDisturbNotice),
            ],
          ),
        ),
      ),
    );
  }
}

class _TestModeCards extends StatelessWidget {
  const _TestModeCards({
    required this.attentionTitle,
    required this.attentionDesc,
    required this.impulsivityTitle,
    required this.impulsivityDesc,
    required this.onSelectAttention,
    required this.onSelectImpulsivity,
  });

  final String attentionTitle;
  final String attentionDesc;
  final String impulsivityTitle;
  final String impulsivityDesc;
  final VoidCallback onSelectAttention;
  final VoidCallback onSelectImpulsivity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: TestModeCard(
            title: attentionTitle,
            description: attentionDesc,
            icon: Icons.psychology_outlined,
            color: AppTheme.attentionOrange,
            backgroundColor: AppTheme.attentionOrangeLight,
            onTap: onSelectAttention,
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: TestModeCard(
            title: impulsivityTitle,
            description: impulsivityDesc,
            icon: Icons.flash_on_outlined,
            color: AppTheme.impulsivitySky,
            backgroundColor: AppTheme.impulsivitySkyLight,
            onTap: onSelectImpulsivity,
          ),
        ),
      ],
    );
  }
}

class _NoticeText extends StatelessWidget {
  const _NoticeText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
