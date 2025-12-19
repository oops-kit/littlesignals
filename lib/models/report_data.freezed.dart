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

 double get visualScore; String get title; String get description; List<String> get tips; String get lowLabel; String get highLabel;
/// Create a copy of ReportData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportDataCopyWith<ReportData> get copyWith => _$ReportDataCopyWithImpl<ReportData>(this as ReportData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportData&&(identical(other.visualScore, visualScore) || other.visualScore == visualScore)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.tips, tips)&&(identical(other.lowLabel, lowLabel) || other.lowLabel == lowLabel)&&(identical(other.highLabel, highLabel) || other.highLabel == highLabel));
}


@override
int get hashCode => Object.hash(runtimeType,visualScore,title,description,const DeepCollectionEquality().hash(tips),lowLabel,highLabel);

@override
String toString() {
  return 'ReportData(visualScore: $visualScore, title: $title, description: $description, tips: $tips, lowLabel: $lowLabel, highLabel: $highLabel)';
}


}

/// @nodoc
abstract mixin class $ReportDataCopyWith<$Res>  {
  factory $ReportDataCopyWith(ReportData value, $Res Function(ReportData) _then) = _$ReportDataCopyWithImpl;
@useResult
$Res call({
 double visualScore, String title, String description, List<String> tips, String lowLabel, String highLabel
});




}
/// @nodoc
class _$ReportDataCopyWithImpl<$Res>
    implements $ReportDataCopyWith<$Res> {
  _$ReportDataCopyWithImpl(this._self, this._then);

  final ReportData _self;
  final $Res Function(ReportData) _then;

/// Create a copy of ReportData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? visualScore = null,Object? title = null,Object? description = null,Object? tips = null,Object? lowLabel = null,Object? highLabel = null,}) {
  return _then(_self.copyWith(
visualScore: null == visualScore ? _self.visualScore : visualScore // ignore: cast_nullable_to_non_nullable
as double,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,tips: null == tips ? _self.tips : tips // ignore: cast_nullable_to_non_nullable
as List<String>,lowLabel: null == lowLabel ? _self.lowLabel : lowLabel // ignore: cast_nullable_to_non_nullable
as String,highLabel: null == highLabel ? _self.highLabel : highLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double visualScore,  String title,  String description,  List<String> tips,  String lowLabel,  String highLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportData() when $default != null:
return $default(_that.visualScore,_that.title,_that.description,_that.tips,_that.lowLabel,_that.highLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double visualScore,  String title,  String description,  List<String> tips,  String lowLabel,  String highLabel)  $default,) {final _that = this;
switch (_that) {
case _ReportData():
return $default(_that.visualScore,_that.title,_that.description,_that.tips,_that.lowLabel,_that.highLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double visualScore,  String title,  String description,  List<String> tips,  String lowLabel,  String highLabel)?  $default,) {final _that = this;
switch (_that) {
case _ReportData() when $default != null:
return $default(_that.visualScore,_that.title,_that.description,_that.tips,_that.lowLabel,_that.highLabel);case _:
  return null;

}
}

}

/// @nodoc


class _ReportData implements ReportData {
  const _ReportData({required this.visualScore, required this.title, required this.description, required final  List<String> tips, required this.lowLabel, required this.highLabel}): _tips = tips;
  

@override final  double visualScore;
@override final  String title;
@override final  String description;
 final  List<String> _tips;
@override List<String> get tips {
  if (_tips is EqualUnmodifiableListView) return _tips;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tips);
}

@override final  String lowLabel;
@override final  String highLabel;

/// Create a copy of ReportData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportDataCopyWith<_ReportData> get copyWith => __$ReportDataCopyWithImpl<_ReportData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportData&&(identical(other.visualScore, visualScore) || other.visualScore == visualScore)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._tips, _tips)&&(identical(other.lowLabel, lowLabel) || other.lowLabel == lowLabel)&&(identical(other.highLabel, highLabel) || other.highLabel == highLabel));
}


@override
int get hashCode => Object.hash(runtimeType,visualScore,title,description,const DeepCollectionEquality().hash(_tips),lowLabel,highLabel);

@override
String toString() {
  return 'ReportData(visualScore: $visualScore, title: $title, description: $description, tips: $tips, lowLabel: $lowLabel, highLabel: $highLabel)';
}


}

/// @nodoc
abstract mixin class _$ReportDataCopyWith<$Res> implements $ReportDataCopyWith<$Res> {
  factory _$ReportDataCopyWith(_ReportData value, $Res Function(_ReportData) _then) = __$ReportDataCopyWithImpl;
@override @useResult
$Res call({
 double visualScore, String title, String description, List<String> tips, String lowLabel, String highLabel
});




}
/// @nodoc
class __$ReportDataCopyWithImpl<$Res>
    implements _$ReportDataCopyWith<$Res> {
  __$ReportDataCopyWithImpl(this._self, this._then);

  final _ReportData _self;
  final $Res Function(_ReportData) _then;

/// Create a copy of ReportData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? visualScore = null,Object? title = null,Object? description = null,Object? tips = null,Object? lowLabel = null,Object? highLabel = null,}) {
  return _then(_ReportData(
visualScore: null == visualScore ? _self.visualScore : visualScore // ignore: cast_nullable_to_non_nullable
as double,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,tips: null == tips ? _self._tips : tips // ignore: cast_nullable_to_non_nullable
as List<String>,lowLabel: null == lowLabel ? _self.lowLabel : lowLabel // ignore: cast_nullable_to_non_nullable
as String,highLabel: null == highLabel ? _self.highLabel : highLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
