import 'package:freezed_annotation/freezed_annotation.dart';

part 'eligibility.freezed.dart';
part 'eligibility.g.dart';

@freezed
abstract class Eligibility with _$Eligibility {
  const factory Eligibility({
    @JsonKey(name: 'can_check_in') required bool canCheckIn,
    @JsonKey(name: 'can_check_out') required bool canCheckOut,
    @JsonKey(name: 'distance_meters') required int distanceMeters,
    @JsonKey(name: 'radius_meters') required int radiusMeters,
    String? reason,
    @JsonKey(name: 'attendance_id') String? attendanceId,
  }) = _Eligibility;

  factory Eligibility.fromJson(Map<String, dynamic> json) =>
      _$EligibilityFromJson(json);
}
