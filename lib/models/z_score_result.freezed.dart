// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'z_score_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ZScoreResult {

/// Z점수 값 (내부 계산용, UI에 직접 노출 안함)
 double get zScore;/// 부모용 라벨 (예: "또래 평균", "참을성이 좋음")
 String get label;/// 또래 평균값
 double get peerMean;/// 또래 표준편차
 double get peerStdDev;/// 아동의 관측값
 double get observedValue;
/// Create a copy of ZScoreResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZScoreResultCopyWith<ZScoreResult> get copyWith => _$ZScoreResultCopyWithImpl<ZScoreResult>(this as ZScoreResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZScoreResult&&(identical(other.zScore, zScore) || other.zScore == zScore)&&(identical(other.label, label) || other.label == label)&&(identical(other.peerMean, peerMean) || other.peerMean == peerMean)&&(identical(other.peerStdDev, peerStdDev) || other.peerStdDev == peerStdDev)&&(identical(other.observedValue, observedValue) || other.observedValue == observedValue));
}


@override
int get hashCode => Object.hash(runtimeType,zScore,label,peerMean,peerStdDev,observedValue);

@override
String toString() {
  return 'ZScoreResult(zScore: $zScore, label: $label, peerMean: $peerMean, peerStdDev: $peerStdDev, observedValue: $observedValue)';
}


}

