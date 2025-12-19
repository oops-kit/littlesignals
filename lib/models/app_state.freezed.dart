// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppState {

 ChildProfile? get profile; TestType? get activeTest; AttentionResult? get attentionResult; ImpulsivityResult? get impulsivityResult;
/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStateCopyWith<AppState> get copyWith => _$AppStateCopyWithImpl<AppState>(this as AppState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppState&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.activeTest, activeTest) || other.activeTest == activeTest)&&(identical(other.attentionResult, attentionResult) || other.attentionResult == attentionResult)&&(identical(other.impulsivityResult, impulsivityResult) || other.impulsivityResult == impulsivityResult));
}


@override
int get hashCode => Object.hash(runtimeType,profile,activeTest,attentionResult,impulsivityResult);

@override
String toString() {
  return 'AppState(profile: $profile, activeTest: $activeTest, attentionResult: $attentionResult, impulsivityResult: $impulsivityResult)';
}


}

/// @nodoc
abstract mixin class $AppStateCopyWith<$Res>  {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) _then) = _$AppStateCopyWithImpl;
@useResult
$Res call({
 ChildProfile? profile, TestType? activeTest, AttentionResult? attentionResult, ImpulsivityResult? impulsivityResult
});


$ChildProfileCopyWith<$Res>? get profile;$AttentionResultCopyWith<$Res>? get attentionResult;$ImpulsivityResultCopyWith<$Res>? get impulsivityResult;

}
/// @nodoc
class _$AppStateCopyWithImpl<$Res>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._self, this._then);

  final AppState _self;
  final $Res Function(AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profile = freezed,Object? activeTest = freezed,Object? attentionResult = freezed,Object? impulsivityResult = freezed,}) {
  return _then(_self.copyWith(
profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as ChildProfile?,activeTest: freezed == activeTest ? _self.activeTest : activeTest // ignore: cast_nullable_to_non_nullable
as TestType?,attentionResult: freezed == attentionResult ? _self.attentionResult : attentionResult // ignore: cast_nullable_to_non_nullable
as AttentionResult?,impulsivityResult: freezed == impulsivityResult ? _self.impulsivityResult : impulsivityResult // ignore: cast_nullable_to_non_nullable
as ImpulsivityResult?,
  ));
}
/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChildProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $ChildProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttentionResultCopyWith<$Res>? get attentionResult {
    if (_self.attentionResult == null) {
    return null;
  }

  return $AttentionResultCopyWith<$Res>(_self.attentionResult!, (value) {
    return _then(_self.copyWith(attentionResult: value));
  });
}/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImpulsivityResultCopyWith<$Res>? get impulsivityResult {
    if (_self.impulsivityResult == null) {
    return null;
  }

  return $ImpulsivityResultCopyWith<$Res>(_self.impulsivityResult!, (value) {
    return _then(_self.copyWith(impulsivityResult: value));
  });
}
}


/// Adds pattern-matching-related methods to [AppState].
extension AppStatePatterns on AppState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppState value)  $default,){
final _that = this;
switch (_that) {
case _AppState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppState value)?  $default,){
final _that = this;
switch (_that) {
case _AppState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ChildProfile? profile,  TestType? activeTest,  AttentionResult? attentionResult,  ImpulsivityResult? impulsivityResult)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that.profile,_that.activeTest,_that.attentionResult,_that.impulsivityResult);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ChildProfile? profile,  TestType? activeTest,  AttentionResult? attentionResult,  ImpulsivityResult? impulsivityResult)  $default,) {final _that = this;
switch (_that) {
case _AppState():
return $default(_that.profile,_that.activeTest,_that.attentionResult,_that.impulsivityResult);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ChildProfile? profile,  TestType? activeTest,  AttentionResult? attentionResult,  ImpulsivityResult? impulsivityResult)?  $default,) {final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that.profile,_that.activeTest,_that.attentionResult,_that.impulsivityResult);case _:
  return null;

}
}

}

/// @nodoc


class _AppState implements AppState {
  const _AppState({this.profile, this.activeTest, this.attentionResult, this.impulsivityResult});
  

@override final  ChildProfile? profile;
@override final  TestType? activeTest;
@override final  AttentionResult? attentionResult;
@override final  ImpulsivityResult? impulsivityResult;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppStateCopyWith<_AppState> get copyWith => __$AppStateCopyWithImpl<_AppState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppState&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.activeTest, activeTest) || other.activeTest == activeTest)&&(identical(other.attentionResult, attentionResult) || other.attentionResult == attentionResult)&&(identical(other.impulsivityResult, impulsivityResult) || other.impulsivityResult == impulsivityResult));
}


@override
int get hashCode => Object.hash(runtimeType,profile,activeTest,attentionResult,impulsivityResult);

@override
String toString() {
  return 'AppState(profile: $profile, activeTest: $activeTest, attentionResult: $attentionResult, impulsivityResult: $impulsivityResult)';
}


}

/// @nodoc
abstract mixin class _$AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$AppStateCopyWith(_AppState value, $Res Function(_AppState) _then) = __$AppStateCopyWithImpl;
@override @useResult
$Res call({
 ChildProfile? profile, TestType? activeTest, AttentionResult? attentionResult, ImpulsivityResult? impulsivityResult
});


@override $ChildProfileCopyWith<$Res>? get profile;@override $AttentionResultCopyWith<$Res>? get attentionResult;@override $ImpulsivityResultCopyWith<$Res>? get impulsivityResult;

}
/// @nodoc
class __$AppStateCopyWithImpl<$Res>
    implements _$AppStateCopyWith<$Res> {
  __$AppStateCopyWithImpl(this._self, this._then);

  final _AppState _self;
  final $Res Function(_AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profile = freezed,Object? activeTest = freezed,Object? attentionResult = freezed,Object? impulsivityResult = freezed,}) {
  return _then(_AppState(
profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as ChildProfile?,activeTest: freezed == activeTest ? _self.activeTest : activeTest // ignore: cast_nullable_to_non_nullable
as TestType?,attentionResult: freezed == attentionResult ? _self.attentionResult : attentionResult // ignore: cast_nullable_to_non_nullable
as AttentionResult?,impulsivityResult: freezed == impulsivityResult ? _self.impulsivityResult : impulsivityResult // ignore: cast_nullable_to_non_nullable
as ImpulsivityResult?,
  ));
}

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChildProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $ChildProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttentionResultCopyWith<$Res>? get attentionResult {
    if (_self.attentionResult == null) {
    return null;
  }

  return $AttentionResultCopyWith<$Res>(_self.attentionResult!, (value) {
    return _then(_self.copyWith(attentionResult: value));
  });
}/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImpulsivityResultCopyWith<$Res>? get impulsivityResult {
    if (_self.impulsivityResult == null) {
    return null;
  }

  return $ImpulsivityResultCopyWith<$Res>(_self.impulsivityResult!, (value) {
    return _then(_self.copyWith(impulsivityResult: value));
  });
}
}

// dart format on
