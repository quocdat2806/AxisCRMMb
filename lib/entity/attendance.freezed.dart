// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Attendance {

 String get id;@JsonKey(name: 'tenant_id') String get tenantId;@JsonKey(name: 'worker_id') String get workerId;@JsonKey(name: 'project_id') String get projectId; DateTime get date;@JsonKey(name: 'check_in_at') DateTime? get checkInAt;@JsonKey(name: 'check_out_at') DateTime? get checkOutAt;@JsonKey(name: 'check_in_latitude') double? get checkInLatitude;@JsonKey(name: 'check_in_longitude') double? get checkInLongitude;@JsonKey(name: 'check_out_latitude') double? get checkOutLatitude;@JsonKey(name: 'check_out_longitude') double? get checkOutLongitude;@JsonKey(name: 'check_in_distance_meters') int? get checkInDistanceMeters;@JsonKey(name: 'check_out_distance_meters') int? get checkOutDistanceMeters; String? get shift; String? get note;@JsonKey(name: 'created_by') String? get createdBy;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of Attendance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceCopyWith<Attendance> get copyWith => _$AttendanceCopyWithImpl<Attendance>(this as Attendance, _$identity);

  /// Serializes this Attendance to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Attendance&&(identical(other.id, id) || other.id == id)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.workerId, workerId) || other.workerId == workerId)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.date, date) || other.date == date)&&(identical(other.checkInAt, checkInAt) || other.checkInAt == checkInAt)&&(identical(other.checkOutAt, checkOutAt) || other.checkOutAt == checkOutAt)&&(identical(other.checkInLatitude, checkInLatitude) || other.checkInLatitude == checkInLatitude)&&(identical(other.checkInLongitude, checkInLongitude) || other.checkInLongitude == checkInLongitude)&&(identical(other.checkOutLatitude, checkOutLatitude) || other.checkOutLatitude == checkOutLatitude)&&(identical(other.checkOutLongitude, checkOutLongitude) || other.checkOutLongitude == checkOutLongitude)&&(identical(other.checkInDistanceMeters, checkInDistanceMeters) || other.checkInDistanceMeters == checkInDistanceMeters)&&(identical(other.checkOutDistanceMeters, checkOutDistanceMeters) || other.checkOutDistanceMeters == checkOutDistanceMeters)&&(identical(other.shift, shift) || other.shift == shift)&&(identical(other.note, note) || other.note == note)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tenantId,workerId,projectId,date,checkInAt,checkOutAt,checkInLatitude,checkInLongitude,checkOutLatitude,checkOutLongitude,checkInDistanceMeters,checkOutDistanceMeters,shift,note,createdBy,createdAt);

