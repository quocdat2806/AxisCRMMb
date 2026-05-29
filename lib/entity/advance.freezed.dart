// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'advance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Advance {

 String get id;@JsonKey(name: 'tenant_id') String get tenantId;@JsonKey(name: 'worker_id') String get workerId;@JsonKey(name: 'project_id') String get projectId; int get amount; DateTime get date; String? get note;@JsonKey(name: 'created_by') String? get createdBy;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of Advance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdvanceCopyWith<Advance> get copyWith => _$AdvanceCopyWithImpl<Advance>(this as Advance, _$identity);

  /// Serializes this Advance to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Advance&&(identical(other.id, id) || other.id == id)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.workerId, workerId) || other.workerId == workerId)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.date, date) || other.date == date)&&(identical(other.note, note) || other.note == note)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tenantId,workerId,projectId,amount,date,note,createdBy,createdAt);

@override
String toString() {
  return 'Advance(id: $id, tenantId: $tenantId, workerId: $workerId, projectId: $projectId, amount: $amount, date: $date, note: $note, createdBy: $createdBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AdvanceCopyWith<$Res>  {
  factory $AdvanceCopyWith(Advance value, $Res Function(Advance) _then) = _$AdvanceCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'tenant_id') String tenantId,@JsonKey(name: 'worker_id') String workerId,@JsonKey(name: 'project_id') String projectId, int amount, DateTime date, String? note,@JsonKey(name: 'created_by') String? createdBy,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$AdvanceCopyWithImpl<$Res>
    implements $AdvanceCopyWith<$Res> {
  _$AdvanceCopyWithImpl(this._self, this._then);

  final Advance _self;
  final $Res Function(Advance) _then;

/// Create a copy of Advance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tenantId = null,Object? workerId = null,Object? projectId = null,Object? amount = null,Object? date = null,Object? note = freezed,Object? createdBy = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,workerId: null == workerId ? _self.workerId : workerId // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Advance].
extension AdvancePatterns on Advance {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Advance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Advance() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Advance value)  $default,){
final _that = this;
switch (_that) {
case _Advance():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Advance value)?  $default,){
final _that = this;
switch (_that) {
case _Advance() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'tenant_id')  String tenantId, @JsonKey(name: 'worker_id')  String workerId, @JsonKey(name: 'project_id')  String projectId,  int amount,  DateTime date,  String? note, @JsonKey(name: 'created_by')  String? createdBy, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Advance() when $default != null:
return $default(_that.id,_that.tenantId,_that.workerId,_that.projectId,_that.amount,_that.date,_that.note,_that.createdBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'tenant_id')  String tenantId, @JsonKey(name: 'worker_id')  String workerId, @JsonKey(name: 'project_id')  String projectId,  int amount,  DateTime date,  String? note, @JsonKey(name: 'created_by')  String? createdBy, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Advance():
return $default(_that.id,_that.tenantId,_that.workerId,_that.projectId,_that.amount,_that.date,_that.note,_that.createdBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'tenant_id')  String tenantId, @JsonKey(name: 'worker_id')  String workerId, @JsonKey(name: 'project_id')  String projectId,  int amount,  DateTime date,  String? note, @JsonKey(name: 'created_by')  String? createdBy, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Advance() when $default != null:
return $default(_that.id,_that.tenantId,_that.workerId,_that.projectId,_that.amount,_that.date,_that.note,_that.createdBy,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Advance implements Advance {
  const _Advance({required this.id, @JsonKey(name: 'tenant_id') required this.tenantId, @JsonKey(name: 'worker_id') required this.workerId, @JsonKey(name: 'project_id') required this.projectId, required this.amount, required this.date, this.note, @JsonKey(name: 'created_by') this.createdBy, @JsonKey(name: 'created_at') required this.createdAt});
  factory _Advance.fromJson(Map<String, dynamic> json) => _$AdvanceFromJson(json);

@override final  String id;
@override@JsonKey(name: 'tenant_id') final  String tenantId;
@override@JsonKey(name: 'worker_id') final  String workerId;
@override@JsonKey(name: 'project_id') final  String projectId;
@override final  int amount;
@override final  DateTime date;
@override final  String? note;
@override@JsonKey(name: 'created_by') final  String? createdBy;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of Advance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdvanceCopyWith<_Advance> get copyWith => __$AdvanceCopyWithImpl<_Advance>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdvanceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Advance&&(identical(other.id, id) || other.id == id)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.workerId, workerId) || other.workerId == workerId)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.date, date) || other.date == date)&&(identical(other.note, note) || other.note == note)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tenantId,workerId,projectId,amount,date,note,createdBy,createdAt);

@override
String toString() {
  return 'Advance(id: $id, tenantId: $tenantId, workerId: $workerId, projectId: $projectId, amount: $amount, date: $date, note: $note, createdBy: $createdBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AdvanceCopyWith<$Res> implements $AdvanceCopyWith<$Res> {
  factory _$AdvanceCopyWith(_Advance value, $Res Function(_Advance) _then) = __$AdvanceCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'tenant_id') String tenantId,@JsonKey(name: 'worker_id') String workerId,@JsonKey(name: 'project_id') String projectId, int amount, DateTime date, String? note,@JsonKey(name: 'created_by') String? createdBy,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$AdvanceCopyWithImpl<$Res>
    implements _$AdvanceCopyWith<$Res> {
  __$AdvanceCopyWithImpl(this._self, this._then);

  final _Advance _self;
  final $Res Function(_Advance) _then;

/// Create a copy of Advance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tenantId = null,Object? workerId = null,Object? projectId = null,Object? amount = null,Object? date = null,Object? note = freezed,Object? createdBy = freezed,Object? createdAt = null,}) {
  return _then(_Advance(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,workerId: null == workerId ? _self.workerId : workerId // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
