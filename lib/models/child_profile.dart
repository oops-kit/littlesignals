import 'package:freezed_annotation/freezed_annotation.dart';

part 'child_profile.freezed.dart';
part 'child_profile.g.dart';

@freezed
abstract class ChildProfile with _$ChildProfile {
  const factory ChildProfile({
    required DateTime dateOfBirth,
    required double ageMonths,
  }) = _ChildProfile;

  factory ChildProfile.fromJson(Map<String, dynamic> json) =>
      _$ChildProfileFromJson(json);
}

/// Helper function to create ChildProfile from birth date
ChildProfile createProfileFromBirthDate(DateTime birthDate) {
  final now = DateTime.now();
  final ageMonths = (now.difference(birthDate).inDays / 30.44).roundToDouble();
  return ChildProfile(dateOfBirth: birthDate, ageMonths: ageMonths);
}
