// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker_monthly_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkerMonthlySummary _$WorkerMonthlySummaryFromJson(
  Map<String, dynamic> json,
) => _WorkerMonthlySummary(
  userId: json['user_id'] as String,
  userName: json['user_name'] as String,
  month: json['month'] as String,
  defaultDailyRate: (json['default_daily_rate'] as num).toInt(),
  attendance: AttendanceSummary.fromJson(
    json['attendance'] as Map<String, dynamic>,
  ),
  totalEarned: (json['total_earned'] as num).toInt(),
  totalAdvanced: (json['total_advanced'] as num).toInt(),
  days:
      (json['days'] as List<dynamic>?)
          ?.map((e) => DailySummary.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$WorkerMonthlySummaryToJson(
  _WorkerMonthlySummary instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'user_name': instance.userName,
  'month': instance.month,
  'default_daily_rate': instance.defaultDailyRate,
  'attendance': instance.attendance,
  'total_earned': instance.totalEarned,
  'total_advanced': instance.totalAdvanced,
  'days': instance.days,
};