/// @nodoc
abstract mixin class $ZScoreResultCopyWith<$Res>  {
  factory $ZScoreResultCopyWith(ZScoreResult value, $Res Function(ZScoreResult) _then) = _$ZScoreResultCopyWithImpl;
@useResult
$Res call({
 double zScore, String label, double peerMean, double peerStdDev, double observedValue
});




}
/// @nodoc
class _$ZScoreResultCopyWithImpl<$Res>
    implements $ZScoreResultCopyWith<$Res> {
  _$ZScoreResultCopyWithImpl(this._self, this._then);

  final ZScoreResult _self;
  final $Res Function(ZScoreResult) _then;

/// Create a copy of ZScoreResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? zScore = null,Object? label = null,Object? peerMean = null,Object? peerStdDev = null,Object? observedValue = null,}) {
  return _then(_self.copyWith(
zScore: null == zScore ? _self.zScore : zScore // ignore: cast_nullable_to_non_nullable
as double,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,peerMean: null == peerMean ? _self.peerMean : peerMean // ignore: cast_nullable_to_non_nullable
as double,peerStdDev: null == peerStdDev ? _self.peerStdDev : peerStdDev // ignore: cast_nullable_to_non_nullable
as double,observedValue: null == observedValue ? _self.observedValue : observedValue // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ZScoreResult].
extension ZScoreResultPatterns on ZScoreResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ZScoreResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ZScoreResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ZScoreResult value)  $default,){
final _that = this;
switch (_that) {
case _ZScoreResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ZScoreResult value)?  $default,){
final _that = this;
switch (_that) {
case _ZScoreResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double zScore,  String label,  double peerMean,  double peerStdDev,  double observedValue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ZScoreResult() when $default != null:
return $default(_that.zScore,_that.label,_that.peerMean,_that.peerStdDev,_that.observedValue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double zScore,  String label,  double peerMean,  double peerStdDev,  double observedValue)  $default,) {final _that = this;
switch (_that) {
case _ZScoreResult():
return $default(_that.zScore,_that.label,_that.peerMean,_that.peerStdDev,_that.observedValue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double zScore,  String label,  double peerMean,  double peerStdDev,  double observedValue)?  $default,) {final _that = this;
switch (_that) {
case _ZScoreResult() when $default != null:
return $default(_that.zScore,_that.label,_that.peerMean,_that.peerStdDev,_that.observedValue);case _:
  return null;

}
}

}

/// @nodoc


class _ZScoreResult extends ZScoreResult {
  const _ZScoreResult({required this.zScore, required this.label, required this.peerMean, required this.peerStdDev, required this.observedValue}): super._();
  

/// Z점수 값 (내부 계산용, UI에 직접 노출 안함)
@override final  double zScore;
/// 부모용 라벨 (예: "또래 평균", "참을성이 좋음")
@override final  String label;
/// 또래 평균값
@override final  double peerMean;
/// 또래 표준편차
@override final  double peerStdDev;
/// 아동의 관측값
@override final  double observedValue;

/// Create a copy of ZScoreResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZScoreResultCopyWith<_ZScoreResult> get copyWith => __$ZScoreResultCopyWithImpl<_ZScoreResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZScoreResult&&(identical(other.zScore, zScore) || other.zScore == zScore)&&(identical(other.label, label) || other.label == label)&&(identical(other.peerMean, peerMean) || other.peerMean == peerMean)&&(identical(other.peerStdDev, peerStdDev) || other.peerStdDev == peerStdDev)&&(identical(other.observedValue, observedValue) || other.observedValue == observedValue));
}


@override
int get hashCode => Object.hash(runtimeType,zScore,label,peerMean,peerStdDev,observedValue);

@override
String toString() {
  return 'ZScoreResult(zScore: $zScore, label: $label, peerMean: $peerMean, peerStdDev: $peerStdDev, observedValue: $observedValue)';
}


}

/// @nodoc
abstract mixin class _$ZScoreResultCopyWith<$Res> implements $ZScoreResultCopyWith<$Res> {
  factory _$ZScoreResultCopyWith(_ZScoreResult value, $Res Function(_ZScoreResult) _then) = __$ZScoreResultCopyWithImpl;
@override @useResult
$Res call({
 double zScore, String label, double peerMean, double peerStdDev, double observedValue
});




}
/// @nodoc
class __$ZScoreResultCopyWithImpl<$Res>
    implements _$ZScoreResultCopyWith<$Res> {
  __$ZScoreResultCopyWithImpl(this._self, this._then);

  final _ZScoreResult _self;
  final $Res Function(_ZScoreResult) _then;

/// Create a copy of ZScoreResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? zScore = null,Object? label = null,Object? peerMean = null,Object? peerStdDev = null,Object? observedValue = null,}) {
  return _then(_ZScoreResult(
zScore: null == zScore ? _self.zScore : zScore // ignore: cast_nullable_to_non_nullable
as double,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,peerMean: null == peerMean ? _self.peerMean : peerMean // ignore: cast_nullable_to_non_nullable
as double,peerStdDev: null == peerStdDev ? _self.peerStdDev : peerStdDev // ignore: cast_nullable_to_non_nullable
as double,observedValue: null == observedValue ? _self.observedValue : observedValue // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$AttentionAnalysisResult {

/// MER Z점수 결과
 ZScoreResult get merZScore;/// 재확인율 Z점수 결과
 ZScoreResult get revisitingRateZScore;/// 행동 패턴 유형
 AttentionBehaviorPattern get behaviorPattern;/// MER 값 (0-1)
 double get mer;/// 재확인율 (0-1)
 double get revisitingRate;/// 평균 반응시간 (초)
 double get avgReactionTime;/// 반응시간이 정상 범위 내인지
 bool get isReactionTimeNormal;
/// Create a copy of AttentionAnalysisResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttentionAnalysisResultCopyWith<AttentionAnalysisResult> get copyWith => _$AttentionAnalysisResultCopyWithImpl<AttentionAnalysisResult>(this as AttentionAnalysisResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttentionAnalysisResult&&(identical(other.merZScore, merZScore) || other.merZScore == merZScore)&&(identical(other.revisitingRateZScore, revisitingRateZScore) || other.revisitingRateZScore == revisitingRateZScore)&&(identical(other.behaviorPattern, behaviorPattern) || other.behaviorPattern == behaviorPattern)&&(identical(other.mer, mer) || other.mer == mer)&&(identical(other.revisitingRate, revisitingRate) || other.revisitingRate == revisitingRate)&&(identical(other.avgReactionTime, avgReactionTime) || other.avgReactionTime == avgReactionTime)&&(identical(other.isReactionTimeNormal, isReactionTimeNormal) || other.isReactionTimeNormal == isReactionTimeNormal));
}


@override
int get hashCode => Object.hash(runtimeType,merZScore,revisitingRateZScore,behaviorPattern,mer,revisitingRate,avgReactionTime,isReactionTimeNormal);

@override
String toString() {
  return 'AttentionAnalysisResult(merZScore: $merZScore, revisitingRateZScore: $revisitingRateZScore, behaviorPattern: $behaviorPattern, mer: $mer, revisitingRate: $revisitingRate, avgReactionTime: $avgReactionTime, isReactionTimeNormal: $isReactionTimeNormal)';
}


}

/// @nodoc
abstract mixin class $AttentionAnalysisResultCopyWith<$Res>  {
  factory $AttentionAnalysisResultCopyWith(AttentionAnalysisResult value, $Res Function(AttentionAnalysisResult) _then) = _$AttentionAnalysisResultCopyWithImpl;
@useResult
$Res call({
 ZScoreResult merZScore, ZScoreResult revisitingRateZScore, AttentionBehaviorPattern behaviorPattern, double mer, double revisitingRate, double avgReactionTime, bool isReactionTimeNormal
});


$ZScoreResultCopyWith<$Res> get merZScore;$ZScoreResultCopyWith<$Res> get revisitingRateZScore;

}
/// @nodoc
class _$AttentionAnalysisResultCopyWithImpl<$Res>
    implements $AttentionAnalysisResultCopyWith<$Res> {
  _$AttentionAnalysisResultCopyWithImpl(this._self, this._then);

  final AttentionAnalysisResult _self;
  final $Res Function(AttentionAnalysisResult) _then;

/// Create a copy of AttentionAnalysisResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? merZScore = null,Object? revisitingRateZScore = null,Object? behaviorPattern = null,Object? mer = null,Object? revisitingRate = null,Object? avgReactionTime = null,Object? isReactionTimeNormal = null,}) {
  return _then(_self.copyWith(
merZScore: null == merZScore ? _self.merZScore : merZScore // ignore: cast_nullable_to_non_nullable
as ZScoreResult,revisitingRateZScore: null == revisitingRateZScore ? _self.revisitingRateZScore : revisitingRateZScore // ignore: cast_nullable_to_non_nullable
as ZScoreResult,behaviorPattern: null == behaviorPattern ? _self.behaviorPattern : behaviorPattern // ignore: cast_nullable_to_non_nullable
as AttentionBehaviorPattern,mer: null == mer ? _self.mer : mer // ignore: cast_nullable_to_non_nullable
as double,revisitingRate: null == revisitingRate ? _self.revisitingRate : revisitingRate // ignore: cast_nullable_to_non_nullable
as double,avgReactionTime: null == avgReactionTime ? _self.avgReactionTime : avgReactionTime // ignore: cast_nullable_to_non_nullable
as double,isReactionTimeNormal: null == isReactionTimeNormal ? _self.isReactionTimeNormal : isReactionTimeNormal // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of AttentionAnalysisResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ZScoreResultCopyWith<$Res> get merZScore {
  
  return $ZScoreResultCopyWith<$Res>(_self.merZScore, (value) {
    return _then(_self.copyWith(merZScore: value));
  });
}/// Create a copy of AttentionAnalysisResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ZScoreResultCopyWith<$Res> get revisitingRateZScore {
  
  return $ZScoreResultCopyWith<$Res>(_self.revisitingRateZScore, (value) {
    return _then(_self.copyWith(revisitingRateZScore: value));
  });
}
}


/// Adds pattern-matching-related methods to [AttentionAnalysisResult].
extension AttentionAnalysisResultPatterns on AttentionAnalysisResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttentionAnalysisResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttentionAnalysisResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttentionAnalysisResult value)  $default,){
final _that = this;
switch (_that) {
case _AttentionAnalysisResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttentionAnalysisResult value)?  $default,){
final _that = this;
switch (_that) {
case _AttentionAnalysisResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ZScoreResult merZScore,  ZScoreResult revisitingRateZScore,  AttentionBehaviorPattern behaviorPattern,  double mer,  double revisitingRate,  double avgReactionTime,  bool isReactionTimeNormal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttentionAnalysisResult() when $default != null:
return $default(_that.merZScore,_that.revisitingRateZScore,_that.behaviorPattern,_that.mer,_that.revisitingRate,_that.avgReactionTime,_that.isReactionTimeNormal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ZScoreResult merZScore,  ZScoreResult revisitingRateZScore,  AttentionBehaviorPattern behaviorPattern,  double mer,  double revisitingRate,  double avgReactionTime,  bool isReactionTimeNormal)  $default,) {final _that = this;
switch (_that) {
case _AttentionAnalysisResult():
return $default(_that.merZScore,_that.revisitingRateZScore,_that.behaviorPattern,_that.mer,_that.revisitingRate,_that.avgReactionTime,_that.isReactionTimeNormal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ZScoreResult merZScore,  ZScoreResult revisitingRateZScore,  AttentionBehaviorPattern behaviorPattern,  double mer,  double revisitingRate,  double avgReactionTime,  bool isReactionTimeNormal)?  $default,) {final _that = this;
switch (_that) {
case _AttentionAnalysisResult() when $default != null:
return $default(_that.merZScore,_that.revisitingRateZScore,_that.behaviorPattern,_that.mer,_that.revisitingRate,_that.avgReactionTime,_that.isReactionTimeNormal);case _:
  return null;

}
}

}

/// @nodoc


class _AttentionAnalysisResult implements AttentionAnalysisResult {
  const _AttentionAnalysisResult({required this.merZScore, required this.revisitingRateZScore, required this.behaviorPattern, required this.mer, required this.revisitingRate, required this.avgReactionTime, required this.isReactionTimeNormal});
  

/// MER Z점수 결과
@override final  ZScoreResult merZScore;
/// 재확인율 Z점수 결과
@override final  ZScoreResult revisitingRateZScore;
/// 행동 패턴 유형
@override final  AttentionBehaviorPattern behaviorPattern;
/// MER 값 (0-1)
@override final  double mer;
/// 재확인율 (0-1)
@override final  double revisitingRate;
/// 평균 반응시간 (초)
@override final  double avgReactionTime;
/// 반응시간이 정상 범위 내인지
@override final  bool isReactionTimeNormal;

/// Create a copy of AttentionAnalysisResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttentionAnalysisResultCopyWith<_AttentionAnalysisResult> get copyWith => __$AttentionAnalysisResultCopyWithImpl<_AttentionAnalysisResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttentionAnalysisResult&&(identical(other.merZScore, merZScore) || other.merZScore == merZScore)&&(identical(other.revisitingRateZScore, revisitingRateZScore) || other.revisitingRateZScore == revisitingRateZScore)&&(identical(other.behaviorPattern, behaviorPattern) || other.behaviorPattern == behaviorPattern)&&(identical(other.mer, mer) || other.mer == mer)&&(identical(other.revisitingRate, revisitingRate) || other.revisitingRate == revisitingRate)&&(identical(other.avgReactionTime, avgReactionTime) || other.avgReactionTime == avgReactionTime)&&(identical(other.isReactionTimeNormal, isReactionTimeNormal) || other.isReactionTimeNormal == isReactionTimeNormal));
}


@override
int get hashCode => Object.hash(runtimeType,merZScore,revisitingRateZScore,behaviorPattern,mer,revisitingRate,avgReactionTime,isReactionTimeNormal);

@override
String toString() {
  return 'AttentionAnalysisResult(merZScore: $merZScore, revisitingRateZScore: $revisitingRateZScore, behaviorPattern: $behaviorPattern, mer: $mer, revisitingRate: $revisitingRate, avgReactionTime: $avgReactionTime, isReactionTimeNormal: $isReactionTimeNormal)';
}


}

