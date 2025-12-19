// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'balloon_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BalloonData {

 int get id; bool get isBlue; double get x; double get y; DateTime get spawnTime;
/// Create a copy of BalloonData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BalloonDataCopyWith<BalloonData> get copyWith => _$BalloonDataCopyWithImpl<BalloonData>(this as BalloonData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BalloonData&&(identical(other.id, id) || other.id == id)&&(identical(other.isBlue, isBlue) || other.isBlue == isBlue)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.spawnTime, spawnTime) || other.spawnTime == spawnTime));
}


@override
int get hashCode => Object.hash(runtimeType,id,isBlue,x,y,spawnTime);

@override
String toString() {
  return 'BalloonData(id: $id, isBlue: $isBlue, x: $x, y: $y, spawnTime: $spawnTime)';
}


}

/// @nodoc
abstract mixin class $BalloonDataCopyWith<$Res>  {
  factory $BalloonDataCopyWith(BalloonData value, $Res Function(BalloonData) _then) = _$BalloonDataCopyWithImpl;
@useResult
$Res call({
 int id, bool isBlue, double x, double y, DateTime spawnTime
});




}
/// @nodoc
class _$BalloonDataCopyWithImpl<$Res>
    implements $BalloonDataCopyWith<$Res> {
  _$BalloonDataCopyWithImpl(this._self, this._then);

  final BalloonData _self;
  final $Res Function(BalloonData) _then;

/// Create a copy of BalloonData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? isBlue = null,Object? x = null,Object? y = null,Object? spawnTime = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,isBlue: null == isBlue ? _self.isBlue : isBlue // ignore: cast_nullable_to_non_nullable
as bool,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,spawnTime: null == spawnTime ? _self.spawnTime : spawnTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [BalloonData].
extension BalloonDataPatterns on BalloonData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BalloonData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BalloonData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BalloonData value)  $default,){
final _that = this;
switch (_that) {
case _BalloonData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BalloonData value)?  $default,){
final _that = this;
switch (_that) {
case _BalloonData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  bool isBlue,  double x,  double y,  DateTime spawnTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BalloonData() when $default != null:
return $default(_that.id,_that.isBlue,_that.x,_that.y,_that.spawnTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  bool isBlue,  double x,  double y,  DateTime spawnTime)  $default,) {final _that = this;
switch (_that) {
case _BalloonData():
return $default(_that.id,_that.isBlue,_that.x,_that.y,_that.spawnTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  bool isBlue,  double x,  double y,  DateTime spawnTime)?  $default,) {final _that = this;
switch (_that) {
case _BalloonData() when $default != null:
return $default(_that.id,_that.isBlue,_that.x,_that.y,_that.spawnTime);case _:
  return null;

}
}

}

/// @nodoc


class _BalloonData implements BalloonData {
  const _BalloonData({required this.id, required this.isBlue, required this.x, required this.y, required this.spawnTime});
  

@override final  int id;
@override final  bool isBlue;
@override final  double x;
@override final  double y;
@override final  DateTime spawnTime;

/// Create a copy of BalloonData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BalloonDataCopyWith<_BalloonData> get copyWith => __$BalloonDataCopyWithImpl<_BalloonData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BalloonData&&(identical(other.id, id) || other.id == id)&&(identical(other.isBlue, isBlue) || other.isBlue == isBlue)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.spawnTime, spawnTime) || other.spawnTime == spawnTime));
}


@override
int get hashCode => Object.hash(runtimeType,id,isBlue,x,y,spawnTime);

@override
String toString() {
  return 'BalloonData(id: $id, isBlue: $isBlue, x: $x, y: $y, spawnTime: $spawnTime)';
}


}

/// @nodoc
abstract mixin class _$BalloonDataCopyWith<$Res> implements $BalloonDataCopyWith<$Res> {
  factory _$BalloonDataCopyWith(_BalloonData value, $Res Function(_BalloonData) _then) = __$BalloonDataCopyWithImpl;
@override @useResult
$Res call({
 int id, bool isBlue, double x, double y, DateTime spawnTime
});




}
/// @nodoc
class __$BalloonDataCopyWithImpl<$Res>
    implements _$BalloonDataCopyWith<$Res> {
  __$BalloonDataCopyWithImpl(this._self, this._then);

  final _BalloonData _self;
  final $Res Function(_BalloonData) _then;

/// Create a copy of BalloonData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? isBlue = null,Object? x = null,Object? y = null,Object? spawnTime = null,}) {
  return _then(_BalloonData(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,isBlue: null == isBlue ? _self.isBlue : isBlue // ignore: cast_nullable_to_non_nullable
as bool,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,spawnTime: null == spawnTime ? _self.spawnTime : spawnTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
