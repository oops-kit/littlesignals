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
mixin _$TapRecord {

 DateTime get timestamp; int get cardId;
/// Create a copy of TapRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TapRecordCopyWith<TapRecord> get copyWith => _$TapRecordCopyWithImpl<TapRecord>(this as TapRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TapRecord&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.cardId, cardId) || other.cardId == cardId));
}


@override
int get hashCode => Object.hash(runtimeType,timestamp,cardId);

@override
String toString() {
  return 'TapRecord(timestamp: $timestamp, cardId: $cardId)';
}


}

/// @nodoc
abstract mixin class $TapRecordCopyWith<$Res>  {
  factory $TapRecordCopyWith(TapRecord value, $Res Function(TapRecord) _then) = _$TapRecordCopyWithImpl;
@useResult
$Res call({
 DateTime timestamp, int cardId
});




}
/// @nodoc
class _$TapRecordCopyWithImpl<$Res>
    implements $TapRecordCopyWith<$Res> {
  _$TapRecordCopyWithImpl(this._self, this._then);

  final TapRecord _self;
  final $Res Function(TapRecord) _then;

/// Create a copy of TapRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timestamp = null,Object? cardId = null,}) {
  return _then(_self.copyWith(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TapRecord].
extension TapRecordPatterns on TapRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TapRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TapRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TapRecord value)  $default,){
final _that = this;
switch (_that) {
case _TapRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TapRecord value)?  $default,){
final _that = this;
switch (_that) {
case _TapRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime timestamp,  int cardId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TapRecord() when $default != null:
return $default(_that.timestamp,_that.cardId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime timestamp,  int cardId)  $default,) {final _that = this;
switch (_that) {
case _TapRecord():
return $default(_that.timestamp,_that.cardId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime timestamp,  int cardId)?  $default,) {final _that = this;
switch (_that) {
case _TapRecord() when $default != null:
return $default(_that.timestamp,_that.cardId);case _:
  return null;

}
}

}

/// @nodoc


class _TapRecord implements TapRecord {
  const _TapRecord({required this.timestamp, required this.cardId});
  

@override final  DateTime timestamp;
@override final  int cardId;

/// Create a copy of TapRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TapRecordCopyWith<_TapRecord> get copyWith => __$TapRecordCopyWithImpl<_TapRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TapRecord&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.cardId, cardId) || other.cardId == cardId));
}


@override
int get hashCode => Object.hash(runtimeType,timestamp,cardId);

@override
String toString() {
  return 'TapRecord(timestamp: $timestamp, cardId: $cardId)';
}


}