/// @nodoc
abstract mixin class _$AttentionAnalysisResultCopyWith<$Res> implements $AttentionAnalysisResultCopyWith<$Res> {
  factory _$AttentionAnalysisResultCopyWith(_AttentionAnalysisResult value, $Res Function(_AttentionAnalysisResult) _then) = __$AttentionAnalysisResultCopyWithImpl;
@override @useResult
$Res call({
 ZScoreResult merZScore, ZScoreResult revisitingRateZScore, AttentionBehaviorPattern behaviorPattern, double mer, double revisitingRate, double avgReactionTime, bool isReactionTimeNormal
});


@override $ZScoreResultCopyWith<$Res> get merZScore;@override $ZScoreResultCopyWith<$Res> get revisitingRateZScore;

}
/// @nodoc
class __$AttentionAnalysisResultCopyWithImpl<$Res>
    implements _$AttentionAnalysisResultCopyWith<$Res> {
  __$AttentionAnalysisResultCopyWithImpl(this._self, this._then);

  final _AttentionAnalysisResult _self;
  final $Res Function(_AttentionAnalysisResult) _then;

/// Create a copy of AttentionAnalysisResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? merZScore = null,Object? revisitingRateZScore = null,Object? behaviorPattern = null,Object? mer = null,Object? revisitingRate = null,Object? avgReactionTime = null,Object? isReactionTimeNormal = null,}) {
  return _then(_AttentionAnalysisResult(
merZScore: null == merZScore ? _self.merZScore : merZScore // ignore: cast_nullable_to_non_nullable
as ZScoreResult,revisitingRateZScore: null == revisitingRateZScore ? _self.revisitingRateZScore : revisitingRateZScore // ignore: cast_nullable_to_non_nullable
as ZScoreResult,behaviorPattern: null == behaviorPattern ? _self.behaviorPattern : behaviorPattern // ignore: cast_nullable_to_non_nullable
as AttentionBehaviorPattern,mer: null == mer ? _self.mer : mer // ignore: cast_nullable_to_non_nullable
as double,revisitingRate: null == revisitingRate ? _self.revisitingRate : revisitingRate // ignore: cast_nullable_to_non_nullable
as double,avgReactionTime: null == avgReactionTime ? _self.avgReactionTime : avgReactionTime // ignore: cast_nullable_to_non_nullable
as double,isReactionTimeNormal: null == isReactionTimeNormal ? _self.isReactionTimeNormal : isReactionTimeNormal // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of AttentionAnalysisResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ZScoreResultCopyWith<$Res> get merZScore {
  
  return $ZScoreResultCopyWith<$Res>(_self.merZScore, (value) {
    return _then(_self.copyWith(merZScore: value));
  });
}/// Create a copy of AttentionAnalysisResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ZScoreResultCopyWith<$Res> get revisitingRateZScore {
  
  return $ZScoreResultCopyWith<$Res>(_self.revisitingRateZScore, (value) {
    return _then(_self.copyWith(revisitingRateZScore: value));
  });
}
}

