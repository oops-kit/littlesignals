// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportData {

/// 시각화용 점수 (0-100, Z점수 기반으로 변환됨)
 double get visualScore;/// 행동 스타일 제목
 String get title;/// 행동 스타일 설명
 String get description;/// 양육 팁 목록
 List<String> get tips;/// 그래프 왼쪽 라벨
 String get lowLabel;/// 그래프 오른쪽 라벨
 String get highLabel;/// Z점수 결과 (null이면 기존 방식 사용)
 ZScoreResult? get zScoreResult;/// 주의력 분석 결과 (주의력 테스트인 경우)
 AttentionAnalysisResult? get attentionAnalysis;/// 충동성 분석 결과 (충동성 테스트인 경우)
 ImpulsivityAnalysisResult? get impulsivityAnalysis;
/// Create a copy of ReportData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportDataCopyWith<ReportData> get copyWith => _$ReportDataCopyWithImpl<ReportData>(this as ReportData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportData&&(identical(other.visualScore, visualScore) || other.visualScore == visualScore)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.tips, tips)&&(identical(other.lowLabel, lowLabel) || other.lowLabel == lowLabel)&&(identical(other.highLabel, highLabel) || other.highLabel == highLabel)&&(identical(other.zScoreResult, zScoreResult) || other.zScoreResult == zScoreResult)&&(identical(other.attentionAnalysis, attentionAnalysis) || other.attentionAnalysis == attentionAnalysis)&&(identical(other.impulsivityAnalysis, impulsivityAnalysis) || other.impulsivityAnalysis == impulsivityAnalysis));
}


@override
int get hashCode => Object.hash(runtimeType,visualScore,title,description,const DeepCollectionEquality().hash(tips),lowLabel,highLabel,zScoreResult,attentionAnalysis,impulsivityAnalysis);

@override
String toString() {
  return 'ReportData(visualScore: $visualScore, title: $title, description: $description, tips: $tips, lowLabel: $lowLabel, highLabel: $highLabel, zScoreResult: $zScoreResult, attentionAnalysis: $attentionAnalysis, impulsivityAnalysis: $impulsivityAnalysis)';
}


}

