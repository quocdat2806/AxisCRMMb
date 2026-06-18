// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttendanceRecord _$AttendanceRecordFromJson(Map<String, dynamic> json) =>
    _AttendanceRecord(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      date: DateTime.parse(json['date'] as String),
      shift: json['shift'] as String?,
      workerShift: json['worker_shift'] as String?,
      contractorShift: json['contractor_shift'] as String?,
      workerNote: json['worker_note'] as String?,
      contractorNote: json['contractor_note'] as String?,
      workerSubmittedAt: json['worker_submitted_at'] == null
          ? null
          : DateTime.parse(json['worker_submitted_at'] as String),
      contractorSubmittedAt: json['contractor_submitted_at'] == null
          ? null
          : DateTime.parse(json['contractor_submitted_at'] as String),
      status: json['status'] as String,
      mismatchCheckedAt: json['mismatch_checked_at'] == null
          ? null
          : DateTime.parse(json['mismatch_checked_at'] as String),
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$AttendanceRecordToJson(
  _AttendanceRecord instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'date': instance.date.toIso8601String(),
  'shift': instance.shift,
  'worker_shift': instance.workerShift,
  'contractor_shift': instance.contractorShift,
  'worker_note': instance.workerNote,
  'contractor_note': instance.contractorNote,
  'worker_submitted_at': instance.workerSubmittedAt?.toIso8601String(),
  'contractor_submitted_at': instance.contractorSubmittedAt?.toIso8601String(),
  'status': instance.status,
  'mismatch_checked_at': instance.mismatchCheckedAt?.toIso8601String(),
  'created_by': instance.createdBy,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};
