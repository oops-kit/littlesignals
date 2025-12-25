import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:littlesignals/core/theme/app_theme.dart';
import 'package:littlesignals/features/landing/widgets/app_logo.dart';
import 'package:littlesignals/features/landing/widgets/birthday_dropdown_selector.dart';
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
    final selectedYear = useState<int?>(null);
    final selectedMonth = useState<int?>(null);
    final selectedDay = useState<int?>(null);
    final errorMessage = useState<String?>(null);

    DateTime? getSelectedDate() {
      if (selectedYear.value != null &&
          selectedMonth.value != null &&
          selectedDay.value != null) {
        try {
          return DateTime(
            selectedYear.value!,
            selectedMonth.value!,
            selectedDay.value!,
          );
        } catch (e) {
          return null;
        }
      }
      return null;
    }

    String? getAgeText() {
      final birthDate = getSelectedDate();
      if (birthDate == null) return null;

      final now = DateTime.now();
      final age = now.year - birthDate.year;
      final monthDiff = now.month - birthDate.month;
      final dayDiff = now.day - birthDate.day;

      int totalMonths = age * 12 + monthDiff;
      if (dayDiff < 0) {
        totalMonths--;
      }

      final years = totalMonths ~/ 12;

      return '만 $years세 ($totalMonths개월)';
    }

    void handleStart() {
      final selectedDate = getSelectedDate();
      if (selectedDate == null) {
        errorMessage.value = l10n.enterBirthday;
        return;
      }

      final profile = createProfileFromBirthDate(selectedDate);
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
                  BirthdayDropdownSelector(
                    label: l10n.childBirthday,
                    selectedYear: selectedYear.value,
                    selectedMonth: selectedMonth.value,
                    selectedDay: selectedDay.value,
                    onYearChanged: (value) {
                      selectedYear.value = value;
                      errorMessage.value = null;
                    },
                    onMonthChanged: (value) {
                      selectedMonth.value = value;
                      errorMessage.value = null;
                    },
                    onDayChanged: (value) {
                      selectedDay.value = value;
                      errorMessage.value = null;
                    },
                  ),
                  if (getAgeText() != null) ...[
                    const SizedBox(height: 12),
                    _AgeDisplay(ageText: getAgeText()!),
                  ],
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

class _AgeDisplay extends StatelessWidget {
  const _AgeDisplay({required this.ageText});

  final String ageText;

  @override
  Widget build(BuildContext context) {
    return Text(
      ageText,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppTheme.freshGreen,
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
      if (lastTap != null && now.difference(lastTap).inSeconds > 2) {
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
            content: Text(isDebugMode ? 'Debug Mode ON 🐛' : 'Debug Mode OFF'),
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
