// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AttendanceRecord {

 String get id;@JsonKey(name: 'user_id') String get userId; DateTime get date; String? get shift;@JsonKey(name: 'worker_shift') String? get workerShift;@JsonKey(name: 'contractor_shift') String? get contractorShift;@JsonKey(name: 'worker_note') String? get workerNote;@JsonKey(name: 'contractor_note') String? get contractorNote;@JsonKey(name: 'worker_submitted_at') DateTime? get workerSubmittedAt;@JsonKey(name: 'contractor_submitted_at') DateTime? get contractorSubmittedAt; String get status;@JsonKey(name: 'mismatch_checked_at') DateTime? get mismatchCheckedAt;@JsonKey(name: 'created_by') String? get createdBy;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of AttendanceRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceRecordCopyWith<AttendanceRecord> get copyWith => _$AttendanceRecordCopyWithImpl<AttendanceRecord>(this as AttendanceRecord, _$identity);

  /// Serializes this AttendanceRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.date, date) || other.date == date)&&(identical(other.shift, shift) || other.shift == shift)&&(identical(other.workerShift, workerShift) || other.workerShift == workerShift)&&(identical(other.contractorShift, contractorShift) || other.contractorShift == contractorShift)&&(identical(other.workerNote, workerNote) || other.workerNote == workerNote)&&(identical(other.contractorNote, contractorNote) || other.contractorNote == contractorNote)&&(identical(other.workerSubmittedAt, workerSubmittedAt) || other.workerSubmittedAt == workerSubmittedAt)&&(identical(other.contractorSubmittedAt, contractorSubmittedAt) || other.contractorSubmittedAt == contractorSubmittedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.mismatchCheckedAt, mismatchCheckedAt) || other.mismatchCheckedAt == mismatchCheckedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,date,shift,workerShift,contractorShift,workerNote,contractorNote,workerSubmittedAt,contractorSubmittedAt,status,mismatchCheckedAt,createdBy,createdAt,updatedAt);

