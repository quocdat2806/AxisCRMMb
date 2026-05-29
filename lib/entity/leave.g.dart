// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Leave _$LeaveFromJson(Map<String, dynamic> json) => _Leave(
  id: json['id'] as String,
  tenantId: json['tenant_id'] as String,
  workerId: json['worker_id'] as String,
  projectId: json['project_id'] as String,
  date: DateTime.parse(json['date'] as String),
  reason: json['reason'] as String?,
  createdBy: json['created_by'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$LeaveToJson(_Leave instance) => <String, dynamic>{
  'id': instance.id,
  'tenant_id': instance.tenantId,
  'worker_id': instance.workerId,
  'project_id': instance.projectId,
  'date': instance.date.toIso8601String(),
  'reason': instance.reason,
  'created_by': instance.createdBy,
  'created_at': instance.createdAt.toIso8601String(),
};