/// @nodoc
mixin _$ImpulsivityAnalysisResult {

/// 억제 비율 Z점수 결과
 ZScoreResult get inhibitionZScore;/// 행동 패턴 유형
 ImpulsivityBehaviorPattern get behaviorPattern;/// 억제 비율 (0-1)
 double get inhibitionRate;/// 평균 반응시간 (ms)
 double get avgReactionTime;/// 반응시간이 또래 평균보다 빠른지
 bool get isFastReactor;
/// Create a copy of ImpulsivityAnalysisResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImpulsivityAnalysisResultCopyWith<ImpulsivityAnalysisResult> get copyWith => _$ImpulsivityAnalysisResultCopyWithImpl<ImpulsivityAnalysisResult>(this as ImpulsivityAnalysisResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImpulsivityAnalysisResult&&(identical(other.inhibitionZScore, inhibitionZScore) || other.inhibitionZScore == inhibitionZScore)&&(identical(other.behaviorPattern, behaviorPattern) || other.behaviorPattern == behaviorPattern)&&(identical(other.inhibitionRate, inhibitionRate) || other.inhibitionRate == inhibitionRate)&&(identical(other.avgReactionTime, avgReactionTime) || other.avgReactionTime == avgReactionTime)&&(identical(other.isFastReactor, isFastReactor) || other.isFastReactor == isFastReactor));
}


