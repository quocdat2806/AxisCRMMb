import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_record.freezed.dart';
part 'attendance_record.g.dart';

@freezed
abstract class AttendanceRecord with _$AttendanceRecord {
  const factory AttendanceRecord({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required DateTime date,
    String? shift,
    @JsonKey(name: 'worker_shift') String? workerShift,
    @JsonKey(name: 'contractor_shift') String? contractorShift,
    @JsonKey(name: 'worker_note') String? workerNote,
    @JsonKey(name: 'contractor_note') String? contractorNote,
    @JsonKey(name: 'worker_submitted_at') DateTime? workerSubmittedAt,
    @JsonKey(name: 'contractor_submitted_at') DateTime? contractorSubmittedAt,
    required String status,
    @JsonKey(name: 'mismatch_checked_at') DateTime? mismatchCheckedAt,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _AttendanceRecord;

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) =>
      _$AttendanceRecordFromJson(json);
}