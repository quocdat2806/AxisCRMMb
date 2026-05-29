// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Project {

 String get id;@JsonKey(name: 'tenant_id') String get tenantId; String get name; String? get location; double? get latitude; double? get longitude;@JsonKey(name: 'attendance_radius_meters') int? get attendanceRadiusMeters;@JsonKey(name: 'location_set_by') String? get locationSetBy;@JsonKey(name: 'location_set_at') DateTime? get locationSetAt;@JsonKey(name: 'location_accuracy_meters') int? get locationAccuracyMeters; String get status;@JsonKey(name: 'started_at') DateTime? get startedAt;@JsonKey(name: 'ended_at') DateTime? get endedAt;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectCopyWith<Project> get copyWith => _$ProjectCopyWithImpl<Project>(this as Project, _$identity);

  /// Serializes this Project to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Project&&(identical(other.id, id) || other.id == id)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.attendanceRadiusMeters, attendanceRadiusMeters) || other.attendanceRadiusMeters == attendanceRadiusMeters)&&(identical(other.locationSetBy, locationSetBy) || other.locationSetBy == locationSetBy)&&(identical(other.locationSetAt, locationSetAt) || other.locationSetAt == locationSetAt)&&(identical(other.locationAccuracyMeters, locationAccuracyMeters) || other.locationAccuracyMeters == locationAccuracyMeters)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tenantId,name,location,latitude,longitude,attendanceRadiusMeters,locationSetBy,locationSetAt,locationAccuracyMeters,status,startedAt,endedAt,createdAt);

@override
String toString() {
  return 'Project(id: $id, tenantId: $tenantId, name: $name, location: $location, latitude: $latitude, longitude: $longitude, attendanceRadiusMeters: $attendanceRadiusMeters, locationSetBy: $locationSetBy, locationSetAt: $locationSetAt, locationAccuracyMeters: $locationAccuracyMeters, status: $status, startedAt: $startedAt, endedAt: $endedAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ProjectCopyWith<$Res>  {
  factory $ProjectCopyWith(Project value, $Res Function(Project) _then) = _$ProjectCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'tenant_id') String tenantId, String name, String? location, double? latitude, double? longitude,@JsonKey(name: 'attendance_radius_meters') int? attendanceRadiusMeters,@JsonKey(name: 'location_set_by') String? locationSetBy,@JsonKey(name: 'location_set_at') DateTime? locationSetAt,@JsonKey(name: 'location_accuracy_meters') int? locationAccuracyMeters, String status,@JsonKey(name: 'started_at') DateTime? startedAt,@JsonKey(name: 'ended_at') DateTime? endedAt,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$ProjectCopyWithImpl<$Res>
    implements $ProjectCopyWith<$Res> {
  _$ProjectCopyWithImpl(this._self, this._then);

  final Project _self;
  final $Res Function(Project) _then;

/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tenantId = null,Object? name = null,Object? location = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? attendanceRadiusMeters = freezed,Object? locationSetBy = freezed,Object? locationSetAt = freezed,Object? locationAccuracyMeters = freezed,Object? status = null,Object? startedAt = freezed,Object? endedAt = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,attendanceRadiusMeters: freezed == attendanceRadiusMeters ? _self.attendanceRadiusMeters : attendanceRadiusMeters // ignore: cast_nullable_to_non_nullable
as int?,locationSetBy: freezed == locationSetBy ? _self.locationSetBy : locationSetBy // ignore: cast_nullable_to_non_nullable
as String?,locationSetAt: freezed == locationSetAt ? _self.locationSetAt : locationSetAt // ignore: cast_nullable_to_non_nullable
as DateTime?,locationAccuracyMeters: freezed == locationAccuracyMeters ? _self.locationAccuracyMeters : locationAccuracyMeters // ignore: cast_nullable_to_non_nullable
as int?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Project].
extension ProjectPatterns on Project {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Project value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Project() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Project value)  $default,){
final _that = this;
switch (_that) {
case _Project():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Project value)?  $default,){
final _that = this;
switch (_that) {
case _Project() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'tenant_id')  String tenantId,  String name,  String? location,  double? latitude,  double? longitude, @JsonKey(name: 'attendance_radius_meters')  int? attendanceRadiusMeters, @JsonKey(name: 'location_set_by')  String? locationSetBy, @JsonKey(name: 'location_set_at')  DateTime? locationSetAt, @JsonKey(name: 'location_accuracy_meters')  int? locationAccuracyMeters,  String status, @JsonKey(name: 'started_at')  DateTime? startedAt, @JsonKey(name: 'ended_at')  DateTime? endedAt, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Project() when $default != null:
return $default(_that.id,_that.tenantId,_that.name,_that.location,_that.latitude,_that.longitude,_that.attendanceRadiusMeters,_that.locationSetBy,_that.locationSetAt,_that.locationAccuracyMeters,_that.status,_that.startedAt,_that.endedAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'tenant_id')  String tenantId,  String name,  String? location,  double? latitude,  double? longitude, @JsonKey(name: 'attendance_radius_meters')  int? attendanceRadiusMeters, @JsonKey(name: 'location_set_by')  String? locationSetBy, @JsonKey(name: 'location_set_at')  DateTime? locationSetAt, @JsonKey(name: 'location_accuracy_meters')  int? locationAccuracyMeters,  String status, @JsonKey(name: 'started_at')  DateTime? startedAt, @JsonKey(name: 'ended_at')  DateTime? endedAt, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Project():
return $default(_that.id,_that.tenantId,_that.name,_that.location,_that.latitude,_that.longitude,_that.attendanceRadiusMeters,_that.locationSetBy,_that.locationSetAt,_that.locationAccuracyMeters,_that.status,_that.startedAt,_that.endedAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'tenant_id')  String tenantId,  String name,  String? location,  double? latitude,  double? longitude, @JsonKey(name: 'attendance_radius_meters')  int? attendanceRadiusMeters, @JsonKey(name: 'location_set_by')  String? locationSetBy, @JsonKey(name: 'location_set_at')  DateTime? locationSetAt, @JsonKey(name: 'location_accuracy_meters')  int? locationAccuracyMeters,  String status, @JsonKey(name: 'started_at')  DateTime? startedAt, @JsonKey(name: 'ended_at')  DateTime? endedAt, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Project() when $default != null:
return $default(_that.id,_that.tenantId,_that.name,_that.location,_that.latitude,_that.longitude,_that.attendanceRadiusMeters,_that.locationSetBy,_that.locationSetAt,_that.locationAccuracyMeters,_that.status,_that.startedAt,_that.endedAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Project implements Project {
  const _Project({required this.id, @JsonKey(name: 'tenant_id') required this.tenantId, required this.name, this.location, this.latitude, this.longitude, @JsonKey(name: 'attendance_radius_meters') this.attendanceRadiusMeters, @JsonKey(name: 'location_set_by') this.locationSetBy, @JsonKey(name: 'location_set_at') this.locationSetAt, @JsonKey(name: 'location_accuracy_meters') this.locationAccuracyMeters, required this.status, @JsonKey(name: 'started_at') this.startedAt, @JsonKey(name: 'ended_at') this.endedAt, @JsonKey(name: 'created_at') required this.createdAt});
  factory _Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

@override final  String id;
@override@JsonKey(name: 'tenant_id') final  String tenantId;
@override final  String name;
@override final  String? location;
@override final  double? latitude;
@override final  double? longitude;
@override@JsonKey(name: 'attendance_radius_meters') final  int? attendanceRadiusMeters;
@override@JsonKey(name: 'location_set_by') final  String? locationSetBy;
@override@JsonKey(name: 'location_set_at') final  DateTime? locationSetAt;
@override@JsonKey(name: 'location_accuracy_meters') final  int? locationAccuracyMeters;
@override final  String status;
@override@JsonKey(name: 'started_at') final  DateTime? startedAt;
@override@JsonKey(name: 'ended_at') final  DateTime? endedAt;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectCopyWith<_Project> get copyWith => __$ProjectCopyWithImpl<_Project>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Project&&(identical(other.id, id) || other.id == id)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.attendanceRadiusMeters, attendanceRadiusMeters) || other.attendanceRadiusMeters == attendanceRadiusMeters)&&(identical(other.locationSetBy, locationSetBy) || other.locationSetBy == locationSetBy)&&(identical(other.locationSetAt, locationSetAt) || other.locationSetAt == locationSetAt)&&(identical(other.locationAccuracyMeters, locationAccuracyMeters) || other.locationAccuracyMeters == locationAccuracyMeters)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tenantId,name,location,latitude,longitude,attendanceRadiusMeters,locationSetBy,locationSetAt,locationAccuracyMeters,status,startedAt,endedAt,createdAt);