@override
int get hashCode => Object.hash(runtimeType,inhibitionZScore,behaviorPattern,inhibitionRate,avgReactionTime,isFastReactor);

@override
String toString() {
  return 'ImpulsivityAnalysisResult(inhibitionZScore: $inhibitionZScore, behaviorPattern: $behaviorPattern, inhibitionRate: $inhibitionRate, avgReactionTime: $avgReactionTime, isFastReactor: $isFastReactor)';
}


}

/// @nodoc
abstract mixin class $ImpulsivityAnalysisResultCopyWith<$Res>  {
  factory $ImpulsivityAnalysisResultCopyWith(ImpulsivityAnalysisResult value, $Res Function(ImpulsivityAnalysisResult) _then) = _$ImpulsivityAnalysisResultCopyWithImpl;
@useResult
$Res call({
 ZScoreResult inhibitionZScore, ImpulsivityBehaviorPattern behaviorPattern, double inhibitionRate, double avgReactionTime, bool isFastReactor
});


$ZScoreResultCopyWith<$Res> get inhibitionZScore;

}
/// @nodoc
class _$ImpulsivityAnalysisResultCopyWithImpl<$Res>
    implements $ImpulsivityAnalysisResultCopyWith<$Res> {
  _$ImpulsivityAnalysisResultCopyWithImpl(this._self, this._then);

  final ImpulsivityAnalysisResult _self;
  final $Res Function(ImpulsivityAnalysisResult) _then;

/// Create a copy of ImpulsivityAnalysisResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? inhibitionZScore = null,Object? behaviorPattern = null,Object? inhibitionRate = null,Object? avgReactionTime = null,Object? isFastReactor = null,}) {
  return _then(_self.copyWith(
inhibitionZScore: null == inhibitionZScore ? _self.inhibitionZScore : inhibitionZScore // ignore: cast_nullable_to_non_nullable
as ZScoreResult,behaviorPattern: null == behaviorPattern ? _self.behaviorPattern : behaviorPattern // ignore: cast_nullable_to_non_nullable
as ImpulsivityBehaviorPattern,inhibitionRate: null == inhibitionRate ? _self.inhibitionRate : inhibitionRate // ignore: cast_nullable_to_non_nullable
as double,avgReactionTime: null == avgReactionTime ? _self.avgReactionTime : avgReactionTime // ignore: cast_nullable_to_non_nullable
as double,isFastReactor: null == isFastReactor ? _self.isFastReactor : isFastReactor // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ImpulsivityAnalysisResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ZScoreResultCopyWith<$Res> get inhibitionZScore {
  
  return $ZScoreResultCopyWith<$Res>(_self.inhibitionZScore, (value) {
    return _then(_self.copyWith(inhibitionZScore: value));
  });
}
}


/// Adds pattern-matching-related methods to [ImpulsivityAnalysisResult].
extension ImpulsivityAnalysisResultPatterns on ImpulsivityAnalysisResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImpulsivityAnalysisResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImpulsivityAnalysisResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImpulsivityAnalysisResult value)  $default,){
final _that = this;
switch (_that) {
case _ImpulsivityAnalysisResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImpulsivityAnalysisResult value)?  $default,){
final _that = this;
switch (_that) {
case _ImpulsivityAnalysisResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ZScoreResult inhibitionZScore,  ImpulsivityBehaviorPattern behaviorPattern,  double inhibitionRate,  double avgReactionTime,  bool isFastReactor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImpulsivityAnalysisResult() when $default != null:
return $default(_that.inhibitionZScore,_that.behaviorPattern,_that.inhibitionRate,_that.avgReactionTime,_that.isFastReactor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ZScoreResult inhibitionZScore,  ImpulsivityBehaviorPattern behaviorPattern,  double inhibitionRate,  double avgReactionTime,  bool isFastReactor)  $default,) {final _that = this;
switch (_that) {
case _ImpulsivityAnalysisResult():
return $default(_that.inhibitionZScore,_that.behaviorPattern,_that.inhibitionRate,_that.avgReactionTime,_that.isFastReactor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ZScoreResult inhibitionZScore,  ImpulsivityBehaviorPattern behaviorPattern,  double inhibitionRate,  double avgReactionTime,  bool isFastReactor)?  $default,) {final _that = this;
switch (_that) {
case _ImpulsivityAnalysisResult() when $default != null:
return $default(_that.inhibitionZScore,_that.behaviorPattern,_that.inhibitionRate,_that.avgReactionTime,_that.isFastReactor);case _:
  return null;

}
}

}

/// @nodoc


class _ImpulsivityAnalysisResult implements ImpulsivityAnalysisResult {
  const _ImpulsivityAnalysisResult({required this.inhibitionZScore, required this.behaviorPattern, required this.inhibitionRate, required this.avgReactionTime, required this.isFastReactor});
  

/// 억제 비율 Z점수 결과
@override final  ZScoreResult inhibitionZScore;
/// 행동 패턴 유형
@override final  ImpulsivityBehaviorPattern behaviorPattern;
/// 억제 비율 (0-1)
@override final  double inhibitionRate;
/// 평균 반응시간 (ms)
@override final  double avgReactionTime;
/// 반응시간이 또래 평균보다 빠른지
@override final  bool isFastReactor;

/// Create a copy of ImpulsivityAnalysisResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImpulsivityAnalysisResultCopyWith<_ImpulsivityAnalysisResult> get copyWith => __$ImpulsivityAnalysisResultCopyWithImpl<_ImpulsivityAnalysisResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImpulsivityAnalysisResult&&(identical(other.inhibitionZScore, inhibitionZScore) || other.inhibitionZScore == inhibitionZScore)&&(identical(other.behaviorPattern, behaviorPattern) || other.behaviorPattern == behaviorPattern)&&(identical(other.inhibitionRate, inhibitionRate) || other.inhibitionRate == inhibitionRate)&&(identical(other.avgReactionTime, avgReactionTime) || other.avgReactionTime == avgReactionTime)&&(identical(other.isFastReactor, isFastReactor) || other.isFastReactor == isFastReactor));
}


@override
int get hashCode => Object.hash(runtimeType,inhibitionZScore,behaviorPattern,inhibitionRate,avgReactionTime,isFastReactor);

@override
String toString() {
  return 'ImpulsivityAnalysisResult(inhibitionZScore: $inhibitionZScore, behaviorPattern: $behaviorPattern, inhibitionRate: $inhibitionRate, avgReactionTime: $avgReactionTime, isFastReactor: $isFastReactor)';
}


}

