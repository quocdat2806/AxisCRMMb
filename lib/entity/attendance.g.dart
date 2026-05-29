// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Attendance _$AttendanceFromJson(Map<String, dynamic> json) => _Attendance(
  id: json['id'] as String,
  tenantId: json['tenant_id'] as String,
  workerId: json['worker_id'] as String,
  projectId: json['project_id'] as String,
  date: DateTime.parse(json['date'] as String),
  checkInAt: json['check_in_at'] == null
      ? null
      : DateTime.parse(json['check_in_at'] as String),
  checkOutAt: json['check_out_at'] == null
      ? null
      : DateTime.parse(json['check_out_at'] as String),
  checkInLatitude: (json['check_in_latitude'] as num?)?.toDouble(),
  checkInLongitude: (json['check_in_longitude'] as num?)?.toDouble(),
  checkOutLatitude: (json['check_out_latitude'] as num?)?.toDouble(),
  checkOutLongitude: (json['check_out_longitude'] as num?)?.toDouble(),
  checkInDistanceMeters: (json['check_in_distance_meters'] as num?)?.toInt(),
  checkOutDistanceMeters: (json['check_out_distance_meters'] as num?)?.toInt(),
  shift: json['shift'] as String?,
  note: json['note'] as String?,
  createdBy: json['created_by'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$AttendanceToJson(_Attendance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tenant_id': instance.tenantId,
      'worker_id': instance.workerId,
      'project_id': instance.projectId,
      'date': instance.date.toIso8601String(),
      'check_in_at': instance.checkInAt?.toIso8601String(),
      'check_out_at': instance.checkOutAt?.toIso8601String(),
      'check_in_latitude': instance.checkInLatitude,
      'check_in_longitude': instance.checkInLongitude,
      'check_out_latitude': instance.checkOutLatitude,
      'check_out_longitude': instance.checkOutLongitude,
      'check_in_distance_meters': instance.checkInDistanceMeters,
      'check_out_distance_meters': instance.checkOutDistanceMeters,
      'shift': instance.shift,
      'note': instance.note,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt.toIso8601String(),
    };
