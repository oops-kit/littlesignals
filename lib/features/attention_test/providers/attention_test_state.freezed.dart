// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attention_test_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AttentionTestState {

 int get level; List<CardData> get cards; List<int> get flippedCardIds; bool get isProcessing; DateTime? get startTime; int get moves; int get errors; int? get hintCardId; bool get isCompleted;
/// Create a copy of AttentionTestState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttentionTestStateCopyWith<AttentionTestState> get copyWith => _$AttentionTestStateCopyWithImpl<AttentionTestState>(this as AttentionTestState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttentionTestState&&(identical(other.level, level) || other.level == level)&&const DeepCollectionEquality().equals(other.cards, cards)&&const DeepCollectionEquality().equals(other.flippedCardIds, flippedCardIds)&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.moves, moves) || other.moves == moves)&&(identical(other.errors, errors) || other.errors == errors)&&(identical(other.hintCardId, hintCardId) || other.hintCardId == hintCardId)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}


@override
int get hashCode => Object.hash(runtimeType,level,const DeepCollectionEquality().hash(cards),const DeepCollectionEquality().hash(flippedCardIds),isProcessing,startTime,moves,errors,hintCardId,isCompleted);

@override
String toString() {
  return 'AttentionTestState(level: $level, cards: $cards, flippedCardIds: $flippedCardIds, isProcessing: $isProcessing, startTime: $startTime, moves: $moves, errors: $errors, hintCardId: $hintCardId, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class $AttentionTestStateCopyWith<$Res>  {
  factory $AttentionTestStateCopyWith(AttentionTestState value, $Res Function(AttentionTestState) _then) = _$AttentionTestStateCopyWithImpl;
@useResult
$Res call({
 int level, List<CardData> cards, List<int> flippedCardIds, bool isProcessing, DateTime? startTime, int moves, int errors, int? hintCardId, bool isCompleted
});




}
/// @nodoc
class _$AttentionTestStateCopyWithImpl<$Res>
    implements $AttentionTestStateCopyWith<$Res> {
  _$AttentionTestStateCopyWithImpl(this._self, this._then);

  final AttentionTestState _self;
  final $Res Function(AttentionTestState) _then;

/// Create a copy of AttentionTestState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? level = null,Object? cards = null,Object? flippedCardIds = null,Object? isProcessing = null,Object? startTime = freezed,Object? moves = null,Object? errors = null,Object? hintCardId = freezed,Object? isCompleted = null,}) {
  return _then(_self.copyWith(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,cards: null == cards ? _self.cards : cards // ignore: cast_nullable_to_non_nullable
as List<CardData>,flippedCardIds: null == flippedCardIds ? _self.flippedCardIds : flippedCardIds // ignore: cast_nullable_to_non_nullable
as List<int>,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,moves: null == moves ? _self.moves : moves // ignore: cast_nullable_to_non_nullable
as int,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as int,hintCardId: freezed == hintCardId ? _self.hintCardId : hintCardId // ignore: cast_nullable_to_non_nullable
as int?,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AttentionTestState].
extension AttentionTestStatePatterns on AttentionTestState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttentionTestState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttentionTestState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttentionTestState value)  $default,){
final _that = this;
switch (_that) {
case _AttentionTestState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttentionTestState value)?  $default,){
final _that = this;
switch (_that) {
case _AttentionTestState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int level,  List<CardData> cards,  List<int> flippedCardIds,  bool isProcessing,  DateTime? startTime,  int moves,  int errors,  int? hintCardId,  bool isCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttentionTestState() when $default != null:
return $default(_that.level,_that.cards,_that.flippedCardIds,_that.isProcessing,_that.startTime,_that.moves,_that.errors,_that.hintCardId,_that.isCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int level,  List<CardData> cards,  List<int> flippedCardIds,  bool isProcessing,  DateTime? startTime,  int moves,  int errors,  int? hintCardId,  bool isCompleted)  $default,) {final _that = this;
switch (_that) {
case _AttentionTestState():
return $default(_that.level,_that.cards,_that.flippedCardIds,_that.isProcessing,_that.startTime,_that.moves,_that.errors,_that.hintCardId,_that.isCompleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int level,  List<CardData> cards,  List<int> flippedCardIds,  bool isProcessing,  DateTime? startTime,  int moves,  int errors,  int? hintCardId,  bool isCompleted)?  $default,) {final _that = this;
switch (_that) {
case _AttentionTestState() when $default != null:
return $default(_that.level,_that.cards,_that.flippedCardIds,_that.isProcessing,_that.startTime,_that.moves,_that.errors,_that.hintCardId,_that.isCompleted);case _:
  return null;

}
}

}

/// @nodoc


class _AttentionTestState implements AttentionTestState {
  const _AttentionTestState({this.level = 1, final  List<CardData> cards = const [], final  List<int> flippedCardIds = const [], this.isProcessing = false, this.startTime = null, this.moves = 0, this.errors = 0, this.hintCardId = null, this.isCompleted = false}): _cards = cards,_flippedCardIds = flippedCardIds;
  

@override@JsonKey() final  int level;
 final  List<CardData> _cards;
@override@JsonKey() List<CardData> get cards {
  if (_cards is EqualUnmodifiableListView) return _cards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cards);
}

 final  List<int> _flippedCardIds;
@override@JsonKey() List<int> get flippedCardIds {
  if (_flippedCardIds is EqualUnmodifiableListView) return _flippedCardIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_flippedCardIds);
}