/// @nodoc
abstract mixin class $ReportDataCopyWith<$Res>  {
  factory $ReportDataCopyWith(ReportData value, $Res Function(ReportData) _then) = _$ReportDataCopyWithImpl;
@useResult
$Res call({
 double visualScore, String title, String description, List<String> tips, String lowLabel, String highLabel, ZScoreResult? zScoreResult, AttentionAnalysisResult? attentionAnalysis, ImpulsivityAnalysisResult? impulsivityAnalysis
});


$ZScoreResultCopyWith<$Res>? get zScoreResult;$AttentionAnalysisResultCopyWith<$Res>? get attentionAnalysis;$ImpulsivityAnalysisResultCopyWith<$Res>? get impulsivityAnalysis;

}
/// @nodoc
class _$ReportDataCopyWithImpl<$Res>
    implements $ReportDataCopyWith<$Res> {
  _$ReportDataCopyWithImpl(this._self, this._then);

  final ReportData _self;
  final $Res Function(ReportData) _then;

/// Create a copy of ReportData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? visualScore = null,Object? title = null,Object? description = null,Object? tips = null,Object? lowLabel = null,Object? highLabel = null,Object? zScoreResult = freezed,Object? attentionAnalysis = freezed,Object? impulsivityAnalysis = freezed,}) {
  return _then(_self.copyWith(
visualScore: null == visualScore ? _self.visualScore : visualScore // ignore: cast_nullable_to_non_nullable
as double,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,tips: null == tips ? _self.tips : tips // ignore: cast_nullable_to_non_nullable
as List<String>,lowLabel: null == lowLabel ? _self.lowLabel : lowLabel // ignore: cast_nullable_to_non_nullable
as String,highLabel: null == highLabel ? _self.highLabel : highLabel // ignore: cast_nullable_to_non_nullable
as String,zScoreResult: freezed == zScoreResult ? _self.zScoreResult : zScoreResult // ignore: cast_nullable_to_non_nullable
as ZScoreResult?,attentionAnalysis: freezed == attentionAnalysis ? _self.attentionAnalysis : attentionAnalysis // ignore: cast_nullable_to_non_nullable
as AttentionAnalysisResult?,impulsivityAnalysis: freezed == impulsivityAnalysis ? _self.impulsivityAnalysis : impulsivityAnalysis // ignore: cast_nullable_to_non_nullable
as ImpulsivityAnalysisResult?,
  ));
}
/// Create a copy of ReportData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ZScoreResultCopyWith<$Res>? get zScoreResult {
    if (_self.zScoreResult == null) {
    return null;
  }

  return $ZScoreResultCopyWith<$Res>(_self.zScoreResult!, (value) {
    return _then(_self.copyWith(zScoreResult: value));
  });
}/// Create a copy of ReportData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttentionAnalysisResultCopyWith<$Res>? get attentionAnalysis {
    if (_self.attentionAnalysis == null) {
    return null;
  }

  return $AttentionAnalysisResultCopyWith<$Res>(_self.attentionAnalysis!, (value) {
    return _then(_self.copyWith(attentionAnalysis: value));
  });
}/// Create a copy of ReportData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImpulsivityAnalysisResultCopyWith<$Res>? get impulsivityAnalysis {
    if (_self.impulsivityAnalysis == null) {
    return null;
  }

  return $ImpulsivityAnalysisResultCopyWith<$Res>(_self.impulsivityAnalysis!, (value) {
    return _then(_self.copyWith(impulsivityAnalysis: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReportData].
extension ReportDataPatterns on ReportData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportData value)  $default,){
final _that = this;
switch (_that) {
case _ReportData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportData value)?  $default,){
final _that = this;
switch (_that) {
case _ReportData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double visualScore,  String title,  String description,  List<String> tips,  String lowLabel,  String highLabel,  ZScoreResult? zScoreResult,  AttentionAnalysisResult? attentionAnalysis,  ImpulsivityAnalysisResult? impulsivityAnalysis)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportData() when $default != null:
return $default(_that.visualScore,_that.title,_that.description,_that.tips,_that.lowLabel,_that.highLabel,_that.zScoreResult,_that.attentionAnalysis,_that.impulsivityAnalysis);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double visualScore,  String title,  String description,  List<String> tips,  String lowLabel,  String highLabel,  ZScoreResult? zScoreResult,  AttentionAnalysisResult? attentionAnalysis,  ImpulsivityAnalysisResult? impulsivityAnalysis)  $default,) {final _that = this;
switch (_that) {
case _ReportData():
return $default(_that.visualScore,_that.title,_that.description,_that.tips,_that.lowLabel,_that.highLabel,_that.zScoreResult,_that.attentionAnalysis,_that.impulsivityAnalysis);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double visualScore,  String title,  String description,  List<String> tips,  String lowLabel,  String highLabel,  ZScoreResult? zScoreResult,  AttentionAnalysisResult? attentionAnalysis,  ImpulsivityAnalysisResult? impulsivityAnalysis)?  $default,) {final _that = this;
switch (_that) {
case _ReportData() when $default != null:
return $default(_that.visualScore,_that.title,_that.description,_that.tips,_that.lowLabel,_that.highLabel,_that.zScoreResult,_that.attentionAnalysis,_that.impulsivityAnalysis);case _:
  return null;

}
}

}

/// @nodoc


class _ReportData implements ReportData {
  const _ReportData({required this.visualScore, required this.title, required this.description, required final  List<String> tips, required this.lowLabel, required this.highLabel, this.zScoreResult, this.attentionAnalysis, this.impulsivityAnalysis}): _tips = tips;
  

/// 시각화용 점수 (0-100, Z점수 기반으로 변환됨)
@override final  double visualScore;
/// 행동 스타일 제목
@override final  String title;
/// 행동 스타일 설명
@override final  String description;
/// 양육 팁 목록
 final  List<String> _tips;
/// 양육 팁 목록
@override List<String> get tips {
  if (_tips is EqualUnmodifiableListView) return _tips;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tips);
}

/// 그래프 왼쪽 라벨
@override final  String lowLabel;
/// 그래프 오른쪽 라벨
@override final  String highLabel;
/// Z점수 결과 (null이면 기존 방식 사용)
@override final  ZScoreResult? zScoreResult;
/// 주의력 분석 결과 (주의력 테스트인 경우)
@override final  AttentionAnalysisResult? attentionAnalysis;
/// 충동성 분석 결과 (충동성 테스트인 경우)
@override final  ImpulsivityAnalysisResult? impulsivityAnalysis;

