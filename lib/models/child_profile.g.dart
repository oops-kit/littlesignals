// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChildProfile _$ChildProfileFromJson(Map<String, dynamic> json) =>
    _ChildProfile(
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      ageMonths: (json['ageMonths'] as num).toDouble(),
    );

Map<String, dynamic> _$ChildProfileToJson(_ChildProfile instance) =>
    <String, dynamic>{
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      'ageMonths': instance.ageMonths,
    };
