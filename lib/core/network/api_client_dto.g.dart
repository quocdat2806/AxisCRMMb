// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) =>
    LoginRequest(phone: json['phone'] as String, name: json['name'] as String?);

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{'phone': instance.phone, 'name': instance.name};

ActivateRequest _$ActivateRequestFromJson(Map<String, dynamic> json) =>
    ActivateRequest(
      phone: json['phone'] as String,
      inviteCode: json['invite_code'] as String,
      pin: json['pin'] as String,
    );

Map<String, dynamic> _$ActivateRequestToJson(ActivateRequest instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'invite_code': instance.inviteCode,
      'pin': instance.pin,
    };

CreateWorkerRequest _$CreateWorkerRequestFromJson(Map<String, dynamic> json) =>
    CreateWorkerRequest(
      name: json['name'] as String,
      phone: json['phone'] as String,
      skill: json['skill'] as String,
      defaultDailyRate: (json['default_daily_rate'] as num).toInt(),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$CreateWorkerRequestToJson(
  CreateWorkerRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'phone': instance.phone,
  'skill': instance.skill,
  'default_daily_rate': instance.defaultDailyRate,
  'note': instance.note,
};

UpdateWorkerRequest _$UpdateWorkerRequestFromJson(Map<String, dynamic> json) =>
    UpdateWorkerRequest(
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      skill: json['skill'] as String?,
      defaultDailyRate: (json['default_daily_rate'] as num?)?.toInt(),
      note: json['note'] as String?,
      isActive: json['is_active'] as bool?,
    );

Map<String, dynamic> _$UpdateWorkerRequestToJson(
  UpdateWorkerRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'phone': instance.phone,
  'skill': instance.skill,
  'default_daily_rate': instance.defaultDailyRate,
  'note': instance.note,
  'is_active': instance.isActive,
};

CreateProjectRequest _$CreateProjectRequestFromJson(
  Map<String, dynamic> json,
) => CreateProjectRequest(
  name: json['name'] as String,
  location: json['location'] as String?,
  startedAt: json['started_at'] as String,
);

Map<String, dynamic> _$CreateProjectRequestToJson(
  CreateProjectRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'location': instance.location,
  'started_at': instance.startedAt,
};

UpdateProjectRequest _$UpdateProjectRequestFromJson(
  Map<String, dynamic> json,
) => UpdateProjectRequest(
  name: json['name'] as String?,
  location: json['location'] as String?,
  status: json['status'] as String?,
  startedAt: json['started_at'] as String?,
  endedAt: json['ended_at'] as String?,
);

Map<String, dynamic> _$UpdateProjectRequestToJson(
  UpdateProjectRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'location': instance.location,
  'status': instance.status,
  'started_at': instance.startedAt,
  'ended_at': instance.endedAt,
};

SetProjectLocationRequest _$SetProjectLocationRequestFromJson(
  Map<String, dynamic> json,
) => SetProjectLocationRequest(
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  attendanceRadiusMeters: (json['attendance_radius_meters'] as num).toInt(),
  locationAccuracyMeters: (json['location_accuracy_meters'] as num).toInt(),
);

Map<String, dynamic> _$SetProjectLocationRequestToJson(
  SetProjectLocationRequest instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'attendance_radius_meters': instance.attendanceRadiusMeters,
  'location_accuracy_meters': instance.locationAccuracyMeters,
};

AssignWorkerRequest _$AssignWorkerRequestFromJson(Map<String, dynamic> json) =>
    AssignWorkerRequest(
      workerId: json['worker_id'] as String,
      dailyRate: (json['daily_rate'] as num).toInt(),
      joinedAt: json['joined_at'] as String,
    );

Map<String, dynamic> _$AssignWorkerRequestToJson(
  AssignWorkerRequest instance,
) => <String, dynamic>{
  'worker_id': instance.workerId,
  'daily_rate': instance.dailyRate,
  'joined_at': instance.joinedAt,
};

CheckInRequest _$CheckInRequestFromJson(Map<String, dynamic> json) =>
    CheckInRequest(
      projectId: json['project_id'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$CheckInRequestToJson(CheckInRequest instance) =>
    <String, dynamic>{
      'project_id': instance.projectId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'note': instance.note,
    };

CheckOutRequest _$CheckOutRequestFromJson(Map<String, dynamic> json) =>
    CheckOutRequest(
      projectId: json['project_id'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      shift: json['shift'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$CheckOutRequestToJson(CheckOutRequest instance) =>
    <String, dynamic>{
      'project_id': instance.projectId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'shift': instance.shift,
      'note': instance.note,
    };

UpdateAttendanceRequest _$UpdateAttendanceRequestFromJson(
  Map<String, dynamic> json,
) => UpdateAttendanceRequest(
  shift: json['shift'] as String?,
  note: json['note'] as String?,
);

Map<String, dynamic> _$UpdateAttendanceRequestToJson(
  UpdateAttendanceRequest instance,
) => <String, dynamic>{'shift': instance.shift, 'note': instance.note};

CreateAdvanceRequest _$CreateAdvanceRequestFromJson(
  Map<String, dynamic> json,
) => CreateAdvanceRequest(
  workerId: json['worker_id'] as String,
  projectId: json['project_id'] as String,
  amount: (json['amount'] as num).toInt(),
  date: json['date'] as String,
  note: json['note'] as String?,
);

Map<String, dynamic> _$CreateAdvanceRequestToJson(
  CreateAdvanceRequest instance,
) => <String, dynamic>{
  'worker_id': instance.workerId,
  'project_id': instance.projectId,
  'amount': instance.amount,
  'date': instance.date,
  'note': instance.note,
};

CreateLeaveRequest _$CreateLeaveRequestFromJson(Map<String, dynamic> json) =>
    CreateLeaveRequest(
      workerId: json['worker_id'] as String,
      projectId: json['project_id'] as String,
      date: json['date'] as String,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$CreateLeaveRequestToJson(CreateLeaveRequest instance) =>
    <String, dynamic>{
      'worker_id': instance.workerId,
      'project_id': instance.projectId,
      'date': instance.date,
      'reason': instance.reason,
    };

UsersListResponse _$UsersListResponseFromJson(Map<String, dynamic> json) =>
    UsersListResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: Pagination.fromJson(
        json['pagination'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$UsersListResponseToJson(UsersListResponse instance) =>
    <String, dynamic>{'data': instance.data, 'pagination': instance.pagination};

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
  page: (json['page'] as num).toInt(),
  pageSize: (json['page_size'] as num).toInt(),
  total: (json['total'] as num).toInt(),
);

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'page': instance.page,
      'page_size': instance.pageSize,
      'total': instance.total,
    };

WorkerDetailResponse _$WorkerDetailResponseFromJson(
  Map<String, dynamic> json,
) => WorkerDetailResponse(
  worker: Worker.fromJson(json['worker'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WorkerDetailResponseToJson(
  WorkerDetailResponse instance,
) => <String, dynamic>{'worker': instance.worker};

WorkerSummaryResponse _$WorkerSummaryResponseFromJson(
  Map<String, dynamic> json,
) => WorkerSummaryResponse(
  summary: WorkerMonthlySummary.fromJson(
    json['summary'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$WorkerSummaryResponseToJson(
  WorkerSummaryResponse instance,
) => <String, dynamic>{'summary': instance.summary};

ProjectsListResponse _$ProjectsListResponseFromJson(
  Map<String, dynamic> json,
) => ProjectsListResponse(
  projects: (json['projects'] as List<dynamic>)
      .map((e) => Project.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ProjectsListResponseToJson(
  ProjectsListResponse instance,
) => <String, dynamic>{'projects': instance.projects};

ProjectDetailResponse _$ProjectDetailResponseFromJson(
  Map<String, dynamic> json,
) => ProjectDetailResponse(
  project: Project.fromJson(json['project'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProjectDetailResponseToJson(
  ProjectDetailResponse instance,
) => <String, dynamic>{'project': instance.project};

EligibilityResponse _$EligibilityResponseFromJson(Map<String, dynamic> json) =>
    EligibilityResponse(
      eligibility: Eligibility.fromJson(
        json['eligibility'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$EligibilityResponseToJson(
  EligibilityResponse instance,
) => <String, dynamic>{'eligibility': instance.eligibility};

AttendanceResponse _$AttendanceResponseFromJson(Map<String, dynamic> json) =>
    AttendanceResponse(
      attendance: Attendance.fromJson(
        json['attendance'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$AttendanceResponseToJson(AttendanceResponse instance) =>
    <String, dynamic>{'attendance': instance.attendance};

AttendanceListResponse _$AttendanceListResponseFromJson(
  Map<String, dynamic> json,
) => AttendanceListResponse(
  attendance: (json['attendance'] as List<dynamic>)
      .map((e) => Attendance.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AttendanceListResponseToJson(
  AttendanceListResponse instance,
) => <String, dynamic>{'attendance': instance.attendance};

AdvanceResponse _$AdvanceResponseFromJson(Map<String, dynamic> json) =>
    AdvanceResponse(
      advance: Advance.fromJson(json['advance'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdvanceResponseToJson(AdvanceResponse instance) =>
    <String, dynamic>{'advance': instance.advance};

AdvancesListResponse _$AdvancesListResponseFromJson(
  Map<String, dynamic> json,
) => AdvancesListResponse(
  advances: (json['advances'] as List<dynamic>)
      .map((e) => Advance.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AdvancesListResponseToJson(
  AdvancesListResponse instance,
) => <String, dynamic>{'advances': instance.advances};

LeaveResponse _$LeaveResponseFromJson(Map<String, dynamic> json) =>
    LeaveResponse(leave: Leave.fromJson(json['leave'] as Map<String, dynamic>));

Map<String, dynamic> _$LeaveResponseToJson(LeaveResponse instance) =>
    <String, dynamic>{'leave': instance.leave};

LeavesListResponse _$LeavesListResponseFromJson(Map<String, dynamic> json) =>
    LeavesListResponse(
      leaves: (json['leaves'] as List<dynamic>)
          .map((e) => Leave.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LeavesListResponseToJson(LeavesListResponse instance) =>
    <String, dynamic>{'leaves': instance.leaves};
