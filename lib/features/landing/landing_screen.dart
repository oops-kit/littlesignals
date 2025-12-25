import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:littlesignals/core/theme/app_theme.dart';
import 'package:littlesignals/features/landing/widgets/app_logo.dart';
import 'package:littlesignals/features/landing/widgets/date_selector.dart';
import 'package:littlesignals/features/landing/widgets/primary_button.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/models/child_profile.dart';
import 'package:littlesignals/providers/app_state_provider.dart';
import 'package:littlesignals/providers/debug_mode_provider.dart';
import 'package:littlesignals/router/app_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// 랜딩 화면
///
/// 앱 시작 시 표시되는 화면으로, 아이의 생년월일을 입력받습니다.
class LandingScreen extends HookConsumerWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final selectedDate = useState<DateTime?>(null);
    final errorMessage = useState<String?>(null);

    Future<void> selectDate() async {
      final now = DateTime.now();
      final picked = await showDatePicker(
        context: context,
        initialDate: DateTime(now.year - 3, now.month, now.day),
        firstDate: DateTime(now.year - 5),
        lastDate: DateTime(now.year - 2),
        helpText: l10n.childBirthday,
      );
      if (picked != null) {
        selectedDate.value = picked;
        errorMessage.value = null;
      }
    }

    void handleStart() {
      if (selectedDate.value == null) {
        errorMessage.value = l10n.enterBirthday;
        return;
      }

      final profile = createProfileFromBirthDate(selectedDate.value!);
      ref.read(appStateNotifierProvider.notifier).setProfile(profile);
      context.go(AppRoutes.modeSelection);
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppLogo(),
                  const SizedBox(height: 32),
                  _Title(title: l10n.appTitle),
                  const SizedBox(height: 16),
                  _Subtitle(subtitle: l10n.landingSubtitle),
                  const SizedBox(height: 48),
                  DateSelector(
                    label: l10n.childBirthday,
                    selectedDate: selectedDate.value,
                    onTap: selectDate,
                  ),
                  if (errorMessage.value != null) ...[
                    const SizedBox(height: 8),
                    _ErrorMessage(message: errorMessage.value!),
                  ],
                  const SizedBox(height: 32),
                  PrimaryButton(
                    label: l10n.startButton,
                    onPressed: handleStart,
                  ),
                  const SizedBox(height: 48),
                  const _VersionText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppTheme.slate800,
        letterSpacing: -0.5,
      ),
    );
  }
}

class _Subtitle extends StatelessWidget {
  const _Subtitle({required this.subtitle});

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 14,
        color: AppTheme.slate500,
        height: 1.5,
      ),
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: message,
        style: const TextStyle(fontSize: 14, color: Colors.red),
      ),
    );
  }
}

class _VersionText extends HookConsumerWidget {
  const _VersionText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final versionInfo = useState<String>('');
    final tapCount = useState<int>(0);
    final lastTapTime = useState<DateTime?>(null);

    useEffect(() {
      PackageInfo.fromPlatform().then((info) {
        versionInfo.value = 'v${info.version}+${info.buildNumber}';
      });
      return null;
    }, []);

    void handleTap() {
      final now = DateTime.now();
      final lastTap = lastTapTime.value;
      
      // 2초 이내에 탭하지 않으면 카운트 리셋
      if (lastTap != null && 
          now.difference(lastTap).inSeconds > 2) {
        tapCount.value = 0;
      }
      
      tapCount.value++;
      lastTapTime.value = now;
      
      // 5번 탭하면 디버그 모드 토글
      if (tapCount.value >= 5) {
        ref.read(debugModeProvider.notifier).toggle();
        tapCount.value = 0;
        
        // 디버그 모드 상태 표시
        final isDebugMode = ref.read(debugModeProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isDebugMode ? 'Debug Mode ON 🐛' : 'Debug Mode OFF',
            ),
            duration: const Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }

    return GestureDetector(
      onTap: handleTap,
      child: Text(
        versionInfo.value,
        style: const TextStyle(fontSize: 12, color: AppTheme.slate400),
      ),
    );
  }
}
