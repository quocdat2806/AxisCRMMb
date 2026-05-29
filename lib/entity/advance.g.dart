// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Advance _$AdvanceFromJson(Map<String, dynamic> json) => _Advance(
  id: json['id'] as String,
  tenantId: json['tenant_id'] as String,
  workerId: json['worker_id'] as String,
  projectId: json['project_id'] as String,
  amount: (json['amount'] as num).toInt(),
  date: DateTime.parse(json['date'] as String),
  note: json['note'] as String?,
  createdBy: json['created_by'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$AdvanceToJson(_Advance instance) => <String, dynamic>{
  'id': instance.id,
  'tenant_id': instance.tenantId,
  'worker_id': instance.workerId,
  'project_id': instance.projectId,
  'amount': instance.amount,
  'date': instance.date.toIso8601String(),
  'note': instance.note,
  'created_by': instance.createdBy,
  'created_at': instance.createdAt.toIso8601String(),
};