/// Create a copy of ReportData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportDataCopyWith<_ReportData> get copyWith => __$ReportDataCopyWithImpl<_ReportData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportData&&(identical(other.visualScore, visualScore) || other.visualScore == visualScore)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._tips, _tips)&&(identical(other.lowLabel, lowLabel) || other.lowLabel == lowLabel)&&(identical(other.highLabel, highLabel) || other.highLabel == highLabel)&&(identical(other.zScoreResult, zScoreResult) || other.zScoreResult == zScoreResult)&&(identical(other.attentionAnalysis, attentionAnalysis) || other.attentionAnalysis == attentionAnalysis)&&(identical(other.impulsivityAnalysis, impulsivityAnalysis) || other.impulsivityAnalysis == impulsivityAnalysis));
}


@override
int get hashCode => Object.hash(runtimeType,visualScore,title,description,const DeepCollectionEquality().hash(_tips),lowLabel,highLabel,zScoreResult,attentionAnalysis,impulsivityAnalysis);

@override
String toString() {
  return 'ReportData(visualScore: $visualScore, title: $title, description: $description, tips: $tips, lowLabel: $lowLabel, highLabel: $highLabel, zScoreResult: $zScoreResult, attentionAnalysis: $attentionAnalysis, impulsivityAnalysis: $impulsivityAnalysis)';
}


}

/// @nodoc
abstract mixin class _$ReportDataCopyWith<$Res> implements $ReportDataCopyWith<$Res> {
  factory _$ReportDataCopyWith(_ReportData value, $Res Function(_ReportData) _then) = __$ReportDataCopyWithImpl;
@override @useResult
$Res call({
 double visualScore, String title, String description, List<String> tips, String lowLabel, String highLabel, ZScoreResult? zScoreResult, AttentionAnalysisResult? attentionAnalysis, ImpulsivityAnalysisResult? impulsivityAnalysis
});


@override $ZScoreResultCopyWith<$Res>? get zScoreResult;@override $AttentionAnalysisResultCopyWith<$Res>? get attentionAnalysis;@override $ImpulsivityAnalysisResultCopyWith<$Res>? get impulsivityAnalysis;

}
/// @nodoc
class __$ReportDataCopyWithImpl<$Res>
    implements _$ReportDataCopyWith<$Res> {
  __$ReportDataCopyWithImpl(this._self, this._then);

  final _ReportData _self;
  final $Res Function(_ReportData) _then;

/// Create a copy of ReportData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? visualScore = null,Object? title = null,Object? description = null,Object? tips = null,Object? lowLabel = null,Object? highLabel = null,Object? zScoreResult = freezed,Object? attentionAnalysis = freezed,Object? impulsivityAnalysis = freezed,}) {
  return _then(_ReportData(
visualScore: null == visualScore ? _self.visualScore : visualScore // ignore: cast_nullable_to_non_nullable
as double,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,tips: null == tips ? _self._tips : tips // ignore: cast_nullable_to_non_nullable
as List<String>,lowLabel: null == lowLabel ? _self.lowLabel : lowLabel // ignore: cast_nullable_to_non_nullable
as String,highLabel: null == highLabel ? _self.highLabel : highLabel // ignore: cast_nullable_to_non_nullable
as String,zScoreResult: freezed == zScoreResult ? _self.zScoreResult : zScoreResult // ignore: cast_nullable_to_non_nullable
as ZScoreResult?,attentionAnalysis: freezed == attentionAnalysis ? _self.attentionAnalysis : attentionAnalysis // ignore: cast_nullable_to_non_nullable
as AttentionAnalysisResult?,impulsivityAnalysis: freezed == impulsivityAnalysis ? _self.impulsivityAnalysis : impulsivityAnalysis // ignore: cast_nullable_to_non_nullable
as ImpulsivityAnalysisResult?,
  ));
}

/// Create a copy of ReportData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ZScoreResultCopyWith<$Res>? get zScoreResult {
    if (_self.zScoreResult == null) {
    return null;
  }

  return $ZScoreResultCopyWith<$Res>(_self.zScoreResult!, (value) {
    return _then(_self.copyWith(zScoreResult: value));
  });
}/// Create a copy of ReportData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttentionAnalysisResultCopyWith<$Res>? get attentionAnalysis {
    if (_self.attentionAnalysis == null) {
    return null;
  }

  return $AttentionAnalysisResultCopyWith<$Res>(_self.attentionAnalysis!, (value) {
    return _then(_self.copyWith(attentionAnalysis: value));
  });
}/// Create a copy of ReportData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImpulsivityAnalysisResultCopyWith<$Res>? get impulsivityAnalysis {
    if (_self.impulsivityAnalysis == null) {
    return null;
  }

  return $ImpulsivityAnalysisResultCopyWith<$Res>(_self.impulsivityAnalysis!, (value) {
    return _then(_self.copyWith(impulsivityAnalysis: value));
  });
}
}

// dart format on
