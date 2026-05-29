// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttendanceSummary _$AttendanceSummaryFromJson(Map<String, dynamic> json) =>
    _AttendanceSummary(
      fullDays: (json['full_days'] as num?)?.toInt() ?? 0,
      halfDays: (json['half_days'] as num?)?.toInt() ?? 0,
      absentDays: (json['absent_days'] as num?)?.toInt() ?? 0,
      totalShifts: (json['total_shifts'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$AttendanceSummaryToJson(_AttendanceSummary instance) =>
    <String, dynamic>{
      'full_days': instance.fullDays,
      'half_days': instance.halfDays,
      'absent_days': instance.absentDays,
      'total_shifts': instance.totalShifts,
    };
