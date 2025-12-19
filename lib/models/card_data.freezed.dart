// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CardData {

 int get id; IconData get icon; String get name; bool get isFlipped; bool get isMatched;
/// Create a copy of CardData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CardDataCopyWith<CardData> get copyWith => _$CardDataCopyWithImpl<CardData>(this as CardData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CardData&&(identical(other.id, id) || other.id == id)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.name, name) || other.name == name)&&(identical(other.isFlipped, isFlipped) || other.isFlipped == isFlipped)&&(identical(other.isMatched, isMatched) || other.isMatched == isMatched));
}


@override
int get hashCode => Object.hash(runtimeType,id,icon,name,isFlipped,isMatched);

@override
String toString() {
  return 'CardData(id: $id, icon: $icon, name: $name, isFlipped: $isFlipped, isMatched: $isMatched)';
}


}

/// @nodoc
abstract mixin class $CardDataCopyWith<$Res>  {
  factory $CardDataCopyWith(CardData value, $Res Function(CardData) _then) = _$CardDataCopyWithImpl;
@useResult
$Res call({
 int id, IconData icon, String name, bool isFlipped, bool isMatched
});




}
/// @nodoc
class _$CardDataCopyWithImpl<$Res>
    implements $CardDataCopyWith<$Res> {
  _$CardDataCopyWithImpl(this._self, this._then);

  final CardData _self;
  final $Res Function(CardData) _then;

/// Create a copy of CardData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? icon = null,Object? name = null,Object? isFlipped = null,Object? isMatched = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as IconData,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isFlipped: null == isFlipped ? _self.isFlipped : isFlipped // ignore: cast_nullable_to_non_nullable
as bool,isMatched: null == isMatched ? _self.isMatched : isMatched // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CardData].
extension CardDataPatterns on CardData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CardData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CardData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CardData value)  $default,){
final _that = this;
switch (_that) {
case _CardData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CardData value)?  $default,){
final _that = this;
switch (_that) {
case _CardData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  IconData icon,  String name,  bool isFlipped,  bool isMatched)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CardData() when $default != null:
return $default(_that.id,_that.icon,_that.name,_that.isFlipped,_that.isMatched);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  IconData icon,  String name,  bool isFlipped,  bool isMatched)  $default,) {final _that = this;
switch (_that) {
case _CardData():
return $default(_that.id,_that.icon,_that.name,_that.isFlipped,_that.isMatched);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  IconData icon,  String name,  bool isFlipped,  bool isMatched)?  $default,) {final _that = this;
switch (_that) {
case _CardData() when $default != null:
return $default(_that.id,_that.icon,_that.name,_that.isFlipped,_that.isMatched);case _:
  return null;

}
}

}

/// @nodoc


class _CardData implements CardData {
  const _CardData({required this.id, required this.icon, required this.name, this.isFlipped = false, this.isMatched = false});
  

@override final  int id;
@override final  IconData icon;
@override final  String name;
@override@JsonKey() final  bool isFlipped;
@override@JsonKey() final  bool isMatched;

/// Create a copy of CardData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CardDataCopyWith<_CardData> get copyWith => __$CardDataCopyWithImpl<_CardData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CardData&&(identical(other.id, id) || other.id == id)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.name, name) || other.name == name)&&(identical(other.isFlipped, isFlipped) || other.isFlipped == isFlipped)&&(identical(other.isMatched, isMatched) || other.isMatched == isMatched));
}


@override
int get hashCode => Object.hash(runtimeType,id,icon,name,isFlipped,isMatched);

@override
String toString() {
  return 'CardData(id: $id, icon: $icon, name: $name, isFlipped: $isFlipped, isMatched: $isMatched)';
}


}

/// @nodoc
abstract mixin class _$CardDataCopyWith<$Res> implements $CardDataCopyWith<$Res> {
  factory _$CardDataCopyWith(_CardData value, $Res Function(_CardData) _then) = __$CardDataCopyWithImpl;
@override @useResult
$Res call({
 int id, IconData icon, String name, bool isFlipped, bool isMatched
});




}
/// @nodoc
class __$CardDataCopyWithImpl<$Res>
    implements _$CardDataCopyWith<$Res> {
  __$CardDataCopyWithImpl(this._self, this._then);

  final _CardData _self;
  final $Res Function(_CardData) _then;

/// Create a copy of CardData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? icon = null,Object? name = null,Object? isFlipped = null,Object? isMatched = null,}) {
  return _then(_CardData(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as IconData,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isFlipped: null == isFlipped ? _self.isFlipped : isFlipped // ignore: cast_nullable_to_non_nullable
as bool,isMatched: null == isMatched ? _self.isMatched : isMatched // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