@override
String toString() {
  return 'Attendance(id: $id, tenantId: $tenantId, workerId: $workerId, projectId: $projectId, date: $date, checkInAt: $checkInAt, checkOutAt: $checkOutAt, checkInLatitude: $checkInLatitude, checkInLongitude: $checkInLongitude, checkOutLatitude: $checkOutLatitude, checkOutLongitude: $checkOutLongitude, checkInDistanceMeters: $checkInDistanceMeters, checkOutDistanceMeters: $checkOutDistanceMeters, shift: $shift, note: $note, createdBy: $createdBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AttendanceCopyWith<$Res>  {
  factory $AttendanceCopyWith(Attendance value, $Res Function(Attendance) _then) = _$AttendanceCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'tenant_id') String tenantId,@JsonKey(name: 'worker_id') String workerId,@JsonKey(name: 'project_id') String projectId, DateTime date,@JsonKey(name: 'check_in_at') DateTime? checkInAt,@JsonKey(name: 'check_out_at') DateTime? checkOutAt,@JsonKey(name: 'check_in_latitude') double? checkInLatitude,@JsonKey(name: 'check_in_longitude') double? checkInLongitude,@JsonKey(name: 'check_out_latitude') double? checkOutLatitude,@JsonKey(name: 'check_out_longitude') double? checkOutLongitude,@JsonKey(name: 'check_in_distance_meters') int? checkInDistanceMeters,@JsonKey(name: 'check_out_distance_meters') int? checkOutDistanceMeters, String? shift, String? note,@JsonKey(name: 'created_by') String? createdBy,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$AttendanceCopyWithImpl<$Res>
    implements $AttendanceCopyWith<$Res> {
  _$AttendanceCopyWithImpl(this._self, this._then);

  final Attendance _self;
  final $Res Function(Attendance) _then;

/// Create a copy of Attendance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tenantId = null,Object? workerId = null,Object? projectId = null,Object? date = null,Object? checkInAt = freezed,Object? checkOutAt = freezed,Object? checkInLatitude = freezed,Object? checkInLongitude = freezed,Object? checkOutLatitude = freezed,Object? checkOutLongitude = freezed,Object? checkInDistanceMeters = freezed,Object? checkOutDistanceMeters = freezed,Object? shift = freezed,Object? note = freezed,Object? createdBy = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,workerId: null == workerId ? _self.workerId : workerId // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,checkInAt: freezed == checkInAt ? _self.checkInAt : checkInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,checkOutAt: freezed == checkOutAt ? _self.checkOutAt : checkOutAt // ignore: cast_nullable_to_non_nullable
as DateTime?,checkInLatitude: freezed == checkInLatitude ? _self.checkInLatitude : checkInLatitude // ignore: cast_nullable_to_non_nullable
as double?,checkInLongitude: freezed == checkInLongitude ? _self.checkInLongitude : checkInLongitude // ignore: cast_nullable_to_non_nullable
as double?,checkOutLatitude: freezed == checkOutLatitude ? _self.checkOutLatitude : checkOutLatitude // ignore: cast_nullable_to_non_nullable
as double?,checkOutLongitude: freezed == checkOutLongitude ? _self.checkOutLongitude : checkOutLongitude // ignore: cast_nullable_to_non_nullable
as double?,checkInDistanceMeters: freezed == checkInDistanceMeters ? _self.checkInDistanceMeters : checkInDistanceMeters // ignore: cast_nullable_to_non_nullable
as int?,checkOutDistanceMeters: freezed == checkOutDistanceMeters ? _self.checkOutDistanceMeters : checkOutDistanceMeters // ignore: cast_nullable_to_non_nullable
as int?,shift: freezed == shift ? _self.shift : shift // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Attendance].
extension AttendancePatterns on Attendance {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Attendance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Attendance() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Attendance value)  $default,){
final _that = this;
switch (_that) {
case _Attendance():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Attendance value)?  $default,){
final _that = this;
switch (_that) {
case _Attendance() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'tenant_id')  String tenantId, @JsonKey(name: 'worker_id')  String workerId, @JsonKey(name: 'project_id')  String projectId,  DateTime date, @JsonKey(name: 'check_in_at')  DateTime? checkInAt, @JsonKey(name: 'check_out_at')  DateTime? checkOutAt, @JsonKey(name: 'check_in_latitude')  double? checkInLatitude, @JsonKey(name: 'check_in_longitude')  double? checkInLongitude, @JsonKey(name: 'check_out_latitude')  double? checkOutLatitude, @JsonKey(name: 'check_out_longitude')  double? checkOutLongitude, @JsonKey(name: 'check_in_distance_meters')  int? checkInDistanceMeters, @JsonKey(name: 'check_out_distance_meters')  int? checkOutDistanceMeters,  String? shift,  String? note, @JsonKey(name: 'created_by')  String? createdBy, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Attendance() when $default != null:
return $default(_that.id,_that.tenantId,_that.workerId,_that.projectId,_that.date,_that.checkInAt,_that.checkOutAt,_that.checkInLatitude,_that.checkInLongitude,_that.checkOutLatitude,_that.checkOutLongitude,_that.checkInDistanceMeters,_that.checkOutDistanceMeters,_that.shift,_that.note,_that.createdBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'tenant_id')  String tenantId, @JsonKey(name: 'worker_id')  String workerId, @JsonKey(name: 'project_id')  String projectId,  DateTime date, @JsonKey(name: 'check_in_at')  DateTime? checkInAt, @JsonKey(name: 'check_out_at')  DateTime? checkOutAt, @JsonKey(name: 'check_in_latitude')  double? checkInLatitude, @JsonKey(name: 'check_in_longitude')  double? checkInLongitude, @JsonKey(name: 'check_out_latitude')  double? checkOutLatitude, @JsonKey(name: 'check_out_longitude')  double? checkOutLongitude, @JsonKey(name: 'check_in_distance_meters')  int? checkInDistanceMeters, @JsonKey(name: 'check_out_distance_meters')  int? checkOutDistanceMeters,  String? shift,  String? note, @JsonKey(name: 'created_by')  String? createdBy, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Attendance():
return $default(_that.id,_that.tenantId,_that.workerId,_that.projectId,_that.date,_that.checkInAt,_that.checkOutAt,_that.checkInLatitude,_that.checkInLongitude,_that.checkOutLatitude,_that.checkOutLongitude,_that.checkInDistanceMeters,_that.checkOutDistanceMeters,_that.shift,_that.note,_that.createdBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'tenant_id')  String tenantId, @JsonKey(name: 'worker_id')  String workerId, @JsonKey(name: 'project_id')  String projectId,  DateTime date, @JsonKey(name: 'check_in_at')  DateTime? checkInAt, @JsonKey(name: 'check_out_at')  DateTime? checkOutAt, @JsonKey(name: 'check_in_latitude')  double? checkInLatitude, @JsonKey(name: 'check_in_longitude')  double? checkInLongitude, @JsonKey(name: 'check_out_latitude')  double? checkOutLatitude, @JsonKey(name: 'check_out_longitude')  double? checkOutLongitude, @JsonKey(name: 'check_in_distance_meters')  int? checkInDistanceMeters, @JsonKey(name: 'check_out_distance_meters')  int? checkOutDistanceMeters,  String? shift,  String? note, @JsonKey(name: 'created_by')  String? createdBy, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Attendance() when $default != null:
return $default(_that.id,_that.tenantId,_that.workerId,_that.projectId,_that.date,_that.checkInAt,_that.checkOutAt,_that.checkInLatitude,_that.checkInLongitude,_that.checkOutLatitude,_that.checkOutLongitude,_that.checkInDistanceMeters,_that.checkOutDistanceMeters,_that.shift,_that.note,_that.createdBy,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Attendance implements Attendance {
  const _Attendance({required this.id, @JsonKey(name: 'tenant_id') required this.tenantId, @JsonKey(name: 'worker_id') required this.workerId, @JsonKey(name: 'project_id') required this.projectId, required this.date, @JsonKey(name: 'check_in_at') this.checkInAt, @JsonKey(name: 'check_out_at') this.checkOutAt, @JsonKey(name: 'check_in_latitude') this.checkInLatitude, @JsonKey(name: 'check_in_longitude') this.checkInLongitude, @JsonKey(name: 'check_out_latitude') this.checkOutLatitude, @JsonKey(name: 'check_out_longitude') this.checkOutLongitude, @JsonKey(name: 'check_in_distance_meters') this.checkInDistanceMeters, @JsonKey(name: 'check_out_distance_meters') this.checkOutDistanceMeters, this.shift, this.note, @JsonKey(name: 'created_by') this.createdBy, @JsonKey(name: 'created_at') required this.createdAt});
  factory _Attendance.fromJson(Map<String, dynamic> json) => _$AttendanceFromJson(json);

@override final  String id;
@override@JsonKey(name: 'tenant_id') final  String tenantId;
@override@JsonKey(name: 'worker_id') final  String workerId;
@override@JsonKey(name: 'project_id') final  String projectId;
@override final  DateTime date;
@override@JsonKey(name: 'check_in_at') final  DateTime? checkInAt;
@override@JsonKey(name: 'check_out_at') final  DateTime? checkOutAt;
@override@JsonKey(name: 'check_in_latitude') final  double? checkInLatitude;
@override@JsonKey(name: 'check_in_longitude') final  double? checkInLongitude;
@override@JsonKey(name: 'check_out_latitude') final  double? checkOutLatitude;
@override@JsonKey(name: 'check_out_longitude') final  double? checkOutLongitude;
@override@JsonKey(name: 'check_in_distance_meters') final  int? checkInDistanceMeters;
@override@JsonKey(name: 'check_out_distance_meters') final  int? checkOutDistanceMeters;
@override final  String? shift;
@override final  String? note;
@override@JsonKey(name: 'created_by') final  String? createdBy;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of Attendance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceCopyWith<_Attendance> get copyWith => __$AttendanceCopyWithImpl<_Attendance>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttendanceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Attendance&&(identical(other.id, id) || other.id == id)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.workerId, workerId) || other.workerId == workerId)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.date, date) || other.date == date)&&(identical(other.checkInAt, checkInAt) || other.checkInAt == checkInAt)&&(identical(other.checkOutAt, checkOutAt) || other.checkOutAt == checkOutAt)&&(identical(other.checkInLatitude, checkInLatitude) || other.checkInLatitude == checkInLatitude)&&(identical(other.checkInLongitude, checkInLongitude) || other.checkInLongitude == checkInLongitude)&&(identical(other.checkOutLatitude, checkOutLatitude) || other.checkOutLatitude == checkOutLatitude)&&(identical(other.checkOutLongitude, checkOutLongitude) || other.checkOutLongitude == checkOutLongitude)&&(identical(other.checkInDistanceMeters, checkInDistanceMeters) || other.checkInDistanceMeters == checkInDistanceMeters)&&(identical(other.checkOutDistanceMeters, checkOutDistanceMeters) || other.checkOutDistanceMeters == checkOutDistanceMeters)&&(identical(other.shift, shift) || other.shift == shift)&&(identical(other.note, note) || other.note == note)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tenantId,workerId,projectId,date,checkInAt,checkOutAt,checkInLatitude,checkInLongitude,checkOutLatitude,checkOutLongitude,checkInDistanceMeters,checkOutDistanceMeters,shift,note,createdBy,createdAt);

