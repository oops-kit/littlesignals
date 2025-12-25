import 'package:littlesignals/models/test_event_log.dart';

/// 이벤트 로깅 인터페이스
///
/// DIP를 위한 추상화입니다.
/// 테스트 중 발생하는 이벤트를 기록하는 역할을 담당합니다.
abstract class EventLogger {
  /// 현재까지 기록된 모든 로그
  List<TestEventLog> get logs;

  /// 새 이벤트 로그 추가
  void add(TestEventType type, String description, {int? value});

  /// 테스트 시작 로그
  void logTestStart(String message);

  /// 테스트 완료 로그
  void logTestComplete(double durationSeconds);

  /// 레벨 완료 로그
  void logLevelComplete(int level);

  /// Z점수 분석 정보 로그
  void logZScoreInfo(String info);

  /// 로그 초기화
  void clear();
}