@override
String toString() {
  return 'AttendanceRecord(id: $id, userId: $userId, date: $date, shift: $shift, workerShift: $workerShift, contractorShift: $contractorShift, workerNote: $workerNote, contractorNote: $contractorNote, workerSubmittedAt: $workerSubmittedAt, contractorSubmittedAt: $contractorSubmittedAt, status: $status, mismatchCheckedAt: $mismatchCheckedAt, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $AttendanceRecordCopyWith<$Res>  {
  factory $AttendanceRecordCopyWith(AttendanceRecord value, $Res Function(AttendanceRecord) _then) = _$AttendanceRecordCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, DateTime date, String? shift,@JsonKey(name: 'worker_shift') String? workerShift,@JsonKey(name: 'contractor_shift') String? contractorShift,@JsonKey(name: 'worker_note') String? workerNote,@JsonKey(name: 'contractor_note') String? contractorNote,@JsonKey(name: 'worker_submitted_at') DateTime? workerSubmittedAt,@JsonKey(name: 'contractor_submitted_at') DateTime? contractorSubmittedAt, String status,@JsonKey(name: 'mismatch_checked_at') DateTime? mismatchCheckedAt,@JsonKey(name: 'created_by') String? createdBy,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$AttendanceRecordCopyWithImpl<$Res>
    implements $AttendanceRecordCopyWith<$Res> {
  _$AttendanceRecordCopyWithImpl(this._self, this._then);

  final AttendanceRecord _self;
  final $Res Function(AttendanceRecord) _then;

/// Create a copy of AttendanceRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? date = null,Object? shift = freezed,Object? workerShift = freezed,Object? contractorShift = freezed,Object? workerNote = freezed,Object? contractorNote = freezed,Object? workerSubmittedAt = freezed,Object? contractorSubmittedAt = freezed,Object? status = null,Object? mismatchCheckedAt = freezed,Object? createdBy = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,shift: freezed == shift ? _self.shift : shift // ignore: cast_nullable_to_non_nullable
as String?,workerShift: freezed == workerShift ? _self.workerShift : workerShift // ignore: cast_nullable_to_non_nullable
as String?,contractorShift: freezed == contractorShift ? _self.contractorShift : contractorShift // ignore: cast_nullable_to_non_nullable
as String?,workerNote: freezed == workerNote ? _self.workerNote : workerNote // ignore: cast_nullable_to_non_nullable
as String?,contractorNote: freezed == contractorNote ? _self.contractorNote : contractorNote // ignore: cast_nullable_to_non_nullable
as String?,workerSubmittedAt: freezed == workerSubmittedAt ? _self.workerSubmittedAt : workerSubmittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,contractorSubmittedAt: freezed == contractorSubmittedAt ? _self.contractorSubmittedAt : contractorSubmittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,mismatchCheckedAt: freezed == mismatchCheckedAt ? _self.mismatchCheckedAt : mismatchCheckedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceRecord].
extension AttendanceRecordPatterns on AttendanceRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceRecord value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceRecord value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  DateTime date,  String? shift, @JsonKey(name: 'worker_shift')  String? workerShift, @JsonKey(name: 'contractor_shift')  String? contractorShift, @JsonKey(name: 'worker_note')  String? workerNote, @JsonKey(name: 'contractor_note')  String? contractorNote, @JsonKey(name: 'worker_submitted_at')  DateTime? workerSubmittedAt, @JsonKey(name: 'contractor_submitted_at')  DateTime? contractorSubmittedAt,  String status, @JsonKey(name: 'mismatch_checked_at')  DateTime? mismatchCheckedAt, @JsonKey(name: 'created_by')  String? createdBy, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceRecord() when $default != null:
return $default(_that.id,_that.userId,_that.date,_that.shift,_that.workerShift,_that.contractorShift,_that.workerNote,_that.contractorNote,_that.workerSubmittedAt,_that.contractorSubmittedAt,_that.status,_that.mismatchCheckedAt,_that.createdBy,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  DateTime date,  String? shift, @JsonKey(name: 'worker_shift')  String? workerShift, @JsonKey(name: 'contractor_shift')  String? contractorShift, @JsonKey(name: 'worker_note')  String? workerNote, @JsonKey(name: 'contractor_note')  String? contractorNote, @JsonKey(name: 'worker_submitted_at')  DateTime? workerSubmittedAt, @JsonKey(name: 'contractor_submitted_at')  DateTime? contractorSubmittedAt,  String status, @JsonKey(name: 'mismatch_checked_at')  DateTime? mismatchCheckedAt, @JsonKey(name: 'created_by')  String? createdBy, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _AttendanceRecord():
return $default(_that.id,_that.userId,_that.date,_that.shift,_that.workerShift,_that.contractorShift,_that.workerNote,_that.contractorNote,_that.workerSubmittedAt,_that.contractorSubmittedAt,_that.status,_that.mismatchCheckedAt,_that.createdBy,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId,  DateTime date,  String? shift, @JsonKey(name: 'worker_shift')  String? workerShift, @JsonKey(name: 'contractor_shift')  String? contractorShift, @JsonKey(name: 'worker_note')  String? workerNote, @JsonKey(name: 'contractor_note')  String? contractorNote, @JsonKey(name: 'worker_submitted_at')  DateTime? workerSubmittedAt, @JsonKey(name: 'contractor_submitted_at')  DateTime? contractorSubmittedAt,  String status, @JsonKey(name: 'mismatch_checked_at')  DateTime? mismatchCheckedAt, @JsonKey(name: 'created_by')  String? createdBy, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceRecord() when $default != null:
return $default(_that.id,_that.userId,_that.date,_that.shift,_that.workerShift,_that.contractorShift,_that.workerNote,_that.contractorNote,_that.workerSubmittedAt,_that.contractorSubmittedAt,_that.status,_that.mismatchCheckedAt,_that.createdBy,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttendanceRecord implements AttendanceRecord {
  const _AttendanceRecord({required this.id, @JsonKey(name: 'user_id') required this.userId, required this.date, this.shift, @JsonKey(name: 'worker_shift') this.workerShift, @JsonKey(name: 'contractor_shift') this.contractorShift, @JsonKey(name: 'worker_note') this.workerNote, @JsonKey(name: 'contractor_note') this.contractorNote, @JsonKey(name: 'worker_submitted_at') this.workerSubmittedAt, @JsonKey(name: 'contractor_submitted_at') this.contractorSubmittedAt, required this.status, @JsonKey(name: 'mismatch_checked_at') this.mismatchCheckedAt, @JsonKey(name: 'created_by') this.createdBy, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt});
  factory _AttendanceRecord.fromJson(Map<String, dynamic> json) => _$AttendanceRecordFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override final  DateTime date;
@override final  String? shift;
@override@JsonKey(name: 'worker_shift') final  String? workerShift;
@override@JsonKey(name: 'contractor_shift') final  String? contractorShift;
@override@JsonKey(name: 'worker_note') final  String? workerNote;
@override@JsonKey(name: 'contractor_note') final  String? contractorNote;
@override@JsonKey(name: 'worker_submitted_at') final  DateTime? workerSubmittedAt;
@override@JsonKey(name: 'contractor_submitted_at') final  DateTime? contractorSubmittedAt;
@override final  String status;
@override@JsonKey(name: 'mismatch_checked_at') final  DateTime? mismatchCheckedAt;
@override@JsonKey(name: 'created_by') final  String? createdBy;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of AttendanceRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceRecordCopyWith<_AttendanceRecord> get copyWith => __$AttendanceRecordCopyWithImpl<_AttendanceRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttendanceRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.date, date) || other.date == date)&&(identical(other.shift, shift) || other.shift == shift)&&(identical(other.workerShift, workerShift) || other.workerShift == workerShift)&&(identical(other.contractorShift, contractorShift) || other.contractorShift == contractorShift)&&(identical(other.workerNote, workerNote) || other.workerNote == workerNote)&&(identical(other.contractorNote, contractorNote) || other.contractorNote == contractorNote)&&(identical(other.workerSubmittedAt, workerSubmittedAt) || other.workerSubmittedAt == workerSubmittedAt)&&(identical(other.contractorSubmittedAt, contractorSubmittedAt) || other.contractorSubmittedAt == contractorSubmittedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.mismatchCheckedAt, mismatchCheckedAt) || other.mismatchCheckedAt == mismatchCheckedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,date,shift,workerShift,contractorShift,workerNote,contractorNote,workerSubmittedAt,contractorSubmittedAt,status,mismatchCheckedAt,createdBy,createdAt,updatedAt);

@override
String toString() {
  return 'AttendanceRecord(id: $id, userId: $userId, date: $date, shift: $shift, workerShift: $workerShift, contractorShift: $contractorShift, workerNote: $workerNote, contractorNote: $contractorNote, workerSubmittedAt: $workerSubmittedAt, contractorSubmittedAt: $contractorSubmittedAt, status: $status, mismatchCheckedAt: $mismatchCheckedAt, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$AttendanceRecordCopyWith<$Res> implements $AttendanceRecordCopyWith<$Res> {
  factory _$AttendanceRecordCopyWith(_AttendanceRecord value, $Res Function(_AttendanceRecord) _then) = __$AttendanceRecordCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, DateTime date, String? shift,@JsonKey(name: 'worker_shift') String? workerShift,@JsonKey(name: 'contractor_shift') String? contractorShift,@JsonKey(name: 'worker_note') String? workerNote,@JsonKey(name: 'contractor_note') String? contractorNote,@JsonKey(name: 'worker_submitted_at') DateTime? workerSubmittedAt,@JsonKey(name: 'contractor_submitted_at') DateTime? contractorSubmittedAt, String status,@JsonKey(name: 'mismatch_checked_at') DateTime? mismatchCheckedAt,@JsonKey(name: 'created_by') String? createdBy,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$AttendanceRecordCopyWithImpl<$Res>
    implements _$AttendanceRecordCopyWith<$Res> {
  __$AttendanceRecordCopyWithImpl(this._self, this._then);

  final _AttendanceRecord _self;
  final $Res Function(_AttendanceRecord) _then;

/// Create a copy of AttendanceRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? date = null,Object? shift = freezed,Object? workerShift = freezed,Object? contractorShift = freezed,Object? workerNote = freezed,Object? contractorNote = freezed,Object? workerSubmittedAt = freezed,Object? contractorSubmittedAt = freezed,Object? status = null,Object? mismatchCheckedAt = freezed,Object? createdBy = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_AttendanceRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,shift: freezed == shift ? _self.shift : shift // ignore: cast_nullable_to_non_nullable
as String?,workerShift: freezed == workerShift ? _self.workerShift : workerShift // ignore: cast_nullable_to_non_nullable
as String?,contractorShift: freezed == contractorShift ? _self.contractorShift : contractorShift // ignore: cast_nullable_to_non_nullable
as String?,workerNote: freezed == workerNote ? _self.workerNote : workerNote // ignore: cast_nullable_to_non_nullable
as String?,contractorNote: freezed == contractorNote ? _self.contractorNote : contractorNote // ignore: cast_nullable_to_non_nullable
as String?,workerSubmittedAt: freezed == workerSubmittedAt ? _self.workerSubmittedAt : workerSubmittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,contractorSubmittedAt: freezed == contractorSubmittedAt ? _self.contractorSubmittedAt : contractorSubmittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,mismatchCheckedAt: freezed == mismatchCheckedAt ? _self.mismatchCheckedAt : mismatchCheckedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