/// @nodoc
abstract mixin class _$ImpulsivityAnalysisResultCopyWith<$Res> implements $ImpulsivityAnalysisResultCopyWith<$Res> {
  factory _$ImpulsivityAnalysisResultCopyWith(_ImpulsivityAnalysisResult value, $Res Function(_ImpulsivityAnalysisResult) _then) = __$ImpulsivityAnalysisResultCopyWithImpl;
@override @useResult
$Res call({
 ZScoreResult inhibitionZScore, ImpulsivityBehaviorPattern behaviorPattern, double inhibitionRate, double avgReactionTime, bool isFastReactor
});


@override $ZScoreResultCopyWith<$Res> get inhibitionZScore;

}
/// @nodoc
class __$ImpulsivityAnalysisResultCopyWithImpl<$Res>
    implements _$ImpulsivityAnalysisResultCopyWith<$Res> {
  __$ImpulsivityAnalysisResultCopyWithImpl(this._self, this._then);

  final _ImpulsivityAnalysisResult _self;
  final $Res Function(_ImpulsivityAnalysisResult) _then;

/// Create a copy of ImpulsivityAnalysisResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? inhibitionZScore = null,Object? behaviorPattern = null,Object? inhibitionRate = null,Object? avgReactionTime = null,Object? isFastReactor = null,}) {
  return _then(_ImpulsivityAnalysisResult(
inhibitionZScore: null == inhibitionZScore ? _self.inhibitionZScore : inhibitionZScore // ignore: cast_nullable_to_non_nullable
as ZScoreResult,behaviorPattern: null == behaviorPattern ? _self.behaviorPattern : behaviorPattern // ignore: cast_nullable_to_non_nullable
as ImpulsivityBehaviorPattern,inhibitionRate: null == inhibitionRate ? _self.inhibitionRate : inhibitionRate // ignore: cast_nullable_to_non_nullable
as double,avgReactionTime: null == avgReactionTime ? _self.avgReactionTime : avgReactionTime // ignore: cast_nullable_to_non_nullable
as double,isFastReactor: null == isFastReactor ? _self.isFastReactor : isFastReactor // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ImpulsivityAnalysisResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ZScoreResultCopyWith<$Res> get inhibitionZScore {
  
  return $ZScoreResultCopyWith<$Res>(_self.inhibitionZScore, (value) {
    return _then(_self.copyWith(inhibitionZScore: value));
  });
}
}

// dart format on
