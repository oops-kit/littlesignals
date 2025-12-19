import 'package:littlesignals/models/test_event_log.dart';

/// 테스트 결과의 공통 인터페이스
///
/// 모든 테스트 결과 타입이 구현해야 하는 추상 클래스입니다.
/// OCP를 위해 새로운 테스트 타입 추가 시 이 인터페이스를 구현합니다.
abstract class TestResult {
  /// 테스트 소요 시간 (초)
  double get durationSeconds;

  /// 테스트 완료 상태
  String get completionStatusString;

  /// 테스트 중 발생한 이벤트 로그
  List<TestEventLog> get eventLogs;

  /// 테스트가 정상 완료되었는지 여부
  bool get isCompleted;
}
