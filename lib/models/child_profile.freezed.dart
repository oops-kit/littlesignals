// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'child_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChildProfile {

 DateTime get dateOfBirth; double get ageMonths;
/// Create a copy of ChildProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChildProfileCopyWith<ChildProfile> get copyWith => _$ChildProfileCopyWithImpl<ChildProfile>(this as ChildProfile, _$identity);

  /// Serializes this ChildProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChildProfile&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.ageMonths, ageMonths) || other.ageMonths == ageMonths));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dateOfBirth,ageMonths);

@override
String toString() {
  return 'ChildProfile(dateOfBirth: $dateOfBirth, ageMonths: $ageMonths)';
}


}

/// @nodoc
abstract mixin class $ChildProfileCopyWith<$Res>  {
  factory $ChildProfileCopyWith(ChildProfile value, $Res Function(ChildProfile) _then) = _$ChildProfileCopyWithImpl;
@useResult
$Res call({
 DateTime dateOfBirth, double ageMonths
});




}
/// @nodoc
class _$ChildProfileCopyWithImpl<$Res>
    implements $ChildProfileCopyWith<$Res> {
  _$ChildProfileCopyWithImpl(this._self, this._then);

  final ChildProfile _self;
  final $Res Function(ChildProfile) _then;

/// Create a copy of ChildProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dateOfBirth = null,Object? ageMonths = null,}) {
  return _then(_self.copyWith(
dateOfBirth: null == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime,ageMonths: null == ageMonths ? _self.ageMonths : ageMonths // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ChildProfile].
extension ChildProfilePatterns on ChildProfile {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChildProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChildProfile() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChildProfile value)  $default,){
final _that = this;
switch (_that) {
case _ChildProfile():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChildProfile value)?  $default,){
final _that = this;
switch (_that) {
case _ChildProfile() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime dateOfBirth,  double ageMonths)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChildProfile() when $default != null:
return $default(_that.dateOfBirth,_that.ageMonths);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime dateOfBirth,  double ageMonths)  $default,) {final _that = this;
switch (_that) {
case _ChildProfile():
return $default(_that.dateOfBirth,_that.ageMonths);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime dateOfBirth,  double ageMonths)?  $default,) {final _that = this;
switch (_that) {
case _ChildProfile() when $default != null:
return $default(_that.dateOfBirth,_that.ageMonths);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChildProfile implements ChildProfile {
  const _ChildProfile({required this.dateOfBirth, required this.ageMonths});
  factory _ChildProfile.fromJson(Map<String, dynamic> json) => _$ChildProfileFromJson(json);

@override final  DateTime dateOfBirth;
@override final  double ageMonths;

/// Create a copy of ChildProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChildProfileCopyWith<_ChildProfile> get copyWith => __$ChildProfileCopyWithImpl<_ChildProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChildProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChildProfile&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.ageMonths, ageMonths) || other.ageMonths == ageMonths));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dateOfBirth,ageMonths);

@override
String toString() {
  return 'ChildProfile(dateOfBirth: $dateOfBirth, ageMonths: $ageMonths)';
}


}

/// @nodoc
abstract mixin class _$ChildProfileCopyWith<$Res> implements $ChildProfileCopyWith<$Res> {
  factory _$ChildProfileCopyWith(_ChildProfile value, $Res Function(_ChildProfile) _then) = __$ChildProfileCopyWithImpl;
@override @useResult
$Res call({
 DateTime dateOfBirth, double ageMonths
});




}
/// @nodoc
class __$ChildProfileCopyWithImpl<$Res>
    implements _$ChildProfileCopyWith<$Res> {
  __$ChildProfileCopyWithImpl(this._self, this._then);

  final _ChildProfile _self;
  final $Res Function(_ChildProfile) _then;

/// Create a copy of ChildProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dateOfBirth = null,Object? ageMonths = null,}) {
  return _then(_ChildProfile(
dateOfBirth: null == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime,ageMonths: null == ageMonths ? _self.ageMonths : ageMonths // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
