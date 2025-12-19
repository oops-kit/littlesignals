// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'impulsivity_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ImpulsivityResult {

 double get reactionTimeAverage; int get commissionErrors; int get omissionErrors; int get totalStimuli; String get completionStatus;/// 예측 반응 횟수 (풍선이 뜨기 전에 화면을 누른 횟수)
 int get anticipatoryResponses;/// 개별 반응 시간 목록 (분석용)
 List<int> get reactionTimes;/// 테스트 중 발생한 이벤트 로그
 List<TestEventLog> get eventLogs;
/// Create a copy of ImpulsivityResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImpulsivityResultCopyWith<ImpulsivityResult> get copyWith => _$ImpulsivityResultCopyWithImpl<ImpulsivityResult>(this as ImpulsivityResult, _$identity);

  /// Serializes this ImpulsivityResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImpulsivityResult&&(identical(other.reactionTimeAverage, reactionTimeAverage) || other.reactionTimeAverage == reactionTimeAverage)&&(identical(other.commissionErrors, commissionErrors) || other.commissionErrors == commissionErrors)&&(identical(other.omissionErrors, omissionErrors) || other.omissionErrors == omissionErrors)&&(identical(other.totalStimuli, totalStimuli) || other.totalStimuli == totalStimuli)&&(identical(other.completionStatus, completionStatus) || other.completionStatus == completionStatus)&&(identical(other.anticipatoryResponses, anticipatoryResponses) || other.anticipatoryResponses == anticipatoryResponses)&&const DeepCollectionEquality().equals(other.reactionTimes, reactionTimes)&&const DeepCollectionEquality().equals(other.eventLogs, eventLogs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reactionTimeAverage,commissionErrors,omissionErrors,totalStimuli,completionStatus,anticipatoryResponses,const DeepCollectionEquality().hash(reactionTimes),const DeepCollectionEquality().hash(eventLogs));

@override
String toString() {
  return 'ImpulsivityResult(reactionTimeAverage: $reactionTimeAverage, commissionErrors: $commissionErrors, omissionErrors: $omissionErrors, totalStimuli: $totalStimuli, completionStatus: $completionStatus, anticipatoryResponses: $anticipatoryResponses, reactionTimes: $reactionTimes, eventLogs: $eventLogs)';
}


}

/// @nodoc
abstract mixin class $ImpulsivityResultCopyWith<$Res>  {
  factory $ImpulsivityResultCopyWith(ImpulsivityResult value, $Res Function(ImpulsivityResult) _then) = _$ImpulsivityResultCopyWithImpl;
@useResult
$Res call({
 double reactionTimeAverage, int commissionErrors, int omissionErrors, int totalStimuli, String completionStatus, int anticipatoryResponses, List<int> reactionTimes, List<TestEventLog> eventLogs
});




}
/// @nodoc
class _$ImpulsivityResultCopyWithImpl<$Res>
    implements $ImpulsivityResultCopyWith<$Res> {
  _$ImpulsivityResultCopyWithImpl(this._self, this._then);

  final ImpulsivityResult _self;
  final $Res Function(ImpulsivityResult) _then;

/// Create a copy of ImpulsivityResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reactionTimeAverage = null,Object? commissionErrors = null,Object? omissionErrors = null,Object? totalStimuli = null,Object? completionStatus = null,Object? anticipatoryResponses = null,Object? reactionTimes = null,Object? eventLogs = null,}) {
  return _then(_self.copyWith(
reactionTimeAverage: null == reactionTimeAverage ? _self.reactionTimeAverage : reactionTimeAverage // ignore: cast_nullable_to_non_nullable
as double,commissionErrors: null == commissionErrors ? _self.commissionErrors : commissionErrors // ignore: cast_nullable_to_non_nullable
as int,omissionErrors: null == omissionErrors ? _self.omissionErrors : omissionErrors // ignore: cast_nullable_to_non_nullable
as int,totalStimuli: null == totalStimuli ? _self.totalStimuli : totalStimuli // ignore: cast_nullable_to_non_nullable
as int,completionStatus: null == completionStatus ? _self.completionStatus : completionStatus // ignore: cast_nullable_to_non_nullable
as String,anticipatoryResponses: null == anticipatoryResponses ? _self.anticipatoryResponses : anticipatoryResponses // ignore: cast_nullable_to_non_nullable
as int,reactionTimes: null == reactionTimes ? _self.reactionTimes : reactionTimes // ignore: cast_nullable_to_non_nullable
as List<int>,eventLogs: null == eventLogs ? _self.eventLogs : eventLogs // ignore: cast_nullable_to_non_nullable
as List<TestEventLog>,
  ));
}

}


