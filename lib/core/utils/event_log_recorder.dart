import 'package:littlesignals/core/domain/event_logger.dart';
import 'package:littlesignals/models/test_event_log.dart';

/// 이벤트 로그 기록 관리 클래스
///
/// [EventLogger] 인터페이스의 기본 구현체입니다.
/// 테스트 중 발생하는 이벤트를 기록합니다.
class EventLogRecorder implements EventLogger {
  EventLogRecorder({List<TestEventLog>? initialLogs})
    : _logs = initialLogs ?? [];

  final List<TestEventLog> _logs;

  /// 현재까지 기록된 모든 로그
  @override
  List<TestEventLog> get logs => List.unmodifiable(_logs);

  /// 새 이벤트 로그 추가
  @override
  void add(TestEventType type, String description, {int? value}) {
    _logs.add(
      TestEventLog(
        type: type,
        timestamp: DateTime.now(),
        description: description,
        value: value,
      ),
    );
  }

  /// 테스트 시작 로그
  @override
  void logTestStart(String message) {
    add(TestEventType.testStart, message);
  }

  /// 테스트 완료 로그
  @override
  void logTestComplete(double durationSeconds) {
    add(
      TestEventType.testComplete,
      '테스트 완료! 총 ${durationSeconds.toStringAsFixed(1)}초',
    );
  }

  /// 레벨 완료 로그
  @override
  void logLevelComplete(int level) {
    add(TestEventType.levelComplete, '레벨 $level 완료! 🌟');
  }

  /// 로그 초기화
  @override
  void clear() {
    _logs.clear();
  }
}
