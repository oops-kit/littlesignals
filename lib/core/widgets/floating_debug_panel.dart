import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:littlesignals/providers/debug_log_provider.dart';
import 'package:littlesignals/providers/debug_mode_provider.dart';

/// 플로팅 디버그 패널
///
/// 오른쪽 하단에 고정되어 디버그 로그를 표시하고 디버그 결과 화면으로 이동할 수 있는 패널입니다.
class FloatingDebugPanel extends ConsumerWidget {
  const FloatingDebugPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDebugMode = ref.watch(debugModeProvider);

    if (!isDebugMode) {
      return const SizedBox.shrink();
    }

    final debugLogState = ref.watch(debugLogProvider);

    return Positioned(
      right: 16,
      bottom: 16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (debugLogState.isPanelExpanded) ...[
            _ExpandedPanel(logs: debugLogState.logs),
            const SizedBox(height: 8),
          ],
          _ToggleButton(isExpanded: debugLogState.isPanelExpanded),
        ],
      ),
    );
  }
}

class _ExpandedPanel extends ConsumerWidget {
  const _ExpandedPanel({required this.logs});

  final List<DebugLogEntry> logs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 320,
      height: 400,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // 헤더
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white24)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.bug_report,
                  color: Colors.greenAccent,
                  size: 16,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Debug Log',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.clear, size: 16),
                  color: Colors.white70,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    ref.read(debugLogProvider.notifier).clearLogs();
                  },
                ),
              ],
            ),
          ),
          // 로그 목록
          Expanded(
            child: logs.isEmpty
                ? const Center(
                    child: Text(
                      'No logs yet',
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    reverse: true,
                    itemCount: logs.length,
                    itemBuilder: (context, index) {
                      final log = logs[logs.length - 1 - index];
                      return _LogEntry(log: log);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _LogEntry extends StatelessWidget {
  const _LogEntry({required this.log});

  final DebugLogEntry log;

  Color _getColorForLevel(DebugLogLevel level) {
    switch (level) {
      case DebugLogLevel.info:
        return Colors.white70;
      case DebugLogLevel.warning:
        return Colors.orangeAccent;
      case DebugLogLevel.error:
        return Colors.redAccent;
      case DebugLogLevel.success:
        return Colors.greenAccent;
    }
  }

  IconData _getIconForLevel(DebugLogLevel level) {
    switch (level) {
      case DebugLogLevel.info:
        return Icons.info_outline;
      case DebugLogLevel.warning:
        return Icons.warning_amber_outlined;
      case DebugLogLevel.error:
        return Icons.error_outline;
      case DebugLogLevel.success:
        return Icons.check_circle_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColorForLevel(log.level);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(_getIconForLevel(log.level), size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            log.formattedTime,
            style: TextStyle(
              color: Colors.white38,
              fontSize: 10,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              log.message,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleButton extends ConsumerWidget {
  const _ToggleButton({required this.isExpanded});

  final bool isExpanded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.small(
      onPressed: () {
        ref.read(debugLogProvider.notifier).togglePanel();
      },
      backgroundColor: Colors.black87,
      child: Icon(
        isExpanded ? Icons.close : Icons.bug_report,
        color: Colors.greenAccent,
        size: 20,
      ),
    );
  }
}