/// Adds pattern-matching-related methods to [ImpulsivityResult].
extension ImpulsivityResultPatterns on ImpulsivityResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImpulsivityResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImpulsivityResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImpulsivityResult value)  $default,){
final _that = this;
switch (_that) {
case _ImpulsivityResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImpulsivityResult value)?  $default,){
final _that = this;
switch (_that) {
case _ImpulsivityResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double reactionTimeAverage,  int commissionErrors,  int omissionErrors,  int totalStimuli,  String completionStatus,  int anticipatoryResponses,  List<int> reactionTimes,  List<TestEventLog> eventLogs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImpulsivityResult() when $default != null:
return $default(_that.reactionTimeAverage,_that.commissionErrors,_that.omissionErrors,_that.totalStimuli,_that.completionStatus,_that.anticipatoryResponses,_that.reactionTimes,_that.eventLogs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double reactionTimeAverage,  int commissionErrors,  int omissionErrors,  int totalStimuli,  String completionStatus,  int anticipatoryResponses,  List<int> reactionTimes,  List<TestEventLog> eventLogs)  $default,) {final _that = this;
switch (_that) {
case _ImpulsivityResult():
return $default(_that.reactionTimeAverage,_that.commissionErrors,_that.omissionErrors,_that.totalStimuli,_that.completionStatus,_that.anticipatoryResponses,_that.reactionTimes,_that.eventLogs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double reactionTimeAverage,  int commissionErrors,  int omissionErrors,  int totalStimuli,  String completionStatus,  int anticipatoryResponses,  List<int> reactionTimes,  List<TestEventLog> eventLogs)?  $default,) {final _that = this;
switch (_that) {
case _ImpulsivityResult() when $default != null:
return $default(_that.reactionTimeAverage,_that.commissionErrors,_that.omissionErrors,_that.totalStimuli,_that.completionStatus,_that.anticipatoryResponses,_that.reactionTimes,_that.eventLogs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ImpulsivityResult extends ImpulsivityResult {
  const _ImpulsivityResult({required this.reactionTimeAverage, required this.commissionErrors, required this.omissionErrors, required this.totalStimuli, required this.completionStatus, this.anticipatoryResponses = 0, final  List<int> reactionTimes = const [], final  List<TestEventLog> eventLogs = const []}): _reactionTimes = reactionTimes,_eventLogs = eventLogs,super._();
  factory _ImpulsivityResult.fromJson(Map<String, dynamic> json) => _$ImpulsivityResultFromJson(json);

@override final  double reactionTimeAverage;
@override final  int commissionErrors;
@override final  int omissionErrors;
@override final  int totalStimuli;
@override final  String completionStatus;
/// 예측 반응 횟수 (풍선이 뜨기 전에 화면을 누른 횟수)
@override@JsonKey() final  int anticipatoryResponses;
/// 개별 반응 시간 목록 (분석용)
 final  List<int> _reactionTimes;
/// 개별 반응 시간 목록 (분석용)
@override@JsonKey() List<int> get reactionTimes {
  if (_reactionTimes is EqualUnmodifiableListView) return _reactionTimes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reactionTimes);
}

/// 테스트 중 발생한 이벤트 로그
 final  List<TestEventLog> _eventLogs;
/// 테스트 중 발생한 이벤트 로그
@override@JsonKey() List<TestEventLog> get eventLogs {
  if (_eventLogs is EqualUnmodifiableListView) return _eventLogs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eventLogs);
}


/// Create a copy of ImpulsivityResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImpulsivityResultCopyWith<_ImpulsivityResult> get copyWith => __$ImpulsivityResultCopyWithImpl<_ImpulsivityResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImpulsivityResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImpulsivityResult&&(identical(other.reactionTimeAverage, reactionTimeAverage) || other.reactionTimeAverage == reactionTimeAverage)&&(identical(other.commissionErrors, commissionErrors) || other.commissionErrors == commissionErrors)&&(identical(other.omissionErrors, omissionErrors) || other.omissionErrors == omissionErrors)&&(identical(other.totalStimuli, totalStimuli) || other.totalStimuli == totalStimuli)&&(identical(other.completionStatus, completionStatus) || other.completionStatus == completionStatus)&&(identical(other.anticipatoryResponses, anticipatoryResponses) || other.anticipatoryResponses == anticipatoryResponses)&&const DeepCollectionEquality().equals(other._reactionTimes, _reactionTimes)&&const DeepCollectionEquality().equals(other._eventLogs, _eventLogs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reactionTimeAverage,commissionErrors,omissionErrors,totalStimuli,completionStatus,anticipatoryResponses,const DeepCollectionEquality().hash(_reactionTimes),const DeepCollectionEquality().hash(_eventLogs));

@override
String toString() {
  return 'ImpulsivityResult(reactionTimeAverage: $reactionTimeAverage, commissionErrors: $commissionErrors, omissionErrors: $omissionErrors, totalStimuli: $totalStimuli, completionStatus: $completionStatus, anticipatoryResponses: $anticipatoryResponses, reactionTimes: $reactionTimes, eventLogs: $eventLogs)';
}


}

/// @nodoc
abstract mixin class _$ImpulsivityResultCopyWith<$Res> implements $ImpulsivityResultCopyWith<$Res> {
  factory _$ImpulsivityResultCopyWith(_ImpulsivityResult value, $Res Function(_ImpulsivityResult) _then) = __$ImpulsivityResultCopyWithImpl;
@override @useResult
$Res call({
 double reactionTimeAverage, int commissionErrors, int omissionErrors, int totalStimuli, String completionStatus, int anticipatoryResponses, List<int> reactionTimes, List<TestEventLog> eventLogs
});




}
/// @nodoc
class __$ImpulsivityResultCopyWithImpl<$Res>
    implements _$ImpulsivityResultCopyWith<$Res> {
  __$ImpulsivityResultCopyWithImpl(this._self, this._then);

  final _ImpulsivityResult _self;
  final $Res Function(_ImpulsivityResult) _then;

/// Create a copy of ImpulsivityResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reactionTimeAverage = null,Object? commissionErrors = null,Object? omissionErrors = null,Object? totalStimuli = null,Object? completionStatus = null,Object? anticipatoryResponses = null,Object? reactionTimes = null,Object? eventLogs = null,}) {
  return _then(_ImpulsivityResult(
reactionTimeAverage: null == reactionTimeAverage ? _self.reactionTimeAverage : reactionTimeAverage // ignore: cast_nullable_to_non_nullable
as double,commissionErrors: null == commissionErrors ? _self.commissionErrors : commissionErrors // ignore: cast_nullable_to_non_nullable
as int,omissionErrors: null == omissionErrors ? _self.omissionErrors : omissionErrors // ignore: cast_nullable_to_non_nullable
as int,totalStimuli: null == totalStimuli ? _self.totalStimuli : totalStimuli // ignore: cast_nullable_to_non_nullable
as int,completionStatus: null == completionStatus ? _self.completionStatus : completionStatus // ignore: cast_nullable_to_non_nullable
as String,anticipatoryResponses: null == anticipatoryResponses ? _self.anticipatoryResponses : anticipatoryResponses // ignore: cast_nullable_to_non_nullable
as int,reactionTimes: null == reactionTimes ? _self._reactionTimes : reactionTimes // ignore: cast_nullable_to_non_nullable
as List<int>,eventLogs: null == eventLogs ? _self._eventLogs : eventLogs // ignore: cast_nullable_to_non_nullable
as List<TestEventLog>,
  ));
}


}

// dart format on