@override
String toString() {
  return 'Attendance(id: $id, tenantId: $tenantId, workerId: $workerId, projectId: $projectId, date: $date, checkInAt: $checkInAt, checkOutAt: $checkOutAt, checkInLatitude: $checkInLatitude, checkInLongitude: $checkInLongitude, checkOutLatitude: $checkOutLatitude, checkOutLongitude: $checkOutLongitude, checkInDistanceMeters: $checkInDistanceMeters, checkOutDistanceMeters: $checkOutDistanceMeters, shift: $shift, note: $note, createdBy: $createdBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AttendanceCopyWith<$Res> implements $AttendanceCopyWith<$Res> {
  factory _$AttendanceCopyWith(_Attendance value, $Res Function(_Attendance) _then) = __$AttendanceCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'tenant_id') String tenantId,@JsonKey(name: 'worker_id') String workerId,@JsonKey(name: 'project_id') String projectId, DateTime date,@JsonKey(name: 'check_in_at') DateTime? checkInAt,@JsonKey(name: 'check_out_at') DateTime? checkOutAt,@JsonKey(name: 'check_in_latitude') double? checkInLatitude,@JsonKey(name: 'check_in_longitude') double? checkInLongitude,@JsonKey(name: 'check_out_latitude') double? checkOutLatitude,@JsonKey(name: 'check_out_longitude') double? checkOutLongitude,@JsonKey(name: 'check_in_distance_meters') int? checkInDistanceMeters,@JsonKey(name: 'check_out_distance_meters') int? checkOutDistanceMeters, String? shift, String? note,@JsonKey(name: 'created_by') String? createdBy,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$AttendanceCopyWithImpl<$Res>
    implements _$AttendanceCopyWith<$Res> {
  __$AttendanceCopyWithImpl(this._self, this._then);

  final _Attendance _self;
  final $Res Function(_Attendance) _then;

/// Create a copy of Attendance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tenantId = null,Object? workerId = null,Object? projectId = null,Object? date = null,Object? checkInAt = freezed,Object? checkOutAt = freezed,Object? checkInLatitude = freezed,Object? checkInLongitude = freezed,Object? checkOutLatitude = freezed,Object? checkOutLongitude = freezed,Object? checkInDistanceMeters = freezed,Object? checkOutDistanceMeters = freezed,Object? shift = freezed,Object? note = freezed,Object? createdBy = freezed,Object? createdAt = null,}) {
  return _then(_Attendance(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,workerId: null == workerId ? _self.workerId : workerId // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,checkInAt: freezed == checkInAt ? _self.checkInAt : checkInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,checkOutAt: freezed == checkOutAt ? _self.checkOutAt : checkOutAt // ignore: cast_nullable_to_non_nullable
as DateTime?,checkInLatitude: freezed == checkInLatitude ? _self.checkInLatitude : checkInLatitude // ignore: cast_nullable_to_non_nullable
as double?,checkInLongitude: freezed == checkInLongitude ? _self.checkInLongitude : checkInLongitude // ignore: cast_nullable_to_non_nullable
as double?,checkOutLatitude: freezed == checkOutLatitude ? _self.checkOutLatitude : checkOutLatitude // ignore: cast_nullable_to_non_nullable
as double?,checkOutLongitude: freezed == checkOutLongitude ? _self.checkOutLongitude : checkOutLongitude // ignore: cast_nullable_to_non_nullable
as double?,checkInDistanceMeters: freezed == checkInDistanceMeters ? _self.checkInDistanceMeters : checkInDistanceMeters // ignore: cast_nullable_to_non_nullable
as int?,checkOutDistanceMeters: freezed == checkOutDistanceMeters ? _self.checkOutDistanceMeters : checkOutDistanceMeters // ignore: cast_nullable_to_non_nullable
as int?,shift: freezed == shift ? _self.shift : shift // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
