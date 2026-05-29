import 'package:json_annotation/json_annotation.dart';
import 'package:axis_crm/entity/entity.dart';

part 'api_client_dto.g.dart';

// Request DTOs
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
class ActivateRequest {
  final String phone;
  @JsonKey(name: 'invite_code')
  final String inviteCode;
  final String pin;

  ActivateRequest({
    required this.phone,
    required this.inviteCode,
    required this.pin,
  });

  factory ActivateRequest.fromJson(Map<String, dynamic> json) =>
      _$ActivateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ActivateRequestToJson(this);
}

@JsonSerializable()
class CreateWorkerRequest {
  final String name;
  final String phone;
  final String skill;
  @JsonKey(name: 'default_daily_rate')
  final int defaultDailyRate;
  final String? note;

  CreateWorkerRequest({
    required this.name,
    required this.phone,
    required this.skill,
    required this.defaultDailyRate,
    this.note,
  });

  factory CreateWorkerRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkerRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateWorkerRequestToJson(this);
}

@JsonSerializable()
class UpdateWorkerRequest {
  final String? name;
  final String? phone;
  final String? skill;
  @JsonKey(name: 'default_daily_rate')
  final int? defaultDailyRate;
  final String? note;
  @JsonKey(name: 'is_active')
  final bool? isActive;

  UpdateWorkerRequest({
    this.name,
    this.phone,
    this.skill,
    this.defaultDailyRate,
    this.note,
    this.isActive,
  });

  factory UpdateWorkerRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateWorkerRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateWorkerRequestToJson(this);
}

@JsonSerializable()
class CreateProjectRequest {
  final String name;
  final String? location;
  @JsonKey(name: 'started_at')
  final String startedAt;

  CreateProjectRequest({
    required this.name,
    this.location,
    required this.startedAt,
  });

  factory CreateProjectRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateProjectRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateProjectRequestToJson(this);
}

@JsonSerializable()
class UpdateProjectRequest {
  final String? name;
  final String? location;
  final String? status;
  @JsonKey(name: 'started_at')
  final String? startedAt;
  @JsonKey(name: 'ended_at')
  final String? endedAt;

  UpdateProjectRequest({
    this.name,
    this.location,
    this.status,
    this.startedAt,
    this.endedAt,
  });

  factory UpdateProjectRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProjectRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateProjectRequestToJson(this);
}

@JsonSerializable()
class SetProjectLocationRequest {
  final double latitude;
  final double longitude;
  @JsonKey(name: 'attendance_radius_meters')
  final int attendanceRadiusMeters;
  @JsonKey(name: 'location_accuracy_meters')
  final int locationAccuracyMeters;

  SetProjectLocationRequest({
    required this.latitude,
    required this.longitude,
    required this.attendanceRadiusMeters,
    required this.locationAccuracyMeters,
  });

  factory SetProjectLocationRequest.fromJson(Map<String, dynamic> json) =>
      _$SetProjectLocationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SetProjectLocationRequestToJson(this);
}

@JsonSerializable()
class AssignWorkerRequest {
  @JsonKey(name: 'worker_id')
  final String workerId;
  @JsonKey(name: 'daily_rate')
  final int dailyRate;
  @JsonKey(name: 'joined_at')
  final String joinedAt;

  AssignWorkerRequest({
    required this.workerId,
    required this.dailyRate,
    required this.joinedAt,
  });

  factory AssignWorkerRequest.fromJson(Map<String, dynamic> json) =>
      _$AssignWorkerRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AssignWorkerRequestToJson(this);
}

@JsonSerializable()
class CheckInRequest {
  @JsonKey(name: 'project_id')
  final String projectId;
  final double latitude;
  final double longitude;
  final String? note;

  CheckInRequest({
    required this.projectId,
    required this.latitude,
    required this.longitude,
    this.note,
  });

  factory CheckInRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckInRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CheckInRequestToJson(this);
}

