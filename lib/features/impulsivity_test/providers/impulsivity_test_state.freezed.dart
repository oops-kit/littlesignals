// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'impulsivity_test_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImpulsivityTestState {

 ImpulsivityGameState get gameState; BalloonData? get currentBalloon; int get stimuliCount; int get commissionErrors; int get omissionErrors; List<int> get reactionTimes; bool get isCompleted;
/// Create a copy of ImpulsivityTestState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImpulsivityTestStateCopyWith<ImpulsivityTestState> get copyWith => _$ImpulsivityTestStateCopyWithImpl<ImpulsivityTestState>(this as ImpulsivityTestState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImpulsivityTestState&&(identical(other.gameState, gameState) || other.gameState == gameState)&&(identical(other.currentBalloon, currentBalloon) || other.currentBalloon == currentBalloon)&&(identical(other.stimuliCount, stimuliCount) || other.stimuliCount == stimuliCount)&&(identical(other.commissionErrors, commissionErrors) || other.commissionErrors == commissionErrors)&&(identical(other.omissionErrors, omissionErrors) || other.omissionErrors == omissionErrors)&&const DeepCollectionEquality().equals(other.reactionTimes, reactionTimes)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}


@override
int get hashCode => Object.hash(runtimeType,gameState,currentBalloon,stimuliCount,commissionErrors,omissionErrors,const DeepCollectionEquality().hash(reactionTimes),isCompleted);

