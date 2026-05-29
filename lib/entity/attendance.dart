import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance.freezed.dart';
part 'attendance.g.dart';

@freezed
abstract class Attendance with _$Attendance {
  const factory Attendance({
    required String id,
    @JsonKey(name: 'tenant_id') required String tenantId,
    @JsonKey(name: 'worker_id') required String workerId,
    @JsonKey(name: 'project_id') required String projectId,
    required DateTime date,
    @JsonKey(name: 'check_in_at') DateTime? checkInAt,
    @JsonKey(name: 'check_out_at') DateTime? checkOutAt,
    @JsonKey(name: 'check_in_latitude') double? checkInLatitude,
    @JsonKey(name: 'check_in_longitude') double? checkInLongitude,
    @JsonKey(name: 'check_out_latitude') double? checkOutLatitude,
    @JsonKey(name: 'check_out_longitude') double? checkOutLongitude,
    @JsonKey(name: 'check_in_distance_meters') int? checkInDistanceMeters,
    @JsonKey(name: 'check_out_distance_meters') int? checkOutDistanceMeters,
    String? shift,
    String? note,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _Attendance;

  factory Attendance.fromJson(Map<String, dynamic> json) =>
      _$AttendanceFromJson(json);
}
