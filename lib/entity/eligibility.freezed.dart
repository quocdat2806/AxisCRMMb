// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eligibility.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Eligibility {

@JsonKey(name: 'can_check_in') bool get canCheckIn;@JsonKey(name: 'can_check_out') bool get canCheckOut;@JsonKey(name: 'distance_meters') int get distanceMeters;@JsonKey(name: 'radius_meters') int get radiusMeters; String? get reason;@JsonKey(name: 'attendance_id') String? get attendanceId;
/// Create a copy of Eligibility
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EligibilityCopyWith<Eligibility> get copyWith => _$EligibilityCopyWithImpl<Eligibility>(this as Eligibility, _$identity);

  /// Serializes this Eligibility to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Eligibility&&(identical(other.canCheckIn, canCheckIn) || other.canCheckIn == canCheckIn)&&(identical(other.canCheckOut, canCheckOut) || other.canCheckOut == canCheckOut)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.radiusMeters, radiusMeters) || other.radiusMeters == radiusMeters)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.attendanceId, attendanceId) || other.attendanceId == attendanceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,canCheckIn,canCheckOut,distanceMeters,radiusMeters,reason,attendanceId);

@override
String toString() {
  return 'Eligibility(canCheckIn: $canCheckIn, canCheckOut: $canCheckOut, distanceMeters: $distanceMeters, radiusMeters: $radiusMeters, reason: $reason, attendanceId: $attendanceId)';
}


}

/// @nodoc
abstract mixin class $EligibilityCopyWith<$Res>  {
  factory $EligibilityCopyWith(Eligibility value, $Res Function(Eligibility) _then) = _$EligibilityCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'can_check_in') bool canCheckIn,@JsonKey(name: 'can_check_out') bool canCheckOut,@JsonKey(name: 'distance_meters') int distanceMeters,@JsonKey(name: 'radius_meters') int radiusMeters, String? reason,@JsonKey(name: 'attendance_id') String? attendanceId
});




}
/// @nodoc
class _$EligibilityCopyWithImpl<$Res>
    implements $EligibilityCopyWith<$Res> {
  _$EligibilityCopyWithImpl(this._self, this._then);

  final Eligibility _self;
  final $Res Function(Eligibility) _then;

/// Create a copy of Eligibility
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? canCheckIn = null,Object? canCheckOut = null,Object? distanceMeters = null,Object? radiusMeters = null,Object? reason = freezed,Object? attendanceId = freezed,}) {
  return _then(_self.copyWith(
canCheckIn: null == canCheckIn ? _self.canCheckIn : canCheckIn // ignore: cast_nullable_to_non_nullable
as bool,canCheckOut: null == canCheckOut ? _self.canCheckOut : canCheckOut // ignore: cast_nullable_to_non_nullable
as bool,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int,radiusMeters: null == radiusMeters ? _self.radiusMeters : radiusMeters // ignore: cast_nullable_to_non_nullable
as int,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,attendanceId: freezed == attendanceId ? _self.attendanceId : attendanceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Eligibility].
extension EligibilityPatterns on Eligibility {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Eligibility value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Eligibility() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Eligibility value)  $default,){
final _that = this;
switch (_that) {
case _Eligibility():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Eligibility value)?  $default,){
final _that = this;
switch (_that) {
case _Eligibility() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'can_check_in')  bool canCheckIn, @JsonKey(name: 'can_check_out')  bool canCheckOut, @JsonKey(name: 'distance_meters')  int distanceMeters, @JsonKey(name: 'radius_meters')  int radiusMeters,  String? reason, @JsonKey(name: 'attendance_id')  String? attendanceId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Eligibility() when $default != null:
return $default(_that.canCheckIn,_that.canCheckOut,_that.distanceMeters,_that.radiusMeters,_that.reason,_that.attendanceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'can_check_in')  bool canCheckIn, @JsonKey(name: 'can_check_out')  bool canCheckOut, @JsonKey(name: 'distance_meters')  int distanceMeters, @JsonKey(name: 'radius_meters')  int radiusMeters,  String? reason, @JsonKey(name: 'attendance_id')  String? attendanceId)  $default,) {final _that = this;
switch (_that) {
case _Eligibility():
return $default(_that.canCheckIn,_that.canCheckOut,_that.distanceMeters,_that.radiusMeters,_that.reason,_that.attendanceId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'can_check_in')  bool canCheckIn, @JsonKey(name: 'can_check_out')  bool canCheckOut, @JsonKey(name: 'distance_meters')  int distanceMeters, @JsonKey(name: 'radius_meters')  int radiusMeters,  String? reason, @JsonKey(name: 'attendance_id')  String? attendanceId)?  $default,) {final _that = this;
switch (_that) {
case _Eligibility() when $default != null:
return $default(_that.canCheckIn,_that.canCheckOut,_that.distanceMeters,_that.radiusMeters,_that.reason,_that.attendanceId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Eligibility implements Eligibility {
  const _Eligibility({@JsonKey(name: 'can_check_in') required this.canCheckIn, @JsonKey(name: 'can_check_out') required this.canCheckOut, @JsonKey(name: 'distance_meters') required this.distanceMeters, @JsonKey(name: 'radius_meters') required this.radiusMeters, this.reason, @JsonKey(name: 'attendance_id') this.attendanceId});
  factory _Eligibility.fromJson(Map<String, dynamic> json) => _$EligibilityFromJson(json);

@override@JsonKey(name: 'can_check_in') final  bool canCheckIn;
@override@JsonKey(name: 'can_check_out') final  bool canCheckOut;
@override@JsonKey(name: 'distance_meters') final  int distanceMeters;
@override@JsonKey(name: 'radius_meters') final  int radiusMeters;
@override final  String? reason;
@override@JsonKey(name: 'attendance_id') final  String? attendanceId;

/// Create a copy of Eligibility
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EligibilityCopyWith<_Eligibility> get copyWith => __$EligibilityCopyWithImpl<_Eligibility>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EligibilityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Eligibility&&(identical(other.canCheckIn, canCheckIn) || other.canCheckIn == canCheckIn)&&(identical(other.canCheckOut, canCheckOut) || other.canCheckOut == canCheckOut)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.radiusMeters, radiusMeters) || other.radiusMeters == radiusMeters)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.attendanceId, attendanceId) || other.attendanceId == attendanceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,canCheckIn,canCheckOut,distanceMeters,radiusMeters,reason,attendanceId);

