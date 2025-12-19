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
    );

Map<String, dynamic> _$ImpulsivityResultToJson(_ImpulsivityResult instance) =>
    <String, dynamic>{
      'reactionTimeAverage': instance.reactionTimeAverage,
      'commissionErrors': instance.commissionErrors,
      'omissionErrors': instance.omissionErrors,
      'totalStimuli': instance.totalStimuli,
      'completionStatus': instance.completionStatus,
    };
