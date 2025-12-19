// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attention_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AttentionResult {

 double get durationSeconds; int get totalMoves; int get errors; CompletionStatus get completionStatus;
/// Create a copy of AttentionResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttentionResultCopyWith<AttentionResult> get copyWith => _$AttentionResultCopyWithImpl<AttentionResult>(this as AttentionResult, _$identity);

  /// Serializes this AttentionResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttentionResult&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.totalMoves, totalMoves) || other.totalMoves == totalMoves)&&(identical(other.errors, errors) || other.errors == errors)&&(identical(other.completionStatus, completionStatus) || other.completionStatus == completionStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,durationSeconds,totalMoves,errors,completionStatus);

@override
String toString() {
  return 'AttentionResult(durationSeconds: $durationSeconds, totalMoves: $totalMoves, errors: $errors, completionStatus: $completionStatus)';
}


}

/// @nodoc
abstract mixin class $AttentionResultCopyWith<$Res>  {
  factory $AttentionResultCopyWith(AttentionResult value, $Res Function(AttentionResult) _then) = _$AttentionResultCopyWithImpl;
@useResult
$Res call({
 double durationSeconds, int totalMoves, int errors, CompletionStatus completionStatus
});




}
/// @nodoc
class _$AttentionResultCopyWithImpl<$Res>
    implements $AttentionResultCopyWith<$Res> {
  _$AttentionResultCopyWithImpl(this._self, this._then);

  final AttentionResult _self;
  final $Res Function(AttentionResult) _then;

/// Create a copy of AttentionResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationSeconds = null,Object? totalMoves = null,Object? errors = null,Object? completionStatus = null,}) {
  return _then(_self.copyWith(
durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as double,totalMoves: null == totalMoves ? _self.totalMoves : totalMoves // ignore: cast_nullable_to_non_nullable
as int,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as int,completionStatus: null == completionStatus ? _self.completionStatus : completionStatus // ignore: cast_nullable_to_non_nullable
as CompletionStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [AttentionResult].
extension AttentionResultPatterns on AttentionResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttentionResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttentionResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttentionResult value)  $default,){
final _that = this;
switch (_that) {
case _AttentionResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttentionResult value)?  $default,){
final _that = this;
switch (_that) {
case _AttentionResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double durationSeconds,  int totalMoves,  int errors,  CompletionStatus completionStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttentionResult() when $default != null:
return $default(_that.durationSeconds,_that.totalMoves,_that.errors,_that.completionStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double durationSeconds,  int totalMoves,  int errors,  CompletionStatus completionStatus)  $default,) {final _that = this;
switch (_that) {
case _AttentionResult():
return $default(_that.durationSeconds,_that.totalMoves,_that.errors,_that.completionStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double durationSeconds,  int totalMoves,  int errors,  CompletionStatus completionStatus)?  $default,) {final _that = this;
switch (_that) {
case _AttentionResult() when $default != null:
return $default(_that.durationSeconds,_that.totalMoves,_that.errors,_that.completionStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttentionResult implements AttentionResult {
  const _AttentionResult({required this.durationSeconds, required this.totalMoves, required this.errors, required this.completionStatus});
  factory _AttentionResult.fromJson(Map<String, dynamic> json) => _$AttentionResultFromJson(json);

@override final  double durationSeconds;
@override final  int totalMoves;
@override final  int errors;
@override final  CompletionStatus completionStatus;

/// Create a copy of AttentionResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttentionResultCopyWith<_AttentionResult> get copyWith => __$AttentionResultCopyWithImpl<_AttentionResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttentionResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttentionResult&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.totalMoves, totalMoves) || other.totalMoves == totalMoves)&&(identical(other.errors, errors) || other.errors == errors)&&(identical(other.completionStatus, completionStatus) || other.completionStatus == completionStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,durationSeconds,totalMoves,errors,completionStatus);

@override
String toString() {
  return 'AttentionResult(durationSeconds: $durationSeconds, totalMoves: $totalMoves, errors: $errors, completionStatus: $completionStatus)';
}


}

/// @nodoc
abstract mixin class _$AttentionResultCopyWith<$Res> implements $AttentionResultCopyWith<$Res> {
  factory _$AttentionResultCopyWith(_AttentionResult value, $Res Function(_AttentionResult) _then) = __$AttentionResultCopyWithImpl;
@override @useResult
$Res call({
 double durationSeconds, int totalMoves, int errors, CompletionStatus completionStatus
});




}
/// @nodoc
class __$AttentionResultCopyWithImpl<$Res>
    implements _$AttentionResultCopyWith<$Res> {
  __$AttentionResultCopyWithImpl(this._self, this._then);

  final _AttentionResult _self;
  final $Res Function(_AttentionResult) _then;

/// Create a copy of AttentionResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? durationSeconds = null,Object? totalMoves = null,Object? errors = null,Object? completionStatus = null,}) {
  return _then(_AttentionResult(
durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as double,totalMoves: null == totalMoves ? _self.totalMoves : totalMoves // ignore: cast_nullable_to_non_nullable
as int,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as int,completionStatus: null == completionStatus ? _self.completionStatus : completionStatus // ignore: cast_nullable_to_non_nullable
as CompletionStatus,
  ));
}


}

// dart format on
