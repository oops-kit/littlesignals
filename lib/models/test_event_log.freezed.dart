// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_event_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TestEventLog {

 TestEventType get type; DateTime get timestamp;/// 이벤트 상세 설명
 String get description;/// 추가 데이터 (반응 시간 등)
 int? get value;
/// Create a copy of TestEventLog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestEventLogCopyWith<TestEventLog> get copyWith => _$TestEventLogCopyWithImpl<TestEventLog>(this as TestEventLog, _$identity);

  /// Serializes this TestEventLog to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestEventLog&&(identical(other.type, type) || other.type == type)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.description, description) || other.description == description)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,timestamp,description,value);

@override
String toString() {
  return 'TestEventLog(type: $type, timestamp: $timestamp, description: $description, value: $value)';
}


}

/// @nodoc
abstract mixin class $TestEventLogCopyWith<$Res>  {
  factory $TestEventLogCopyWith(TestEventLog value, $Res Function(TestEventLog) _then) = _$TestEventLogCopyWithImpl;
@useResult
$Res call({
 TestEventType type, DateTime timestamp, String description, int? value
});




}
/// @nodoc
class _$TestEventLogCopyWithImpl<$Res>
    implements $TestEventLogCopyWith<$Res> {
  _$TestEventLogCopyWithImpl(this._self, this._then);

  final TestEventLog _self;
  final $Res Function(TestEventLog) _then;

/// Create a copy of TestEventLog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? timestamp = null,Object? description = null,Object? value = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TestEventType,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [TestEventLog].
extension TestEventLogPatterns on TestEventLog {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TestEventLog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestEventLog() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TestEventLog value)  $default,){
final _that = this;
switch (_that) {
case _TestEventLog():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TestEventLog value)?  $default,){
final _that = this;
switch (_that) {
case _TestEventLog() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TestEventType type,  DateTime timestamp,  String description,  int? value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestEventLog() when $default != null:
return $default(_that.type,_that.timestamp,_that.description,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TestEventType type,  DateTime timestamp,  String description,  int? value)  $default,) {final _that = this;
switch (_that) {
case _TestEventLog():
return $default(_that.type,_that.timestamp,_that.description,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TestEventType type,  DateTime timestamp,  String description,  int? value)?  $default,) {final _that = this;
switch (_that) {
case _TestEventLog() when $default != null:
return $default(_that.type,_that.timestamp,_that.description,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TestEventLog implements TestEventLog {
  const _TestEventLog({required this.type, required this.timestamp, required this.description, this.value});
  factory _TestEventLog.fromJson(Map<String, dynamic> json) => _$TestEventLogFromJson(json);

@override final  TestEventType type;
@override final  DateTime timestamp;
/// 이벤트 상세 설명
@override final  String description;
/// 추가 데이터 (반응 시간 등)
@override final  int? value;

/// Create a copy of TestEventLog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestEventLogCopyWith<_TestEventLog> get copyWith => __$TestEventLogCopyWithImpl<_TestEventLog>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TestEventLogToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestEventLog&&(identical(other.type, type) || other.type == type)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.description, description) || other.description == description)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,timestamp,description,value);

@override
String toString() {
  return 'TestEventLog(type: $type, timestamp: $timestamp, description: $description, value: $value)';
}


}

/// @nodoc
abstract mixin class _$TestEventLogCopyWith<$Res> implements $TestEventLogCopyWith<$Res> {
  factory _$TestEventLogCopyWith(_TestEventLog value, $Res Function(_TestEventLog) _then) = __$TestEventLogCopyWithImpl;
@override @useResult
$Res call({
 TestEventType type, DateTime timestamp, String description, int? value
});




}
/// @nodoc
class __$TestEventLogCopyWithImpl<$Res>
    implements _$TestEventLogCopyWith<$Res> {
  __$TestEventLogCopyWithImpl(this._self, this._then);

  final _TestEventLog _self;
  final $Res Function(_TestEventLog) _then;

/// Create a copy of TestEventLog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? timestamp = null,Object? description = null,Object? value = freezed,}) {
  return _then(_TestEventLog(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TestEventType,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
