// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DailySummary {

 DateTime get date;@JsonKey(name: 'project_id') String? get projectId;@JsonKey(name: 'project_name') String? get projectName; String get shift;@JsonKey(name: 'shift_value') int get shiftValue;@JsonKey(name: 'daily_rate') int get dailyRate; int get earned;@JsonKey(name: 'check_in_at') DateTime? get checkInAt;@JsonKey(name: 'check_out_at') DateTime? get checkOutAt;
/// Create a copy of DailySummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailySummaryCopyWith<DailySummary> get copyWith => _$DailySummaryCopyWithImpl<DailySummary>(this as DailySummary, _$identity);

  /// Serializes this DailySummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailySummary&&(identical(other.date, date) || other.date == date)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.projectName, projectName) || other.projectName == projectName)&&(identical(other.shift, shift) || other.shift == shift)&&(identical(other.shiftValue, shiftValue) || other.shiftValue == shiftValue)&&(identical(other.dailyRate, dailyRate) || other.dailyRate == dailyRate)&&(identical(other.earned, earned) || other.earned == earned)&&(identical(other.checkInAt, checkInAt) || other.checkInAt == checkInAt)&&(identical(other.checkOutAt, checkOutAt) || other.checkOutAt == checkOutAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,projectId,projectName,shift,shiftValue,dailyRate,earned,checkInAt,checkOutAt);

@override
String toString() {
  return 'DailySummary(date: $date, projectId: $projectId, projectName: $projectName, shift: $shift, shiftValue: $shiftValue, dailyRate: $dailyRate, earned: $earned, checkInAt: $checkInAt, checkOutAt: $checkOutAt)';
}


}

