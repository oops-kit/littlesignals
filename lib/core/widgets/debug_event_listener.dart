import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:littlesignals/models/test_event_log.dart';
import 'package:littlesignals/providers/debug_mode_provider.dart';

/// 디버그 모드에서 이벤트 로그를 SnackBar로 표시하는 위젯
///
/// SRP: 디버그 모드 이벤트 로그 표시만 담당합니다.
/// 테스트 화면에서 이 위젯을 사용하여 UI/로직 분리를 달성합니다.
class DebugEventListener extends HookConsumerWidget {
  const DebugEventListener({
    super.key,
    required this.eventLogs,
    required this.child,
  });

  /// 현재 이벤트 로그 목록
  final List<TestEventLog> eventLogs;

  /// 자식 위젯
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDebugMode = ref.watch(debugModeProvider);
    final prevLogCount = useRef(0);

    useEffect(() {
      if (!isDebugMode) {
        prevLogCount.value = eventLogs.length;
        return null;
      }

      final currentCount = eventLogs.length;
      if (currentCount > prevLogCount.value && eventLogs.isNotEmpty) {
        final newLog = eventLogs.last;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(newLog.description),
                duration: const Duration(milliseconds: 800),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.only(bottom: 80, left: 16, right: 16),
              ),
            );
          }
        });
      }
      prevLogCount.value = currentCount;
      return null;
    }, [eventLogs.length, isDebugMode]);

    return child;
  }
}
