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
    );

Map<String, dynamic> _$AttentionResultToJson(_AttentionResult instance) =>
    <String, dynamic>{
      'durationSeconds': instance.durationSeconds,
      'totalMoves': instance.totalMoves,
      'errors': instance.errors,
      'completionStatus': _$CompletionStatusEnumMap[instance.completionStatus]!,
    };

const _$CompletionStatusEnumMap = {
  CompletionStatus.completed: 'completed',
  CompletionStatus.abandoned: 'abandoned',
};
