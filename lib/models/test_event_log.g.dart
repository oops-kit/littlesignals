// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_event_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TestEventLog _$TestEventLogFromJson(Map<String, dynamic> json) =>
    _TestEventLog(
      type: $enumDecode(_$TestEventTypeEnumMap, json['type']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      description: json['description'] as String,
      value: (json['value'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TestEventLogToJson(_TestEventLog instance) =>
    <String, dynamic>{
      'type': _$TestEventTypeEnumMap[instance.type]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'description': instance.description,
      'value': instance.value,
    };

const _$TestEventTypeEnumMap = {
  TestEventType.cardFlip: 'card_flip',
  TestEventType.matchSuccess: 'match_success',
  TestEventType.matchFail: 'match_fail',
  TestEventType.randomTap: 'random_tap',
  TestEventType.immediateRepeat: 'immediate_repeat',
  TestEventType.levelComplete: 'level_complete',
  TestEventType.blueBalloonTap: 'blue_balloon_tap',
  TestEventType.redBalloonTap: 'red_balloon_tap',
  TestEventType.blueBalloonMiss: 'blue_balloon_miss',
  TestEventType.anticipatoryTap: 'anticipatory_tap',
  TestEventType.testStart: 'test_start',
  TestEventType.testComplete: 'test_complete',
  TestEventType.zScoreInfo: 'z_score_info',
};