@JsonSerializable()
class CheckOutRequest {
  @JsonKey(name: 'project_id')
  final String projectId;
  final double latitude;
  final double longitude;
  final String? shift;
  final String? note;

  CheckOutRequest({
    required this.projectId,
    required this.latitude,
    required this.longitude,
    this.shift,
    this.note,
  });

  factory CheckOutRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckOutRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CheckOutRequestToJson(this);
}

@JsonSerializable()
class UpdateAttendanceRequest {
  final String? shift;
  final String? note;

  UpdateAttendanceRequest({this.shift, this.note});

  factory UpdateAttendanceRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateAttendanceRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateAttendanceRequestToJson(this);
}

@JsonSerializable()
class CreateAdvanceRequest {
  @JsonKey(name: 'worker_id')
  final String workerId;
  @JsonKey(name: 'project_id')
  final String projectId;
  final int amount;
  final String date;
  final String? note;

  CreateAdvanceRequest({
    required this.workerId,
    required this.projectId,
    required this.amount,
    required this.date,
    this.note,
  });

  factory CreateAdvanceRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateAdvanceRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateAdvanceRequestToJson(this);
}

@JsonSerializable()
class CreateLeaveRequest {
  @JsonKey(name: 'worker_id')
  final String workerId;
  @JsonKey(name: 'project_id')
  final String projectId;
  final String date;
  final String? reason;

  CreateLeaveRequest({
    required this.workerId,
    required this.projectId,
    required this.date,
    this.reason,
  });

  factory CreateLeaveRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateLeaveRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateLeaveRequestToJson(this);
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
class WorkerDetailResponse {
  final Worker worker;
  WorkerDetailResponse({required this.worker});
  factory WorkerDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$WorkerDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WorkerDetailResponseToJson(this);
}

@JsonSerializable()
class WorkerSummaryResponse {
  final WorkerMonthlySummary summary;
  WorkerSummaryResponse({required this.summary});
  factory WorkerSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$WorkerSummaryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WorkerSummaryResponseToJson(this);
}

@JsonSerializable()
class ProjectsListResponse {
  final List<Project> projects;
  ProjectsListResponse({required this.projects});
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
class EligibilityResponse {
  final Eligibility eligibility;
  EligibilityResponse({required this.eligibility});
  factory EligibilityResponse.fromJson(Map<String, dynamic> json) =>
      _$EligibilityResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EligibilityResponseToJson(this);
}

@JsonSerializable()
class AttendanceResponse {
  final Attendance attendance;
  AttendanceResponse({required this.attendance});
  factory AttendanceResponse.fromJson(Map<String, dynamic> json) =>
      _$AttendanceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AttendanceResponseToJson(this);
}

@JsonSerializable()
class AttendanceListResponse {
  final List<Attendance> attendance;
  AttendanceListResponse({required this.attendance});
  factory AttendanceListResponse.fromJson(Map<String, dynamic> json) =>
      _$AttendanceListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AttendanceListResponseToJson(this);
}

@JsonSerializable()
class AdvanceResponse {
  final Advance advance;
  AdvanceResponse({required this.advance});
  factory AdvanceResponse.fromJson(Map<String, dynamic> json) =>
      _$AdvanceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AdvanceResponseToJson(this);
}

@JsonSerializable()
class AdvancesListResponse {
  final List<Advance> advances;
  AdvancesListResponse({required this.advances});
  factory AdvancesListResponse.fromJson(Map<String, dynamic> json) =>
      _$AdvancesListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AdvancesListResponseToJson(this);
}

@JsonSerializable()
class LeaveResponse {
  final Leave leave;
  LeaveResponse({required this.leave});
  factory LeaveResponse.fromJson(Map<String, dynamic> json) =>
      _$LeaveResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LeaveResponseToJson(this);
}

@JsonSerializable()
class LeavesListResponse {
  final List<Leave> leaves;
  LeavesListResponse({required this.leaves});
  factory LeavesListResponse.fromJson(Map<String, dynamic> json) =>
      _$LeavesListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LeavesListResponseToJson(this);
}
