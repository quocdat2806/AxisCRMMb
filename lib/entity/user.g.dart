// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: json['id'] as String,
  name: json['name'] as String,
  phone: json['phone'] as String,
  defaultDailyRate: (json['default_daily_rate'] as num?)?.toInt(),
  isActive: json['is_active'] as bool,
  isOwner: json['isOwner'] as bool,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'phone': instance.phone,
  'default_daily_rate': instance.defaultDailyRate,
  'is_active': instance.isActive,
  'isOwner': instance.isOwner,
  'created_at': instance.createdAt.toIso8601String(),
};
