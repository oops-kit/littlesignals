import 'package:freezed_annotation/freezed_annotation.dart';

part 'impulsivity_result.freezed.dart';
part 'impulsivity_result.g.dart';

@freezed
abstract class ImpulsivityResult with _$ImpulsivityResult {
  const factory ImpulsivityResult({
    required double reactionTimeAverage,
    required int commissionErrors,
    required int omissionErrors,
    required int totalStimuli,
    required String completionStatus,
  }) = _ImpulsivityResult;

  factory ImpulsivityResult.fromJson(Map<String, dynamic> json) =>
      _$ImpulsivityResultFromJson(json);
}
