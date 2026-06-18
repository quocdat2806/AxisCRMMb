import 'package:json_annotation/json_annotation.dart';
import 'package:axis_crm/entity/user.dart';
import 'package:axis_crm/entity/project.dart';
import 'package:axis_crm/entity/attendance_record.dart';

part 'api_client_dto.g.dart';

@JsonSerializable()
class LoginRequest {
  final String phone;
  final String? name;

  LoginRequest({required this.phone, this.name});

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class CreateProjectRequest {
  final String name;
  @JsonKey(name: 'started_at')
  final String? startedAt;

  CreateProjectRequest({required this.name, this.startedAt});

  factory CreateProjectRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateProjectRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateProjectRequestToJson(this);
}

@JsonSerializable()
class CreateWorkerAdvanceResponse {
  final bool success;
  final String? message;
  final Map<String, dynamic>? advance;
  CreateWorkerAdvanceResponse({
    required this.success,
    this.message,
    this.advance,
  });
  factory CreateWorkerAdvanceResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkerAdvanceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CreateWorkerAdvanceResponseToJson(this);
}

@JsonSerializable()
class CreateProjectAdvanceRequest {
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'project_id')
  final String projectId;
  final double amount;
  final String date;
  final String? note;

  CreateProjectAdvanceRequest({
    required this.userId,
    required this.projectId,
    required this.amount,
    required this.date,
    this.note,
  });

  factory CreateProjectAdvanceRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateProjectAdvanceRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateProjectAdvanceRequestToJson(this);
}

@JsonSerializable()
class CreateProjectAdvanceResponse {
  final bool success;
  final String? message;
  final Map<String, dynamic>? advance;
  CreateProjectAdvanceResponse({required this.success, this.message, this.advance});
  factory CreateProjectAdvanceResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateProjectAdvanceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CreateProjectAdvanceResponseToJson(this);
}

@JsonSerializable()
class CreateAttendanceRequest {
  final String date;
  final String shift;
  final String? note;

  CreateAttendanceRequest({required this.date, required this.shift, this.note});

  factory CreateAttendanceRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateAttendanceRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateAttendanceRequestToJson(this);
}

// Response wrappers
@JsonSerializable()
class UsersListResponse {
  final List<User> data;
  final Pagination pagination;
  UsersListResponse({required this.data, required this.pagination});
  factory UsersListResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UsersListResponseToJson(this);
}

@JsonSerializable()
class Pagination {
  final int page;
  @JsonKey(name: 'page_size')
  final int pageSize;
  final int total;
  Pagination({required this.page, required this.pageSize, required this.total});
  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}

@JsonSerializable()
class ProjectsListResponse {
  final List<Project> data;
  final Pagination pagination;
  ProjectsListResponse({required this.data, required this.pagination});
  factory ProjectsListResponse.fromJson(Map<String, dynamic> json) =>
      _$ProjectsListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectsListResponseToJson(this);
}

@JsonSerializable()
class ProjectDetailResponse {
  final Project project;
  ProjectDetailResponse({required this.project});
  factory ProjectDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ProjectDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectDetailResponseToJson(this);
}

@JsonSerializable()
class AttendanceRecordListResponse {
  final List<AttendanceRecord> data;
  final Pagination pagination;
  AttendanceRecordListResponse({required this.data, required this.pagination});
  factory AttendanceRecordListResponse.fromJson(Map<String, dynamic> json) =>
      _$AttendanceRecordListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AttendanceRecordListResponseToJson(this);
}

@JsonSerializable()
class AdminCreateAttendanceResponse {
  final bool success;
  final String? message;
  final Map<String, dynamic>? attendance;
  AdminCreateAttendanceResponse({
    required this.success,
    this.message,
    this.attendance,
  });
  factory AdminCreateAttendanceResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateAttendanceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AdminCreateAttendanceResponseToJson(this);
}

@JsonSerializable()
class CreateAttendanceResponse {
  final bool success;
  final String? message;
  CreateAttendanceResponse({required this.success, this.message});
  factory CreateAttendanceResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateAttendanceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CreateAttendanceResponseToJson(this);
}

@JsonSerializable()
class WorkerAdvancesListResponse {
  final List<WorkerAdvanceItem> data;
  final Pagination pagination;
  WorkerAdvancesListResponse({required this.data, required this.pagination});
  factory WorkerAdvancesListResponse.fromJson(Map<String, dynamic> json) =>
      _$WorkerAdvancesListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WorkerAdvancesListResponseToJson(this);
}

