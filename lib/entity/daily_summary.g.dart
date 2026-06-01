// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DailySummary _$DailySummaryFromJson(Map<String, dynamic> json) =>
    _DailySummary(
      date: DateTime.parse(json['date'] as String),
      shift: json['shift'] as String,
      shiftValue: (json['shift_value'] as num).toInt(),
      dailyRate: (json['daily_rate'] as num).toInt(),
      earned: (json['earned'] as num).toInt(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$DailySummaryToJson(_DailySummary instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'shift': instance.shift,
      'shift_value': instance.shiftValue,
      'daily_rate': instance.dailyRate,
      'earned': instance.earned,
      'status': instance.status,
    };