@override@JsonKey() final  bool isProcessing;
@override@JsonKey() final  DateTime? startTime;
@override@JsonKey() final  int moves;
@override@JsonKey() final  int errors;
@override@JsonKey() final  int? hintCardId;
@override@JsonKey() final  bool isCompleted;

/// Create a copy of AttentionTestState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttentionTestStateCopyWith<_AttentionTestState> get copyWith => __$AttentionTestStateCopyWithImpl<_AttentionTestState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttentionTestState&&(identical(other.level, level) || other.level == level)&&const DeepCollectionEquality().equals(other._cards, _cards)&&const DeepCollectionEquality().equals(other._flippedCardIds, _flippedCardIds)&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.moves, moves) || other.moves == moves)&&(identical(other.errors, errors) || other.errors == errors)&&(identical(other.hintCardId, hintCardId) || other.hintCardId == hintCardId)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}


@override
int get hashCode => Object.hash(runtimeType,level,const DeepCollectionEquality().hash(_cards),const DeepCollectionEquality().hash(_flippedCardIds),isProcessing,startTime,moves,errors,hintCardId,isCompleted);

@override
String toString() {
  return 'AttentionTestState(level: $level, cards: $cards, flippedCardIds: $flippedCardIds, isProcessing: $isProcessing, startTime: $startTime, moves: $moves, errors: $errors, hintCardId: $hintCardId, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class _$AttentionTestStateCopyWith<$Res> implements $AttentionTestStateCopyWith<$Res> {
  factory _$AttentionTestStateCopyWith(_AttentionTestState value, $Res Function(_AttentionTestState) _then) = __$AttentionTestStateCopyWithImpl;
@override @useResult
$Res call({
 int level, List<CardData> cards, List<int> flippedCardIds, bool isProcessing, DateTime? startTime, int moves, int errors, int? hintCardId, bool isCompleted
});




}
/// @nodoc
class __$AttentionTestStateCopyWithImpl<$Res>
    implements _$AttentionTestStateCopyWith<$Res> {
  __$AttentionTestStateCopyWithImpl(this._self, this._then);

  final _AttentionTestState _self;
  final $Res Function(_AttentionTestState) _then;

/// Create a copy of AttentionTestState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? level = null,Object? cards = null,Object? flippedCardIds = null,Object? isProcessing = null,Object? startTime = freezed,Object? moves = null,Object? errors = null,Object? hintCardId = freezed,Object? isCompleted = null,}) {
  return _then(_AttentionTestState(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,cards: null == cards ? _self._cards : cards // ignore: cast_nullable_to_non_nullable
as List<CardData>,flippedCardIds: null == flippedCardIds ? _self._flippedCardIds : flippedCardIds // ignore: cast_nullable_to_non_nullable
as List<int>,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,moves: null == moves ? _self.moves : moves // ignore: cast_nullable_to_non_nullable
as int,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as int,hintCardId: freezed == hintCardId ? _self.hintCardId : hintCardId // ignore: cast_nullable_to_non_nullable
as int?,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
