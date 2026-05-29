import 'package:freezed_annotation/freezed_annotation.dart';
import 'attendance_summary.dart';
import 'daily_summary.dart';

part 'worker_monthly_summary.freezed.dart';
part 'worker_monthly_summary.g.dart';

@freezed
abstract class WorkerMonthlySummary with _$WorkerMonthlySummary {
  const factory WorkerMonthlySummary({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'user_name') required String userName,
    required String month,
    @JsonKey(name: 'default_daily_rate') required int defaultDailyRate,
    required AttendanceSummary attendance,
    @JsonKey(name: 'total_earned') required int totalEarned,
    @JsonKey(name: 'total_advanced') required int totalAdvanced,
    @Default([]) List<DailySummary> days,
  }) = _WorkerMonthlySummary;

  factory WorkerMonthlySummary.fromJson(Map<String, dynamic> json) =>
      _$WorkerMonthlySummaryFromJson(json);
}