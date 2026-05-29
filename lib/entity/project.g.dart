// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Project _$ProjectFromJson(Map<String, dynamic> json) => _Project(
  id: json['id'] as String,
  tenantId: json['tenant_id'] as String,
  name: json['name'] as String,
  location: json['location'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  attendanceRadiusMeters: (json['attendance_radius_meters'] as num?)?.toInt(),
  locationSetBy: json['location_set_by'] as String?,
  locationSetAt: json['location_set_at'] == null
      ? null
      : DateTime.parse(json['location_set_at'] as String),
  locationAccuracyMeters: (json['location_accuracy_meters'] as num?)?.toInt(),
  status: json['status'] as String,
  startedAt: json['started_at'] == null
      ? null
      : DateTime.parse(json['started_at'] as String),
  endedAt: json['ended_at'] == null
      ? null
      : DateTime.parse(json['ended_at'] as String),
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$ProjectToJson(_Project instance) => <String, dynamic>{
  'id': instance.id,
  'tenant_id': instance.tenantId,
  'name': instance.name,
  'location': instance.location,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'attendance_radius_meters': instance.attendanceRadiusMeters,
  'location_set_by': instance.locationSetBy,
  'location_set_at': instance.locationSetAt?.toIso8601String(),
  'location_accuracy_meters': instance.locationAccuracyMeters,
  'status': instance.status,
  'started_at': instance.startedAt?.toIso8601String(),
  'ended_at': instance.endedAt?.toIso8601String(),
  'created_at': instance.createdAt.toIso8601String(),
};