@override
String toString() {
  return 'ImpulsivityTestState(gameState: $gameState, currentBalloon: $currentBalloon, stimuliCount: $stimuliCount, commissionErrors: $commissionErrors, omissionErrors: $omissionErrors, reactionTimes: $reactionTimes, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class $ImpulsivityTestStateCopyWith<$Res>  {
  factory $ImpulsivityTestStateCopyWith(ImpulsivityTestState value, $Res Function(ImpulsivityTestState) _then) = _$ImpulsivityTestStateCopyWithImpl;
@useResult
$Res call({
 ImpulsivityGameState gameState, BalloonData? currentBalloon, int stimuliCount, int commissionErrors, int omissionErrors, List<int> reactionTimes, bool isCompleted
});


$BalloonDataCopyWith<$Res>? get currentBalloon;

}
/// @nodoc
class _$ImpulsivityTestStateCopyWithImpl<$Res>
    implements $ImpulsivityTestStateCopyWith<$Res> {
  _$ImpulsivityTestStateCopyWithImpl(this._self, this._then);

  final ImpulsivityTestState _self;
  final $Res Function(ImpulsivityTestState) _then;

/// Create a copy of ImpulsivityTestState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gameState = null,Object? currentBalloon = freezed,Object? stimuliCount = null,Object? commissionErrors = null,Object? omissionErrors = null,Object? reactionTimes = null,Object? isCompleted = null,}) {
  return _then(_self.copyWith(
gameState: null == gameState ? _self.gameState : gameState // ignore: cast_nullable_to_non_nullable
as ImpulsivityGameState,currentBalloon: freezed == currentBalloon ? _self.currentBalloon : currentBalloon // ignore: cast_nullable_to_non_nullable
as BalloonData?,stimuliCount: null == stimuliCount ? _self.stimuliCount : stimuliCount // ignore: cast_nullable_to_non_nullable
as int,commissionErrors: null == commissionErrors ? _self.commissionErrors : commissionErrors // ignore: cast_nullable_to_non_nullable
as int,omissionErrors: null == omissionErrors ? _self.omissionErrors : omissionErrors // ignore: cast_nullable_to_non_nullable
as int,reactionTimes: null == reactionTimes ? _self.reactionTimes : reactionTimes // ignore: cast_nullable_to_non_nullable
as List<int>,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ImpulsivityTestState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BalloonDataCopyWith<$Res>? get currentBalloon {
    if (_self.currentBalloon == null) {
    return null;
  }

  return $BalloonDataCopyWith<$Res>(_self.currentBalloon!, (value) {
    return _then(_self.copyWith(currentBalloon: value));
  });
}
}


/// Adds pattern-matching-related methods to [ImpulsivityTestState].
extension ImpulsivityTestStatePatterns on ImpulsivityTestState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImpulsivityTestState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImpulsivityTestState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImpulsivityTestState value)  $default,){
final _that = this;
switch (_that) {
case _ImpulsivityTestState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImpulsivityTestState value)?  $default,){
final _that = this;
switch (_that) {
case _ImpulsivityTestState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ImpulsivityGameState gameState,  BalloonData? currentBalloon,  int stimuliCount,  int commissionErrors,  int omissionErrors,  List<int> reactionTimes,  bool isCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImpulsivityTestState() when $default != null:
return $default(_that.gameState,_that.currentBalloon,_that.stimuliCount,_that.commissionErrors,_that.omissionErrors,_that.reactionTimes,_that.isCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ImpulsivityGameState gameState,  BalloonData? currentBalloon,  int stimuliCount,  int commissionErrors,  int omissionErrors,  List<int> reactionTimes,  bool isCompleted)  $default,) {final _that = this;
switch (_that) {
case _ImpulsivityTestState():
return $default(_that.gameState,_that.currentBalloon,_that.stimuliCount,_that.commissionErrors,_that.omissionErrors,_that.reactionTimes,_that.isCompleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ImpulsivityGameState gameState,  BalloonData? currentBalloon,  int stimuliCount,  int commissionErrors,  int omissionErrors,  List<int> reactionTimes,  bool isCompleted)?  $default,) {final _that = this;
switch (_that) {
case _ImpulsivityTestState() when $default != null:
return $default(_that.gameState,_that.currentBalloon,_that.stimuliCount,_that.commissionErrors,_that.omissionErrors,_that.reactionTimes,_that.isCompleted);case _:
  return null;

}
}

}

/// @nodoc


class _ImpulsivityTestState implements ImpulsivityTestState {
  const _ImpulsivityTestState({this.gameState = ImpulsivityGameState.intro, this.currentBalloon = null, this.stimuliCount = 0, this.commissionErrors = 0, this.omissionErrors = 0, final  List<int> reactionTimes = const [], this.isCompleted = false}): _reactionTimes = reactionTimes;
  

@override@JsonKey() final  ImpulsivityGameState gameState;
@override@JsonKey() final  BalloonData? currentBalloon;
@override@JsonKey() final  int stimuliCount;
@override@JsonKey() final  int commissionErrors;
@override@JsonKey() final  int omissionErrors;
 final  List<int> _reactionTimes;
@override@JsonKey() List<int> get reactionTimes {
  if (_reactionTimes is EqualUnmodifiableListView) return _reactionTimes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reactionTimes);
}

@override@JsonKey() final  bool isCompleted;

/// Create a copy of ImpulsivityTestState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImpulsivityTestStateCopyWith<_ImpulsivityTestState> get copyWith => __$ImpulsivityTestStateCopyWithImpl<_ImpulsivityTestState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImpulsivityTestState&&(identical(other.gameState, gameState) || other.gameState == gameState)&&(identical(other.currentBalloon, currentBalloon) || other.currentBalloon == currentBalloon)&&(identical(other.stimuliCount, stimuliCount) || other.stimuliCount == stimuliCount)&&(identical(other.commissionErrors, commissionErrors) || other.commissionErrors == commissionErrors)&&(identical(other.omissionErrors, omissionErrors) || other.omissionErrors == omissionErrors)&&const DeepCollectionEquality().equals(other._reactionTimes, _reactionTimes)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}


@override
int get hashCode => Object.hash(runtimeType,gameState,currentBalloon,stimuliCount,commissionErrors,omissionErrors,const DeepCollectionEquality().hash(_reactionTimes),isCompleted);

@override
String toString() {
  return 'ImpulsivityTestState(gameState: $gameState, currentBalloon: $currentBalloon, stimuliCount: $stimuliCount, commissionErrors: $commissionErrors, omissionErrors: $omissionErrors, reactionTimes: $reactionTimes, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class _$ImpulsivityTestStateCopyWith<$Res> implements $ImpulsivityTestStateCopyWith<$Res> {
  factory _$ImpulsivityTestStateCopyWith(_ImpulsivityTestState value, $Res Function(_ImpulsivityTestState) _then) = __$ImpulsivityTestStateCopyWithImpl;
@override @useResult
$Res call({
 ImpulsivityGameState gameState, BalloonData? currentBalloon, int stimuliCount, int commissionErrors, int omissionErrors, List<int> reactionTimes, bool isCompleted
});


@override $BalloonDataCopyWith<$Res>? get currentBalloon;

}
/// @nodoc
class __$ImpulsivityTestStateCopyWithImpl<$Res>
    implements _$ImpulsivityTestStateCopyWith<$Res> {
  __$ImpulsivityTestStateCopyWithImpl(this._self, this._then);

  final _ImpulsivityTestState _self;
  final $Res Function(_ImpulsivityTestState) _then;

/// Create a copy of ImpulsivityTestState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gameState = null,Object? currentBalloon = freezed,Object? stimuliCount = null,Object? commissionErrors = null,Object? omissionErrors = null,Object? reactionTimes = null,Object? isCompleted = null,}) {
  return _then(_ImpulsivityTestState(
gameState: null == gameState ? _self.gameState : gameState // ignore: cast_nullable_to_non_nullable
as ImpulsivityGameState,currentBalloon: freezed == currentBalloon ? _self.currentBalloon : currentBalloon // ignore: cast_nullable_to_non_nullable
as BalloonData?,stimuliCount: null == stimuliCount ? _self.stimuliCount : stimuliCount // ignore: cast_nullable_to_non_nullable
as int,commissionErrors: null == commissionErrors ? _self.commissionErrors : commissionErrors // ignore: cast_nullable_to_non_nullable
as int,omissionErrors: null == omissionErrors ? _self.omissionErrors : omissionErrors // ignore: cast_nullable_to_non_nullable
as int,reactionTimes: null == reactionTimes ? _self._reactionTimes : reactionTimes // ignore: cast_nullable_to_non_nullable
as List<int>,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ImpulsivityTestState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BalloonDataCopyWith<$Res>? get currentBalloon {
    if (_self.currentBalloon == null) {
    return null;
  }

  return $BalloonDataCopyWith<$Res>(_self.currentBalloon!, (value) {
    return _then(_self.copyWith(currentBalloon: value));
  });
}
}

// dart format on
