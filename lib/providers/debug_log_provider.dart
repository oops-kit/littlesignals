import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_log_provider.g.dart';

/// 디버그 로그 엔트리
class DebugLogEntry {
  const DebugLogEntry({
    required this.timestamp,
    required this.message,
    required this.level,
  });

  final DateTime timestamp;
  final String message;
  final DebugLogLevel level;

  String get formattedTime {
    final time = timestamp;
    return '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}:'
        '${time.second.toString().padLeft(2, '0')}';
  }
}

/// 디버그 로그 레벨
enum DebugLogLevel {
  info,
  warning,
  error,
  success;
}

/// 디버그 로그 상태
class DebugLogState {
  const DebugLogState({
    this.logs = const [],
    this.isPanelExpanded = false,
    this.showResultDebug = false,
  });

  final List<DebugLogEntry> logs;
  final bool isPanelExpanded;
  final bool showResultDebug;

  DebugLogState copyWith({
    List<DebugLogEntry>? logs,
    bool? isPanelExpanded,
    bool? showResultDebug,
  }) {
    return DebugLogState(
      logs: logs ?? this.logs,
      isPanelExpanded: isPanelExpanded ?? this.isPanelExpanded,
      showResultDebug: showResultDebug ?? this.showResultDebug,
    );
  }
}

/// 디버그 로그 Notifier
@riverpod
class DebugLog extends _$DebugLog {
  @override
  DebugLogState build() {
    return const DebugLogState();
  }

  void addLog(String message, {DebugLogLevel level = DebugLogLevel.info}) {
    final entry = DebugLogEntry(
      timestamp: DateTime.now(),
      message: message,
      level: level,
    );
    
    final updatedLogs = [...state.logs, entry];
    // 최대 100개까지만 유지
    if (updatedLogs.length > 100) {
      updatedLogs.removeAt(0);
    }
    
    state = state.copyWith(logs: updatedLogs);
  }

  void clearLogs() {
    state = state.copyWith(logs: []);
  }

  void togglePanel() {
    state = state.copyWith(isPanelExpanded: !state.isPanelExpanded);
  }

  void toggleResultDebug() {
    state = state.copyWith(showResultDebug: !state.showResultDebug);
  }

  void setResultDebug(bool value) {
    state = state.copyWith(showResultDebug: value);
  }
}