@JsonSerializable()
class AdminCreateWorkerAdvanceResponse {
  final bool success;
  final String? message;
  final Map<String, dynamic>? advance;
  AdminCreateWorkerAdvanceResponse({
    required this.success,
    this.message,
    this.advance,
  });
  factory AdminCreateWorkerAdvanceResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminCreateWorkerAdvanceResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AdminCreateWorkerAdvanceResponseToJson(this);
}

@JsonSerializable()
class WorkerAdvanceItem {
  final String id;
  @JsonKey(name: 'user_id')
  final String userId;
  final String date;
  final int? amount;
  @JsonKey(name: 'worker_amount')
  final int? workerAmount;
  @JsonKey(name: 'contractor_amount')
  final int? contractorAmount;
  final String status;
  @JsonKey(name: 'worker_note')
  final String? workerNote;
  @JsonKey(name: 'contractor_note')
  final String? contractorNote;
  @JsonKey(name: 'worker_submitted_at')
  final String? workerSubmittedAt;
  @JsonKey(name: 'contractor_submitted_at')
  final String? contractorSubmittedAt;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  WorkerAdvanceItem({
    required this.id,
    required this.userId,
    required this.date,
    this.amount,
    this.workerAmount,
    this.contractorAmount,
    required this.status,
    this.workerNote,
    this.contractorNote,
    this.workerSubmittedAt,
    this.contractorSubmittedAt,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WorkerAdvanceItem.fromJson(Map<String, dynamic> json) =>
      _$WorkerAdvanceItemFromJson(json);
  Map<String, dynamic> toJson() => _$WorkerAdvanceItemToJson(this);
}

@JsonSerializable()
class UserUpdateResponse {
  final bool success;
  final String? message;
  final User? user;

  UserUpdateResponse({required this.success, this.message, this.user});

  factory UserUpdateResponse.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserUpdateResponseToJson(this);
}

@JsonSerializable()
class ProjectAdvanceItem {
  final String id;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'project_id')
  final String projectId;
  final double? amount;
  @JsonKey(name: 'worker_amount')
  final double? workerAmount;
  @JsonKey(name: 'contractor_amount')
  final double? contractorAmount;
  final String? status;
  final String date;
  @JsonKey(name: 'worker_note')
  final String? workerNote;
  @JsonKey(name: 'contractor_note')
  final String? contractorNote;
  final String? note;
  @JsonKey(name: 'worker_submitted_at')
  final String? workerSubmittedAt;
  @JsonKey(name: 'contractor_submitted_at')
  final String? contractorSubmittedAt;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  final User? user;

  ProjectAdvanceItem({
    required this.id,
    required this.userId,
    required this.projectId,
    this.amount,
    this.workerAmount,
    this.contractorAmount,
    this.status,
    required this.date,
    this.workerNote,
    this.contractorNote,
    this.note,
    this.workerSubmittedAt,
    this.contractorSubmittedAt,
    this.createdBy,
    required this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory ProjectAdvanceItem.fromJson(Map<String, dynamic> json) =>
      _$ProjectAdvanceItemFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectAdvanceItemToJson(this);
}

@JsonSerializable()
class ProjectAdvancesListResponse {
  final List<ProjectAdvanceItem> data;
  final Pagination pagination;
  ProjectAdvancesListResponse({required this.data, required this.pagination});
  factory ProjectAdvancesListResponse.fromJson(Map<String, dynamic> json) =>
      _$ProjectAdvancesListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectAdvancesListResponseToJson(this);
}

@JsonSerializable()
class ReconcileAttendanceItem {
  final String date;
  final String? shift;
  final String? note;

  ReconcileAttendanceItem({
    required this.date,
    this.shift,
    this.note,
  });

  factory ReconcileAttendanceItem.fromJson(Map<String, dynamic> json) =>
      _$ReconcileAttendanceItemFromJson(json);
  Map<String, dynamic> toJson() => _$ReconcileAttendanceItemToJson(this);
}

@JsonSerializable()
class ReconcileResponse {
  final bool success;
  @JsonKey(name: 'mismatch_dates')
  final List<String> mismatchDates;
  @JsonKey(name: 'worker_attendance')
  final List<ReconcileAttendanceItem> workerAttendance;
  @JsonKey(name: 'contractor_attendance')
  final List<ReconcileAttendanceItem> contractorAttendance;

  ReconcileResponse({
    required this.success,
    required this.mismatchDates,
    required this.workerAttendance,
    required this.contractorAttendance,
  });

  factory ReconcileResponse.fromJson(Map<String, dynamic> json) =>
      _$ReconcileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ReconcileResponseToJson(this);
}

@JsonSerializable()
class YearlySummarySide {
  @JsonKey(name: 'total_full_days')
  final int totalFullDays;
  @JsonKey(name: 'total_half_days')
  final int totalHalfDays;
  @JsonKey(name: 'total_absent_days')
  final int totalAbsentDays;
  @JsonKey(name: 'total_work_days')
  final double totalWorkDays;
  @JsonKey(name: 'total_advance_amount')
  final double totalAdvanceAmount;

  YearlySummarySide({
    required this.totalFullDays,
    required this.totalHalfDays,
    required this.totalAbsentDays,
    required this.totalWorkDays,
    required this.totalAdvanceAmount,
  });

  factory YearlySummarySide.fromJson(Map<String, dynamic> json) =>
      _$YearlySummarySideFromJson(json);
  Map<String, dynamic> toJson() => _$YearlySummarySideToJson(this);
}

@JsonSerializable()
class YearlySummaryData {
  final int year;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'worker_side')
  final YearlySummarySide workerSide;
  @JsonKey(name: 'contractor_side')
  final YearlySummarySide contractorSide;

  YearlySummaryData({
    required this.year,
    required this.userId,
    required this.workerSide,
    required this.contractorSide,
  });

  factory YearlySummaryData.fromJson(Map<String, dynamic> json) =>
      _$YearlySummaryDataFromJson(json);
  Map<String, dynamic> toJson() => _$YearlySummaryDataToJson(this);
}

@JsonSerializable()
class YearlySummaryResponse {
  final bool success;
  final YearlySummaryData summary;

  YearlySummaryResponse({
    required this.success,
    required this.summary,
  });

  factory YearlySummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$YearlySummaryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$YearlySummaryResponseToJson(this);
}

@JsonSerializable()
class AttendanceMismatchItem {
  final String date;
  @JsonKey(name: 'worker_shift')
  final String? workerShift;
  @JsonKey(name: 'contractor_shift')
  final String? contractorShift;
  @JsonKey(name: 'worker_note')
  final String? workerNote;
  @JsonKey(name: 'contractor_note')
  final String? contractorNote;

  AttendanceMismatchItem({
    required this.date,
    this.workerShift,
    this.contractorShift,
    this.workerNote,
    this.contractorNote,
  });

  factory AttendanceMismatchItem.fromJson(Map<String, dynamic> json) =>
      _$AttendanceMismatchItemFromJson(json);
  Map<String, dynamic> toJson() => _$AttendanceMismatchItemToJson(this);
}

@JsonSerializable()
class AdvanceMismatchItem {
  final String date;
  @JsonKey(name: 'worker_amount')
  final double? workerAmount;
  @JsonKey(name: 'contractor_amount')
  final double? contractorAmount;
  @JsonKey(name: 'worker_note')
  final String? workerNote;
  @JsonKey(name: 'contractor_note')
  final String? contractorNote;

  AdvanceMismatchItem({
    required this.date,
    this.workerAmount,
    this.contractorAmount,
    this.workerNote,
    this.contractorNote,
  });

  factory AdvanceMismatchItem.fromJson(Map<String, dynamic> json) =>
      _$AdvanceMismatchItemFromJson(json);
  Map<String, dynamic> toJson() => _$AdvanceMismatchItemToJson(this);
}

@JsonSerializable()
class YearlyMismatchesResponse {
  final bool? success;
  final int year;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'attendance_mismatches')
  final List<AttendanceMismatchItem> attendanceMismatches;
  @JsonKey(name: 'advance_mismatches')
  final List<AdvanceMismatchItem> advanceMismatches;

  YearlyMismatchesResponse({
    this.success,
    required this.year,
    required this.userId,
    required this.attendanceMismatches,
    required this.advanceMismatches,
  });

  factory YearlyMismatchesResponse.fromJson(Map<String, dynamic> json) =>
      _$YearlyMismatchesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$YearlyMismatchesResponseToJson(this);
}

@JsonSerializable()
class CreateBulkAttendanceRequest {
  final String date;
  final String shift;
  @JsonKey(name: 'user_ids')
  final List<String> userIds;

  CreateBulkAttendanceRequest({
    required this.date,
    required this.shift,
    required this.userIds,
  });

  factory CreateBulkAttendanceRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateBulkAttendanceRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateBulkAttendanceRequestToJson(this);
}

@JsonSerializable()
class BulkAttendanceResponse {
  final bool success;
  final String? message;

  BulkAttendanceResponse({
    required this.success,
    this.message,
  });

  factory BulkAttendanceResponse.fromJson(Map<String, dynamic> json) =>
      _$BulkAttendanceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BulkAttendanceResponseToJson(this);
}