/// @nodoc
abstract mixin class $DailySummaryCopyWith<$Res>  {
  factory $DailySummaryCopyWith(DailySummary value, $Res Function(DailySummary) _then) = _$DailySummaryCopyWithImpl;
@useResult
$Res call({
 DateTime date,@JsonKey(name: 'project_id') String? projectId,@JsonKey(name: 'project_name') String? projectName, String shift,@JsonKey(name: 'shift_value') int shiftValue,@JsonKey(name: 'daily_rate') int dailyRate, int earned,@JsonKey(name: 'check_in_at') DateTime? checkInAt,@JsonKey(name: 'check_out_at') DateTime? checkOutAt
});




}
/// @nodoc
class _$DailySummaryCopyWithImpl<$Res>
    implements $DailySummaryCopyWith<$Res> {
  _$DailySummaryCopyWithImpl(this._self, this._then);

  final DailySummary _self;
  final $Res Function(DailySummary) _then;

/// Create a copy of DailySummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? projectId = freezed,Object? projectName = freezed,Object? shift = null,Object? shiftValue = null,Object? dailyRate = null,Object? earned = null,Object? checkInAt = freezed,Object? checkOutAt = freezed,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String?,projectName: freezed == projectName ? _self.projectName : projectName // ignore: cast_nullable_to_non_nullable
as String?,shift: null == shift ? _self.shift : shift // ignore: cast_nullable_to_non_nullable
as String,shiftValue: null == shiftValue ? _self.shiftValue : shiftValue // ignore: cast_nullable_to_non_nullable
as int,dailyRate: null == dailyRate ? _self.dailyRate : dailyRate // ignore: cast_nullable_to_non_nullable
as int,earned: null == earned ? _self.earned : earned // ignore: cast_nullable_to_non_nullable
as int,checkInAt: freezed == checkInAt ? _self.checkInAt : checkInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,checkOutAt: freezed == checkOutAt ? _self.checkOutAt : checkOutAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DailySummary].
extension DailySummaryPatterns on DailySummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailySummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailySummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailySummary value)  $default,){
final _that = this;
switch (_that) {
case _DailySummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailySummary value)?  $default,){
final _that = this;
switch (_that) {
case _DailySummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date, @JsonKey(name: 'project_id')  String? projectId, @JsonKey(name: 'project_name')  String? projectName,  String shift, @JsonKey(name: 'shift_value')  int shiftValue, @JsonKey(name: 'daily_rate')  int dailyRate,  int earned, @JsonKey(name: 'check_in_at')  DateTime? checkInAt, @JsonKey(name: 'check_out_at')  DateTime? checkOutAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailySummary() when $default != null:
return $default(_that.date,_that.projectId,_that.projectName,_that.shift,_that.shiftValue,_that.dailyRate,_that.earned,_that.checkInAt,_that.checkOutAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date, @JsonKey(name: 'project_id')  String? projectId, @JsonKey(name: 'project_name')  String? projectName,  String shift, @JsonKey(name: 'shift_value')  int shiftValue, @JsonKey(name: 'daily_rate')  int dailyRate,  int earned, @JsonKey(name: 'check_in_at')  DateTime? checkInAt, @JsonKey(name: 'check_out_at')  DateTime? checkOutAt)  $default,) {final _that = this;
switch (_that) {
case _DailySummary():
return $default(_that.date,_that.projectId,_that.projectName,_that.shift,_that.shiftValue,_that.dailyRate,_that.earned,_that.checkInAt,_that.checkOutAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date, @JsonKey(name: 'project_id')  String? projectId, @JsonKey(name: 'project_name')  String? projectName,  String shift, @JsonKey(name: 'shift_value')  int shiftValue, @JsonKey(name: 'daily_rate')  int dailyRate,  int earned, @JsonKey(name: 'check_in_at')  DateTime? checkInAt, @JsonKey(name: 'check_out_at')  DateTime? checkOutAt)?  $default,) {final _that = this;
switch (_that) {
case _DailySummary() when $default != null:
return $default(_that.date,_that.projectId,_that.projectName,_that.shift,_that.shiftValue,_that.dailyRate,_that.earned,_that.checkInAt,_that.checkOutAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailySummary implements DailySummary {
  const _DailySummary({required this.date, @JsonKey(name: 'project_id') this.projectId, @JsonKey(name: 'project_name') this.projectName, required this.shift, @JsonKey(name: 'shift_value') required this.shiftValue, @JsonKey(name: 'daily_rate') required this.dailyRate, required this.earned, @JsonKey(name: 'check_in_at') this.checkInAt, @JsonKey(name: 'check_out_at') this.checkOutAt});
  factory _DailySummary.fromJson(Map<String, dynamic> json) => _$DailySummaryFromJson(json);

@override final  DateTime date;
@override@JsonKey(name: 'project_id') final  String? projectId;
@override@JsonKey(name: 'project_name') final  String? projectName;
@override final  String shift;
@override@JsonKey(name: 'shift_value') final  int shiftValue;
@override@JsonKey(name: 'daily_rate') final  int dailyRate;
@override final  int earned;
@override@JsonKey(name: 'check_in_at') final  DateTime? checkInAt;
@override@JsonKey(name: 'check_out_at') final  DateTime? checkOutAt;

/// Create a copy of DailySummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailySummaryCopyWith<_DailySummary> get copyWith => __$DailySummaryCopyWithImpl<_DailySummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailySummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailySummary&&(identical(other.date, date) || other.date == date)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.projectName, projectName) || other.projectName == projectName)&&(identical(other.shift, shift) || other.shift == shift)&&(identical(other.shiftValue, shiftValue) || other.shiftValue == shiftValue)&&(identical(other.dailyRate, dailyRate) || other.dailyRate == dailyRate)&&(identical(other.earned, earned) || other.earned == earned)&&(identical(other.checkInAt, checkInAt) || other.checkInAt == checkInAt)&&(identical(other.checkOutAt, checkOutAt) || other.checkOutAt == checkOutAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,projectId,projectName,shift,shiftValue,dailyRate,earned,checkInAt,checkOutAt);

@override
String toString() {
  return 'DailySummary(date: $date, projectId: $projectId, projectName: $projectName, shift: $shift, shiftValue: $shiftValue, dailyRate: $dailyRate, earned: $earned, checkInAt: $checkInAt, checkOutAt: $checkOutAt)';
}


}

/// @nodoc
abstract mixin class _$DailySummaryCopyWith<$Res> implements $DailySummaryCopyWith<$Res> {
  factory _$DailySummaryCopyWith(_DailySummary value, $Res Function(_DailySummary) _then) = __$DailySummaryCopyWithImpl;
@override @useResult
$Res call({
 DateTime date,@JsonKey(name: 'project_id') String? projectId,@JsonKey(name: 'project_name') String? projectName, String shift,@JsonKey(name: 'shift_value') int shiftValue,@JsonKey(name: 'daily_rate') int dailyRate, int earned,@JsonKey(name: 'check_in_at') DateTime? checkInAt,@JsonKey(name: 'check_out_at') DateTime? checkOutAt
});




}
/// @nodoc
class __$DailySummaryCopyWithImpl<$Res>
    implements _$DailySummaryCopyWith<$Res> {
  __$DailySummaryCopyWithImpl(this._self, this._then);

  final _DailySummary _self;
  final $Res Function(_DailySummary) _then;

/// Create a copy of DailySummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? projectId = freezed,Object? projectName = freezed,Object? shift = null,Object? shiftValue = null,Object? dailyRate = null,Object? earned = null,Object? checkInAt = freezed,Object? checkOutAt = freezed,}) {
  return _then(_DailySummary(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String?,projectName: freezed == projectName ? _self.projectName : projectName // ignore: cast_nullable_to_non_nullable
as String?,shift: null == shift ? _self.shift : shift // ignore: cast_nullable_to_non_nullable
as String,shiftValue: null == shiftValue ? _self.shiftValue : shiftValue // ignore: cast_nullable_to_non_nullable
as int,dailyRate: null == dailyRate ? _self.dailyRate : dailyRate // ignore: cast_nullable_to_non_nullable
as int,earned: null == earned ? _self.earned : earned // ignore: cast_nullable_to_non_nullable
as int,checkInAt: freezed == checkInAt ? _self.checkInAt : checkInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,checkOutAt: freezed == checkOutAt ? _self.checkOutAt : checkOutAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