@override
String toString() {
  return 'Eligibility(canCheckIn: $canCheckIn, canCheckOut: $canCheckOut, distanceMeters: $distanceMeters, radiusMeters: $radiusMeters, reason: $reason, attendanceId: $attendanceId)';
}


}

/// @nodoc
abstract mixin class _$EligibilityCopyWith<$Res> implements $EligibilityCopyWith<$Res> {
  factory _$EligibilityCopyWith(_Eligibility value, $Res Function(_Eligibility) _then) = __$EligibilityCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'can_check_in') bool canCheckIn,@JsonKey(name: 'can_check_out') bool canCheckOut,@JsonKey(name: 'distance_meters') int distanceMeters,@JsonKey(name: 'radius_meters') int radiusMeters, String? reason,@JsonKey(name: 'attendance_id') String? attendanceId
});




}
/// @nodoc
class __$EligibilityCopyWithImpl<$Res>
    implements _$EligibilityCopyWith<$Res> {
  __$EligibilityCopyWithImpl(this._self, this._then);

  final _Eligibility _self;
  final $Res Function(_Eligibility) _then;

/// Create a copy of Eligibility
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? canCheckIn = null,Object? canCheckOut = null,Object? distanceMeters = null,Object? radiusMeters = null,Object? reason = freezed,Object? attendanceId = freezed,}) {
  return _then(_Eligibility(
canCheckIn: null == canCheckIn ? _self.canCheckIn : canCheckIn // ignore: cast_nullable_to_non_nullable
as bool,canCheckOut: null == canCheckOut ? _self.canCheckOut : canCheckOut // ignore: cast_nullable_to_non_nullable
as bool,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int,radiusMeters: null == radiusMeters ? _self.radiusMeters : radiusMeters // ignore: cast_nullable_to_non_nullable
as int,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,attendanceId: freezed == attendanceId ? _self.attendanceId : attendanceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
