// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Leave {

 String get id;@JsonKey(name: 'tenant_id') String get tenantId;@JsonKey(name: 'worker_id') String get workerId;@JsonKey(name: 'project_id') String get projectId; DateTime get date; String? get reason;@JsonKey(name: 'created_by') String? get createdBy;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of Leave
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveCopyWith<Leave> get copyWith => _$LeaveCopyWithImpl<Leave>(this as Leave, _$identity);

  /// Serializes this Leave to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Leave&&(identical(other.id, id) || other.id == id)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.workerId, workerId) || other.workerId == workerId)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.date, date) || other.date == date)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tenantId,workerId,projectId,date,reason,createdBy,createdAt);

@override
String toString() {
  return 'Leave(id: $id, tenantId: $tenantId, workerId: $workerId, projectId: $projectId, date: $date, reason: $reason, createdBy: $createdBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $LeaveCopyWith<$Res>  {
  factory $LeaveCopyWith(Leave value, $Res Function(Leave) _then) = _$LeaveCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'tenant_id') String tenantId,@JsonKey(name: 'worker_id') String workerId,@JsonKey(name: 'project_id') String projectId, DateTime date, String? reason,@JsonKey(name: 'created_by') String? createdBy,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$LeaveCopyWithImpl<$Res>
    implements $LeaveCopyWith<$Res> {
  _$LeaveCopyWithImpl(this._self, this._then);

  final Leave _self;
  final $Res Function(Leave) _then;

/// Create a copy of Leave
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tenantId = null,Object? workerId = null,Object? projectId = null,Object? date = null,Object? reason = freezed,Object? createdBy = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,workerId: null == workerId ? _self.workerId : workerId // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Leave].
extension LeavePatterns on Leave {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Leave value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Leave() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Leave value)  $default,){
final _that = this;
switch (_that) {
case _Leave():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Leave value)?  $default,){
final _that = this;
switch (_that) {
case _Leave() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'tenant_id')  String tenantId, @JsonKey(name: 'worker_id')  String workerId, @JsonKey(name: 'project_id')  String projectId,  DateTime date,  String? reason, @JsonKey(name: 'created_by')  String? createdBy, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Leave() when $default != null:
return $default(_that.id,_that.tenantId,_that.workerId,_that.projectId,_that.date,_that.reason,_that.createdBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'tenant_id')  String tenantId, @JsonKey(name: 'worker_id')  String workerId, @JsonKey(name: 'project_id')  String projectId,  DateTime date,  String? reason, @JsonKey(name: 'created_by')  String? createdBy, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Leave():
return $default(_that.id,_that.tenantId,_that.workerId,_that.projectId,_that.date,_that.reason,_that.createdBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'tenant_id')  String tenantId, @JsonKey(name: 'worker_id')  String workerId, @JsonKey(name: 'project_id')  String projectId,  DateTime date,  String? reason, @JsonKey(name: 'created_by')  String? createdBy, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Leave() when $default != null:
return $default(_that.id,_that.tenantId,_that.workerId,_that.projectId,_that.date,_that.reason,_that.createdBy,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Leave implements Leave {
  const _Leave({required this.id, @JsonKey(name: 'tenant_id') required this.tenantId, @JsonKey(name: 'worker_id') required this.workerId, @JsonKey(name: 'project_id') required this.projectId, required this.date, this.reason, @JsonKey(name: 'created_by') this.createdBy, @JsonKey(name: 'created_at') required this.createdAt});
  factory _Leave.fromJson(Map<String, dynamic> json) => _$LeaveFromJson(json);

@override final  String id;
@override@JsonKey(name: 'tenant_id') final  String tenantId;
@override@JsonKey(name: 'worker_id') final  String workerId;
@override@JsonKey(name: 'project_id') final  String projectId;
@override final  DateTime date;
@override final  String? reason;
@override@JsonKey(name: 'created_by') final  String? createdBy;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of Leave
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveCopyWith<_Leave> get copyWith => __$LeaveCopyWithImpl<_Leave>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaveToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Leave&&(identical(other.id, id) || other.id == id)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.workerId, workerId) || other.workerId == workerId)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.date, date) || other.date == date)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tenantId,workerId,projectId,date,reason,createdBy,createdAt);

@override
String toString() {
  return 'Leave(id: $id, tenantId: $tenantId, workerId: $workerId, projectId: $projectId, date: $date, reason: $reason, createdBy: $createdBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$LeaveCopyWith<$Res> implements $LeaveCopyWith<$Res> {
  factory _$LeaveCopyWith(_Leave value, $Res Function(_Leave) _then) = __$LeaveCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'tenant_id') String tenantId,@JsonKey(name: 'worker_id') String workerId,@JsonKey(name: 'project_id') String projectId, DateTime date, String? reason,@JsonKey(name: 'created_by') String? createdBy,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$LeaveCopyWithImpl<$Res>
    implements _$LeaveCopyWith<$Res> {
  __$LeaveCopyWithImpl(this._self, this._then);

  final _Leave _self;
  final $Res Function(_Leave) _then;

/// Create a copy of Leave
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tenantId = null,Object? workerId = null,Object? projectId = null,Object? date = null,Object? reason = freezed,Object? createdBy = freezed,Object? createdAt = null,}) {
  return _then(_Leave(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,workerId: null == workerId ? _self.workerId : workerId // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
