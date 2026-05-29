// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DailySummary _$DailySummaryFromJson(Map<String, dynamic> json) =>
    _DailySummary(
      date: DateTime.parse(json['date'] as String),
      projectId: json['project_id'] as String?,
      projectName: json['project_name'] as String?,
      shift: json['shift'] as String,
      shiftValue: (json['shift_value'] as num).toInt(),
      dailyRate: (json['daily_rate'] as num).toInt(),
      earned: (json['earned'] as num).toInt(),
      checkInAt: json['check_in_at'] == null
          ? null
          : DateTime.parse(json['check_in_at'] as String),
      checkOutAt: json['check_out_at'] == null
          ? null
          : DateTime.parse(json['check_out_at'] as String),
    );

Map<String, dynamic> _$DailySummaryToJson(_DailySummary instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'project_id': instance.projectId,
      'project_name': instance.projectName,
      'shift': instance.shift,
      'shift_value': instance.shiftValue,
      'daily_rate': instance.dailyRate,
      'earned': instance.earned,
      'check_in_at': instance.checkInAt?.toIso8601String(),
      'check_out_at': instance.checkOutAt?.toIso8601String(),
    };