@override
String toString() {
  return 'Project(id: $id, tenantId: $tenantId, name: $name, location: $location, latitude: $latitude, longitude: $longitude, attendanceRadiusMeters: $attendanceRadiusMeters, locationSetBy: $locationSetBy, locationSetAt: $locationSetAt, locationAccuracyMeters: $locationAccuracyMeters, status: $status, startedAt: $startedAt, endedAt: $endedAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ProjectCopyWith<$Res> implements $ProjectCopyWith<$Res> {
  factory _$ProjectCopyWith(_Project value, $Res Function(_Project) _then) = __$ProjectCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'tenant_id') String tenantId, String name, String? location, double? latitude, double? longitude,@JsonKey(name: 'attendance_radius_meters') int? attendanceRadiusMeters,@JsonKey(name: 'location_set_by') String? locationSetBy,@JsonKey(name: 'location_set_at') DateTime? locationSetAt,@JsonKey(name: 'location_accuracy_meters') int? locationAccuracyMeters, String status,@JsonKey(name: 'started_at') DateTime? startedAt,@JsonKey(name: 'ended_at') DateTime? endedAt,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$ProjectCopyWithImpl<$Res>
    implements _$ProjectCopyWith<$Res> {
  __$ProjectCopyWithImpl(this._self, this._then);

  final _Project _self;
  final $Res Function(_Project) _then;

/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tenantId = null,Object? name = null,Object? location = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? attendanceRadiusMeters = freezed,Object? locationSetBy = freezed,Object? locationSetAt = freezed,Object? locationAccuracyMeters = freezed,Object? status = null,Object? startedAt = freezed,Object? endedAt = freezed,Object? createdAt = null,}) {
  return _then(_Project(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,attendanceRadiusMeters: freezed == attendanceRadiusMeters ? _self.attendanceRadiusMeters : attendanceRadiusMeters // ignore: cast_nullable_to_non_nullable
as int?,locationSetBy: freezed == locationSetBy ? _self.locationSetBy : locationSetBy // ignore: cast_nullable_to_non_nullable
as String?,locationSetAt: freezed == locationSetAt ? _self.locationSetAt : locationSetAt // ignore: cast_nullable_to_non_nullable
as DateTime?,locationAccuracyMeters: freezed == locationAccuracyMeters ? _self.locationAccuracyMeters : locationAccuracyMeters // ignore: cast_nullable_to_non_nullable
as int?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
