// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'impulsivity_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ImpulsivityResult _$ImpulsivityResultFromJson(Map<String, dynamic> json) =>
    _ImpulsivityResult(
      reactionTimeAverage: (json['reactionTimeAverage'] as num).toDouble(),
      commissionErrors: (json['commissionErrors'] as num).toInt(),
      omissionErrors: (json['omissionErrors'] as num).toInt(),
      totalStimuli: (json['totalStimuli'] as num).toInt(),
      completionStatus: json['completionStatus'] as String,
      anticipatoryResponses:
          (json['anticipatoryResponses'] as num?)?.toInt() ?? 0,
      reactionTimes:
          (json['reactionTimes'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      eventLogs:
          (json['eventLogs'] as List<dynamic>?)
              ?.map((e) => TestEventLog.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ImpulsivityResultToJson(_ImpulsivityResult instance) =>
    <String, dynamic>{
      'reactionTimeAverage': instance.reactionTimeAverage,
      'commissionErrors': instance.commissionErrors,
      'omissionErrors': instance.omissionErrors,
      'totalStimuli': instance.totalStimuli,
      'completionStatus': instance.completionStatus,
      'anticipatoryResponses': instance.anticipatoryResponses,
      'reactionTimes': instance.reactionTimes,
      'eventLogs': instance.eventLogs,
    };
