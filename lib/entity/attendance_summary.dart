import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_summary.freezed.dart';
part 'attendance_summary.g.dart';

@freezed
abstract class AttendanceSummary with _$AttendanceSummary {
  const factory AttendanceSummary({
    @JsonKey(name: 'full_days') @Default(0) int fullDays,
    @JsonKey(name: 'half_days') @Default(0) int halfDays,
    @JsonKey(name: 'absent_days') @Default(0) int absentDays,
    @JsonKey(name: 'total_shifts') @Default(0) int totalShifts,
  }) = _AttendanceSummary;

  factory AttendanceSummary.fromJson(Map<String, dynamic> json) =>
      _$AttendanceSummaryFromJson(json);
}
