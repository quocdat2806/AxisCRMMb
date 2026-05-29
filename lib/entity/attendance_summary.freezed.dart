// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AttendanceSummary {

@JsonKey(name: 'full_days') int get fullDays;@JsonKey(name: 'half_days') int get halfDays;@JsonKey(name: 'absent_days') int get absentDays;@JsonKey(name: 'total_shifts') int get totalShifts;
/// Create a copy of AttendanceSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceSummaryCopyWith<AttendanceSummary> get copyWith => _$AttendanceSummaryCopyWithImpl<AttendanceSummary>(this as AttendanceSummary, _$identity);

  /// Serializes this AttendanceSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceSummary&&(identical(other.fullDays, fullDays) || other.fullDays == fullDays)&&(identical(other.halfDays, halfDays) || other.halfDays == halfDays)&&(identical(other.absentDays, absentDays) || other.absentDays == absentDays)&&(identical(other.totalShifts, totalShifts) || other.totalShifts == totalShifts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullDays,halfDays,absentDays,totalShifts);

@override
String toString() {
  return 'AttendanceSummary(fullDays: $fullDays, halfDays: $halfDays, absentDays: $absentDays, totalShifts: $totalShifts)';
}


}

/// @nodoc
abstract mixin class $AttendanceSummaryCopyWith<$Res>  {
  factory $AttendanceSummaryCopyWith(AttendanceSummary value, $Res Function(AttendanceSummary) _then) = _$AttendanceSummaryCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'full_days') int fullDays,@JsonKey(name: 'half_days') int halfDays,@JsonKey(name: 'absent_days') int absentDays,@JsonKey(name: 'total_shifts') int totalShifts
});




}
/// @nodoc
class _$AttendanceSummaryCopyWithImpl<$Res>
    implements $AttendanceSummaryCopyWith<$Res> {
  _$AttendanceSummaryCopyWithImpl(this._self, this._then);

  final AttendanceSummary _self;
  final $Res Function(AttendanceSummary) _then;

/// Create a copy of AttendanceSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullDays = null,Object? halfDays = null,Object? absentDays = null,Object? totalShifts = null,}) {
  return _then(_self.copyWith(
fullDays: null == fullDays ? _self.fullDays : fullDays // ignore: cast_nullable_to_non_nullable
as int,halfDays: null == halfDays ? _self.halfDays : halfDays // ignore: cast_nullable_to_non_nullable
as int,absentDays: null == absentDays ? _self.absentDays : absentDays // ignore: cast_nullable_to_non_nullable
as int,totalShifts: null == totalShifts ? _self.totalShifts : totalShifts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceSummary].
extension AttendanceSummaryPatterns on AttendanceSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceSummary value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceSummary value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'full_days')  int fullDays, @JsonKey(name: 'half_days')  int halfDays, @JsonKey(name: 'absent_days')  int absentDays, @JsonKey(name: 'total_shifts')  int totalShifts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceSummary() when $default != null:
return $default(_that.fullDays,_that.halfDays,_that.absentDays,_that.totalShifts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'full_days')  int fullDays, @JsonKey(name: 'half_days')  int halfDays, @JsonKey(name: 'absent_days')  int absentDays, @JsonKey(name: 'total_shifts')  int totalShifts)  $default,) {final _that = this;
switch (_that) {
case _AttendanceSummary():
return $default(_that.fullDays,_that.halfDays,_that.absentDays,_that.totalShifts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'full_days')  int fullDays, @JsonKey(name: 'half_days')  int halfDays, @JsonKey(name: 'absent_days')  int absentDays, @JsonKey(name: 'total_shifts')  int totalShifts)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceSummary() when $default != null:
return $default(_that.fullDays,_that.halfDays,_that.absentDays,_that.totalShifts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttendanceSummary implements AttendanceSummary {
  const _AttendanceSummary({@JsonKey(name: 'full_days') this.fullDays = 0, @JsonKey(name: 'half_days') this.halfDays = 0, @JsonKey(name: 'absent_days') this.absentDays = 0, @JsonKey(name: 'total_shifts') this.totalShifts = 0});
  factory _AttendanceSummary.fromJson(Map<String, dynamic> json) => _$AttendanceSummaryFromJson(json);

@override@JsonKey(name: 'full_days') final  int fullDays;
@override@JsonKey(name: 'half_days') final  int halfDays;
@override@JsonKey(name: 'absent_days') final  int absentDays;
@override@JsonKey(name: 'total_shifts') final  int totalShifts;

/// Create a copy of AttendanceSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceSummaryCopyWith<_AttendanceSummary> get copyWith => __$AttendanceSummaryCopyWithImpl<_AttendanceSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttendanceSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceSummary&&(identical(other.fullDays, fullDays) || other.fullDays == fullDays)&&(identical(other.halfDays, halfDays) || other.halfDays == halfDays)&&(identical(other.absentDays, absentDays) || other.absentDays == absentDays)&&(identical(other.totalShifts, totalShifts) || other.totalShifts == totalShifts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullDays,halfDays,absentDays,totalShifts);

@override
String toString() {
  return 'AttendanceSummary(fullDays: $fullDays, halfDays: $halfDays, absentDays: $absentDays, totalShifts: $totalShifts)';
}


}

/// @nodoc
abstract mixin class _$AttendanceSummaryCopyWith<$Res> implements $AttendanceSummaryCopyWith<$Res> {
  factory _$AttendanceSummaryCopyWith(_AttendanceSummary value, $Res Function(_AttendanceSummary) _then) = __$AttendanceSummaryCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'full_days') int fullDays,@JsonKey(name: 'half_days') int halfDays,@JsonKey(name: 'absent_days') int absentDays,@JsonKey(name: 'total_shifts') int totalShifts
});




}
/// @nodoc
class __$AttendanceSummaryCopyWithImpl<$Res>
    implements _$AttendanceSummaryCopyWith<$Res> {
  __$AttendanceSummaryCopyWithImpl(this._self, this._then);

  final _AttendanceSummary _self;
  final $Res Function(_AttendanceSummary) _then;

/// Create a copy of AttendanceSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullDays = null,Object? halfDays = null,Object? absentDays = null,Object? totalShifts = null,}) {
  return _then(_AttendanceSummary(
fullDays: null == fullDays ? _self.fullDays : fullDays // ignore: cast_nullable_to_non_nullable
as int,halfDays: null == halfDays ? _self.halfDays : halfDays // ignore: cast_nullable_to_non_nullable
as int,absentDays: null == absentDays ? _self.absentDays : absentDays // ignore: cast_nullable_to_non_nullable
as int,totalShifts: null == totalShifts ? _self.totalShifts : totalShifts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