/// @nodoc
abstract mixin class _$TapRecordCopyWith<$Res> implements $TapRecordCopyWith<$Res> {
  factory _$TapRecordCopyWith(_TapRecord value, $Res Function(_TapRecord) _then) = __$TapRecordCopyWithImpl;
@override @useResult
$Res call({
 DateTime timestamp, int cardId
});




}
/// @nodoc
class __$TapRecordCopyWithImpl<$Res>
    implements _$TapRecordCopyWith<$Res> {
  __$TapRecordCopyWithImpl(this._self, this._then);

  final _TapRecord _self;
  final $Res Function(_TapRecord) _then;

/// Create a copy of TapRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timestamp = null,Object? cardId = null,}) {
  return _then(_TapRecord(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$AttentionTestState {

 AttentionGameState get gameState; int? get countdownValue; int get level; List<CardData> get cards; List<int> get flippedCardIds; bool get isProcessing; DateTime? get startTime; int get moves; int get errors; int? get hintCardId; bool get isCompleted;// === 관찰 지표 필드 ===
/// 무작위 터치 횟수 (짧은 시간 내 연속 터치, 패턴 없이 터치)
 int get randomTaps;/// 즉시 반복 오류 (방금 확인한 카드를 바로 다시 터치)
 int get immediateRepeatErrors;/// 모든 터치 기록 (지속성 분석용)
 List<TapRecord> get tapRecords;/// 마지막으로 뒤집은 카드 ID 목록 (최근 2개)
 List<int> get recentlyFlippedCardIds;/// 전반부 완료 시간 (첫 번째 레벨 또는 전반 50% 완료)
 DateTime? get firstHalfEndTime;/// 전반부 터치 횟수
 int get firstHalfTaps;/// 후반부 터치 횟수
 int get secondHalfTaps;/// 이벤트 로그 (테스트 중 발생한 모든 이벤트)
 List<TestEventLog> get eventLogs;
/// Create a copy of AttentionTestState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttentionTestStateCopyWith<AttentionTestState> get copyWith => _$AttentionTestStateCopyWithImpl<AttentionTestState>(this as AttentionTestState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttentionTestState&&(identical(other.gameState, gameState) || other.gameState == gameState)&&(identical(other.countdownValue, countdownValue) || other.countdownValue == countdownValue)&&(identical(other.level, level) || other.level == level)&&const DeepCollectionEquality().equals(other.cards, cards)&&const DeepCollectionEquality().equals(other.flippedCardIds, flippedCardIds)&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.moves, moves) || other.moves == moves)&&(identical(other.errors, errors) || other.errors == errors)&&(identical(other.hintCardId, hintCardId) || other.hintCardId == hintCardId)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.randomTaps, randomTaps) || other.randomTaps == randomTaps)&&(identical(other.immediateRepeatErrors, immediateRepeatErrors) || other.immediateRepeatErrors == immediateRepeatErrors)&&const DeepCollectionEquality().equals(other.tapRecords, tapRecords)&&const DeepCollectionEquality().equals(other.recentlyFlippedCardIds, recentlyFlippedCardIds)&&(identical(other.firstHalfEndTime, firstHalfEndTime) || other.firstHalfEndTime == firstHalfEndTime)&&(identical(other.firstHalfTaps, firstHalfTaps) || other.firstHalfTaps == firstHalfTaps)&&(identical(other.secondHalfTaps, secondHalfTaps) || other.secondHalfTaps == secondHalfTaps)&&const DeepCollectionEquality().equals(other.eventLogs, eventLogs));
}


@override
int get hashCode => Object.hashAll([runtimeType,gameState,countdownValue,level,const DeepCollectionEquality().hash(cards),const DeepCollectionEquality().hash(flippedCardIds),isProcessing,startTime,moves,errors,hintCardId,isCompleted,randomTaps,immediateRepeatErrors,const DeepCollectionEquality().hash(tapRecords),const DeepCollectionEquality().hash(recentlyFlippedCardIds),firstHalfEndTime,firstHalfTaps,secondHalfTaps,const DeepCollectionEquality().hash(eventLogs)]);

@override
String toString() {
  return 'AttentionTestState(gameState: $gameState, countdownValue: $countdownValue, level: $level, cards: $cards, flippedCardIds: $flippedCardIds, isProcessing: $isProcessing, startTime: $startTime, moves: $moves, errors: $errors, hintCardId: $hintCardId, isCompleted: $isCompleted, randomTaps: $randomTaps, immediateRepeatErrors: $immediateRepeatErrors, tapRecords: $tapRecords, recentlyFlippedCardIds: $recentlyFlippedCardIds, firstHalfEndTime: $firstHalfEndTime, firstHalfTaps: $firstHalfTaps, secondHalfTaps: $secondHalfTaps, eventLogs: $eventLogs)';
}


}

/// @nodoc
abstract mixin class $AttentionTestStateCopyWith<$Res>  {
  factory $AttentionTestStateCopyWith(AttentionTestState value, $Res Function(AttentionTestState) _then) = _$AttentionTestStateCopyWithImpl;
@useResult
$Res call({
 AttentionGameState gameState, int? countdownValue, int level, List<CardData> cards, List<int> flippedCardIds, bool isProcessing, DateTime? startTime, int moves, int errors, int? hintCardId, bool isCompleted, int randomTaps, int immediateRepeatErrors, List<TapRecord> tapRecords, List<int> recentlyFlippedCardIds, DateTime? firstHalfEndTime, int firstHalfTaps, int secondHalfTaps, List<TestEventLog> eventLogs
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
@pragma('vm:prefer-inline') @override $Res call({Object? gameState = null,Object? countdownValue = freezed,Object? level = null,Object? cards = null,Object? flippedCardIds = null,Object? isProcessing = null,Object? startTime = freezed,Object? moves = null,Object? errors = null,Object? hintCardId = freezed,Object? isCompleted = null,Object? randomTaps = null,Object? immediateRepeatErrors = null,Object? tapRecords = null,Object? recentlyFlippedCardIds = null,Object? firstHalfEndTime = freezed,Object? firstHalfTaps = null,Object? secondHalfTaps = null,Object? eventLogs = null,}) {
  return _then(_self.copyWith(
gameState: null == gameState ? _self.gameState : gameState // ignore: cast_nullable_to_non_nullable
as AttentionGameState,countdownValue: freezed == countdownValue ? _self.countdownValue : countdownValue // ignore: cast_nullable_to_non_nullable
as int?,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,cards: null == cards ? _self.cards : cards // ignore: cast_nullable_to_non_nullable
as List<CardData>,flippedCardIds: null == flippedCardIds ? _self.flippedCardIds : flippedCardIds // ignore: cast_nullable_to_non_nullable
as List<int>,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,moves: null == moves ? _self.moves : moves // ignore: cast_nullable_to_non_nullable
as int,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as int,hintCardId: freezed == hintCardId ? _self.hintCardId : hintCardId // ignore: cast_nullable_to_non_nullable
as int?,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,randomTaps: null == randomTaps ? _self.randomTaps : randomTaps // ignore: cast_nullable_to_non_nullable
as int,immediateRepeatErrors: null == immediateRepeatErrors ? _self.immediateRepeatErrors : immediateRepeatErrors // ignore: cast_nullable_to_non_nullable
as int,tapRecords: null == tapRecords ? _self.tapRecords : tapRecords // ignore: cast_nullable_to_non_nullable
as List<TapRecord>,recentlyFlippedCardIds: null == recentlyFlippedCardIds ? _self.recentlyFlippedCardIds : recentlyFlippedCardIds // ignore: cast_nullable_to_non_nullable
as List<int>,firstHalfEndTime: freezed == firstHalfEndTime ? _self.firstHalfEndTime : firstHalfEndTime // ignore: cast_nullable_to_non_nullable
as DateTime?,firstHalfTaps: null == firstHalfTaps ? _self.firstHalfTaps : firstHalfTaps // ignore: cast_nullable_to_non_nullable
as int,secondHalfTaps: null == secondHalfTaps ? _self.secondHalfTaps : secondHalfTaps // ignore: cast_nullable_to_non_nullable
as int,eventLogs: null == eventLogs ? _self.eventLogs : eventLogs // ignore: cast_nullable_to_non_nullable
as List<TestEventLog>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AttentionGameState gameState,  int? countdownValue,  int level,  List<CardData> cards,  List<int> flippedCardIds,  bool isProcessing,  DateTime? startTime,  int moves,  int errors,  int? hintCardId,  bool isCompleted,  int randomTaps,  int immediateRepeatErrors,  List<TapRecord> tapRecords,  List<int> recentlyFlippedCardIds,  DateTime? firstHalfEndTime,  int firstHalfTaps,  int secondHalfTaps,  List<TestEventLog> eventLogs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttentionTestState() when $default != null:
return $default(_that.gameState,_that.countdownValue,_that.level,_that.cards,_that.flippedCardIds,_that.isProcessing,_that.startTime,_that.moves,_that.errors,_that.hintCardId,_that.isCompleted,_that.randomTaps,_that.immediateRepeatErrors,_that.tapRecords,_that.recentlyFlippedCardIds,_that.firstHalfEndTime,_that.firstHalfTaps,_that.secondHalfTaps,_that.eventLogs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AttentionGameState gameState,  int? countdownValue,  int level,  List<CardData> cards,  List<int> flippedCardIds,  bool isProcessing,  DateTime? startTime,  int moves,  int errors,  int? hintCardId,  bool isCompleted,  int randomTaps,  int immediateRepeatErrors,  List<TapRecord> tapRecords,  List<int> recentlyFlippedCardIds,  DateTime? firstHalfEndTime,  int firstHalfTaps,  int secondHalfTaps,  List<TestEventLog> eventLogs)  $default,) {final _that = this;
switch (_that) {
case _AttentionTestState():
return $default(_that.gameState,_that.countdownValue,_that.level,_that.cards,_that.flippedCardIds,_that.isProcessing,_that.startTime,_that.moves,_that.errors,_that.hintCardId,_that.isCompleted,_that.randomTaps,_that.immediateRepeatErrors,_that.tapRecords,_that.recentlyFlippedCardIds,_that.firstHalfEndTime,_that.firstHalfTaps,_that.secondHalfTaps,_that.eventLogs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AttentionGameState gameState,  int? countdownValue,  int level,  List<CardData> cards,  List<int> flippedCardIds,  bool isProcessing,  DateTime? startTime,  int moves,  int errors,  int? hintCardId,  bool isCompleted,  int randomTaps,  int immediateRepeatErrors,  List<TapRecord> tapRecords,  List<int> recentlyFlippedCardIds,  DateTime? firstHalfEndTime,  int firstHalfTaps,  int secondHalfTaps,  List<TestEventLog> eventLogs)?  $default,) {final _that = this;
switch (_that) {
case _AttentionTestState() when $default != null:
return $default(_that.gameState,_that.countdownValue,_that.level,_that.cards,_that.flippedCardIds,_that.isProcessing,_that.startTime,_that.moves,_that.errors,_that.hintCardId,_that.isCompleted,_that.randomTaps,_that.immediateRepeatErrors,_that.tapRecords,_that.recentlyFlippedCardIds,_that.firstHalfEndTime,_that.firstHalfTaps,_that.secondHalfTaps,_that.eventLogs);case _:
  return null;

}
}

}

/// @nodoc


class _AttentionTestState implements AttentionTestState {
  const _AttentionTestState({this.gameState = AttentionGameState.countdown, this.countdownValue = null, this.level = 1, final  List<CardData> cards = const [], final  List<int> flippedCardIds = const [], this.isProcessing = false, this.startTime = null, this.moves = 0, this.errors = 0, this.hintCardId = null, this.isCompleted = false, this.randomTaps = 0, this.immediateRepeatErrors = 0, final  List<TapRecord> tapRecords = const [], final  List<int> recentlyFlippedCardIds = const [], this.firstHalfEndTime = null, this.firstHalfTaps = 0, this.secondHalfTaps = 0, final  List<TestEventLog> eventLogs = const []}): _cards = cards,_flippedCardIds = flippedCardIds,_tapRecords = tapRecords,_recentlyFlippedCardIds = recentlyFlippedCardIds,_eventLogs = eventLogs;
  

@override@JsonKey() final  AttentionGameState gameState;
@override@JsonKey() final  int? countdownValue;
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
// === 관찰 지표 필드 ===
/// 무작위 터치 횟수 (짧은 시간 내 연속 터치, 패턴 없이 터치)
@override@JsonKey() final  int randomTaps;
/// 즉시 반복 오류 (방금 확인한 카드를 바로 다시 터치)
@override@JsonKey() final  int immediateRepeatErrors;
/// 모든 터치 기록 (지속성 분석용)
 final  List<TapRecord> _tapRecords;
/// 모든 터치 기록 (지속성 분석용)
@override@JsonKey() List<TapRecord> get tapRecords {
  if (_tapRecords is EqualUnmodifiableListView) return _tapRecords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tapRecords);
}

/// 마지막으로 뒤집은 카드 ID 목록 (최근 2개)
 final  List<int> _recentlyFlippedCardIds;
/// 마지막으로 뒤집은 카드 ID 목록 (최근 2개)
@override@JsonKey() List<int> get recentlyFlippedCardIds {
  if (_recentlyFlippedCardIds is EqualUnmodifiableListView) return _recentlyFlippedCardIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentlyFlippedCardIds);
}

/// 전반부 완료 시간 (첫 번째 레벨 또는 전반 50% 완료)
@override@JsonKey() final  DateTime? firstHalfEndTime;
/// 전반부 터치 횟수
@override@JsonKey() final  int firstHalfTaps;
/// 후반부 터치 횟수
@override@JsonKey() final  int secondHalfTaps;
/// 이벤트 로그 (테스트 중 발생한 모든 이벤트)
 final  List<TestEventLog> _eventLogs;
/// 이벤트 로그 (테스트 중 발생한 모든 이벤트)
@override@JsonKey() List<TestEventLog> get eventLogs {
  if (_eventLogs is EqualUnmodifiableListView) return _eventLogs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eventLogs);
}


/// Create a copy of AttentionTestState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttentionTestStateCopyWith<_AttentionTestState> get copyWith => __$AttentionTestStateCopyWithImpl<_AttentionTestState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttentionTestState&&(identical(other.gameState, gameState) || other.gameState == gameState)&&(identical(other.countdownValue, countdownValue) || other.countdownValue == countdownValue)&&(identical(other.level, level) || other.level == level)&&const DeepCollectionEquality().equals(other._cards, _cards)&&const DeepCollectionEquality().equals(other._flippedCardIds, _flippedCardIds)&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.moves, moves) || other.moves == moves)&&(identical(other.errors, errors) || other.errors == errors)&&(identical(other.hintCardId, hintCardId) || other.hintCardId == hintCardId)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.randomTaps, randomTaps) || other.randomTaps == randomTaps)&&(identical(other.immediateRepeatErrors, immediateRepeatErrors) || other.immediateRepeatErrors == immediateRepeatErrors)&&const DeepCollectionEquality().equals(other._tapRecords, _tapRecords)&&const DeepCollectionEquality().equals(other._recentlyFlippedCardIds, _recentlyFlippedCardIds)&&(identical(other.firstHalfEndTime, firstHalfEndTime) || other.firstHalfEndTime == firstHalfEndTime)&&(identical(other.firstHalfTaps, firstHalfTaps) || other.firstHalfTaps == firstHalfTaps)&&(identical(other.secondHalfTaps, secondHalfTaps) || other.secondHalfTaps == secondHalfTaps)&&const DeepCollectionEquality().equals(other._eventLogs, _eventLogs));
}


@override
int get hashCode => Object.hashAll([runtimeType,gameState,countdownValue,level,const DeepCollectionEquality().hash(_cards),const DeepCollectionEquality().hash(_flippedCardIds),isProcessing,startTime,moves,errors,hintCardId,isCompleted,randomTaps,immediateRepeatErrors,const DeepCollectionEquality().hash(_tapRecords),const DeepCollectionEquality().hash(_recentlyFlippedCardIds),firstHalfEndTime,firstHalfTaps,secondHalfTaps,const DeepCollectionEquality().hash(_eventLogs)]);

@override
String toString() {
  return 'AttentionTestState(gameState: $gameState, countdownValue: $countdownValue, level: $level, cards: $cards, flippedCardIds: $flippedCardIds, isProcessing: $isProcessing, startTime: $startTime, moves: $moves, errors: $errors, hintCardId: $hintCardId, isCompleted: $isCompleted, randomTaps: $randomTaps, immediateRepeatErrors: $immediateRepeatErrors, tapRecords: $tapRecords, recentlyFlippedCardIds: $recentlyFlippedCardIds, firstHalfEndTime: $firstHalfEndTime, firstHalfTaps: $firstHalfTaps, secondHalfTaps: $secondHalfTaps, eventLogs: $eventLogs)';
}


}

/// @nodoc
abstract mixin class _$AttentionTestStateCopyWith<$Res> implements $AttentionTestStateCopyWith<$Res> {
  factory _$AttentionTestStateCopyWith(_AttentionTestState value, $Res Function(_AttentionTestState) _then) = __$AttentionTestStateCopyWithImpl;
@override @useResult
$Res call({
 AttentionGameState gameState, int? countdownValue, int level, List<CardData> cards, List<int> flippedCardIds, bool isProcessing, DateTime? startTime, int moves, int errors, int? hintCardId, bool isCompleted, int randomTaps, int immediateRepeatErrors, List<TapRecord> tapRecords, List<int> recentlyFlippedCardIds, DateTime? firstHalfEndTime, int firstHalfTaps, int secondHalfTaps, List<TestEventLog> eventLogs
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
@override @pragma('vm:prefer-inline') $Res call({Object? gameState = null,Object? countdownValue = freezed,Object? level = null,Object? cards = null,Object? flippedCardIds = null,Object? isProcessing = null,Object? startTime = freezed,Object? moves = null,Object? errors = null,Object? hintCardId = freezed,Object? isCompleted = null,Object? randomTaps = null,Object? immediateRepeatErrors = null,Object? tapRecords = null,Object? recentlyFlippedCardIds = null,Object? firstHalfEndTime = freezed,Object? firstHalfTaps = null,Object? secondHalfTaps = null,Object? eventLogs = null,}) {
  return _then(_AttentionTestState(
gameState: null == gameState ? _self.gameState : gameState // ignore: cast_nullable_to_non_nullable
as AttentionGameState,countdownValue: freezed == countdownValue ? _self.countdownValue : countdownValue // ignore: cast_nullable_to_non_nullable
as int?,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,cards: null == cards ? _self._cards : cards // ignore: cast_nullable_to_non_nullable
as List<CardData>,flippedCardIds: null == flippedCardIds ? _self._flippedCardIds : flippedCardIds // ignore: cast_nullable_to_non_nullable
as List<int>,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,moves: null == moves ? _self.moves : moves // ignore: cast_nullable_to_non_nullable
as int,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as int,hintCardId: freezed == hintCardId ? _self.hintCardId : hintCardId // ignore: cast_nullable_to_non_nullable
as int?,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,randomTaps: null == randomTaps ? _self.randomTaps : randomTaps // ignore: cast_nullable_to_non_nullable
as int,immediateRepeatErrors: null == immediateRepeatErrors ? _self.immediateRepeatErrors : immediateRepeatErrors // ignore: cast_nullable_to_non_nullable
as int,tapRecords: null == tapRecords ? _self._tapRecords : tapRecords // ignore: cast_nullable_to_non_nullable
as List<TapRecord>,recentlyFlippedCardIds: null == recentlyFlippedCardIds ? _self._recentlyFlippedCardIds : recentlyFlippedCardIds // ignore: cast_nullable_to_non_nullable
as List<int>,firstHalfEndTime: freezed == firstHalfEndTime ? _self.firstHalfEndTime : firstHalfEndTime // ignore: cast_nullable_to_non_nullable
as DateTime?,firstHalfTaps: null == firstHalfTaps ? _self.firstHalfTaps : firstHalfTaps // ignore: cast_nullable_to_non_nullable
as int,secondHalfTaps: null == secondHalfTaps ? _self.secondHalfTaps : secondHalfTaps // ignore: cast_nullable_to_non_nullable
as int,eventLogs: null == eventLogs ? _self._eventLogs : eventLogs // ignore: cast_nullable_to_non_nullable
as List<TestEventLog>,
  ));
}


}

// dart format on
