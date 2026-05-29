import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_summary.freezed.dart';
part 'daily_summary.g.dart';

@freezed
abstract class DailySummary with _$DailySummary {
  const factory DailySummary({
    required DateTime date,
    @JsonKey(name: 'project_id') String? projectId,
    @JsonKey(name: 'project_name') String? projectName,
    required String shift,
    @JsonKey(name: 'shift_value') required int shiftValue,
    @JsonKey(name: 'daily_rate') required int dailyRate,
    required int earned,
    @JsonKey(name: 'check_in_at') DateTime? checkInAt,
    @JsonKey(name: 'check_out_at') DateTime? checkOutAt,
  }) = _DailySummary;

  factory DailySummary.fromJson(Map<String, dynamic> json) =>
      _$DailySummaryFromJson(json);
}