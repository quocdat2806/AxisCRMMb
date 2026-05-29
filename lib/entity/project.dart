import 'package:freezed_annotation/freezed_annotation.dart';

part 'project.freezed.dart';
part 'project.g.dart';

@freezed
abstract class Project with _$Project {
  const factory Project({
    required String id,
    @JsonKey(name: 'tenant_id') required String tenantId,
    required String name,
    String? location,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'attendance_radius_meters') int? attendanceRadiusMeters,
    @JsonKey(name: 'location_set_by') String? locationSetBy,
    @JsonKey(name: 'location_set_at') DateTime? locationSetAt,
    @JsonKey(name: 'location_accuracy_meters') int? locationAccuracyMeters,
    required String status,
    @JsonKey(name: 'started_at') DateTime? startedAt,
    @JsonKey(name: 'ended_at') DateTime? endedAt,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
}
