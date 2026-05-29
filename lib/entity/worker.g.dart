// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Worker _$WorkerFromJson(Map<String, dynamic> json) => _Worker(
  id: json['id'] as String,
  tenantId: json['tenant_id'] as String,
  name: json['name'] as String,
  phone: json['phone'] as String,
  skill: json['skill'] as String,
  defaultDailyRate: (json['default_daily_rate'] as num).toInt(),
  note: json['note'] as String?,
  isActive: json['is_active'] as bool,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$WorkerToJson(_Worker instance) => <String, dynamic>{
  'id': instance.id,
  'tenant_id': instance.tenantId,
  'name': instance.name,
  'phone': instance.phone,
  'skill': instance.skill,
  'default_daily_rate': instance.defaultDailyRate,
  'note': instance.note,
  'is_active': instance.isActive,
  'created_at': instance.createdAt.toIso8601String(),
};
