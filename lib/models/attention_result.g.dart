// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attention_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttentionResult _$AttentionResultFromJson(Map<String, dynamic> json) =>
    _AttentionResult(
      durationSeconds: (json['durationSeconds'] as num).toDouble(),
      totalMoves: (json['totalMoves'] as num).toInt(),
      errors: (json['errors'] as num).toInt(),
      completionStatus: $enumDecode(
        _$CompletionStatusEnumMap,
        json['completionStatus'],
      ),
      randomTapCount: (json['randomTapCount'] as num?)?.toInt() ?? 0,
      immediateRepeatErrors:
          (json['immediateRepeatErrors'] as num?)?.toInt() ?? 0,
      firstHalfDurationSeconds:
          (json['firstHalfDurationSeconds'] as num?)?.toDouble() ?? 0.0,
      secondHalfDurationSeconds:
          (json['secondHalfDurationSeconds'] as num?)?.toDouble() ?? 0.0,
      firstHalfTaps: (json['firstHalfTaps'] as num?)?.toInt() ?? 0,
      secondHalfTaps: (json['secondHalfTaps'] as num?)?.toInt() ?? 0,
      eventLogs:
          (json['eventLogs'] as List<dynamic>?)
              ?.map((e) => TestEventLog.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AttentionResultToJson(_AttentionResult instance) =>
    <String, dynamic>{
      'durationSeconds': instance.durationSeconds,
      'totalMoves': instance.totalMoves,
      'errors': instance.errors,
      'completionStatus': _$CompletionStatusEnumMap[instance.completionStatus]!,
      'randomTapCount': instance.randomTapCount,
      'immediateRepeatErrors': instance.immediateRepeatErrors,
      'firstHalfDurationSeconds': instance.firstHalfDurationSeconds,
      'secondHalfDurationSeconds': instance.secondHalfDurationSeconds,
      'firstHalfTaps': instance.firstHalfTaps,
      'secondHalfTaps': instance.secondHalfTaps,
      'eventLogs': instance.eventLogs,
    };

const _$CompletionStatusEnumMap = {
  CompletionStatus.completed: 'completed',
  CompletionStatus.abandoned: 'abandoned',
};
