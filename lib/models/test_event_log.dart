import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_event_log.freezed.dart';
part 'test_event_log.g.dart';

/// 테스트 이벤트 타입
enum TestEventType {
  /// 카드 뒤집기 (주의력)
  @JsonValue('card_flip')
  cardFlip,

  /// 매칭 성공 (주의력)
  @JsonValue('match_success')
  matchSuccess,

  /// 매칭 실패 (주의력)
  @JsonValue('match_fail')
  matchFail,

  /// 무작위 터치 (주의력)
  @JsonValue('random_tap')
  randomTap,

  /// 즉시 반복 오류 (주의력)
  @JsonValue('immediate_repeat')
  immediateRepeat,

  /// 레벨 완료 (주의력)
  @JsonValue('level_complete')
  levelComplete,

  /// 파란 풍선 터치 성공 (충동성)
  @JsonValue('blue_balloon_tap')
  blueBalloonTap,

  /// 빨간 풍선 터치 - Commission Error (충동성)
  @JsonValue('red_balloon_tap')
  redBalloonTap,

  /// 파란 풍선 놓침 - Omission Error (충동성)
  @JsonValue('blue_balloon_miss')
  blueBalloonMiss,

  /// 예측 반응 (충동성)
  @JsonValue('anticipatory_tap')
  anticipatoryTap,

  /// 테스트 시작
  @JsonValue('test_start')
  testStart,

  /// 테스트 완료
  @JsonValue('test_complete')
  testComplete,

  /// Z점수 분석 정보
  @JsonValue('z_score_info')
  zScoreInfo,
}

/// 테스트 이벤트 로그 항목
@freezed
abstract class TestEventLog with _$TestEventLog {
  const factory TestEventLog({
    required TestEventType type,
    required DateTime timestamp,

    /// 이벤트 상세 설명
    required String description,

    /// 추가 데이터 (반응 시간 등)
    int? value,
  }) = _TestEventLog;

  factory TestEventLog.fromJson(Map<String, dynamic> json) =>
      _$TestEventLogFromJson(json);
}
