// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) =>
    LoginRequest(phone: json['phone'] as String, name: json['name'] as String?);

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{'phone': instance.phone, 'name': instance.name};

CreateProjectRequest _$CreateProjectRequestFromJson(
  Map<String, dynamic> json,
) => CreateProjectRequest(
  name: json['name'] as String,
  startedAt: json['started_at'] as String?,
);

Map<String, dynamic> _$CreateProjectRequestToJson(
  CreateProjectRequest instance,
) => <String, dynamic>{'name': instance.name, 'started_at': instance.startedAt};

CreateWorkerAdvanceResponse _$CreateWorkerAdvanceResponseFromJson(
  Map<String, dynamic> json,
) => CreateWorkerAdvanceResponse(
  success: json['success'] as bool,
  message: json['message'] as String?,
  advance: json['advance'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CreateWorkerAdvanceResponseToJson(
  CreateWorkerAdvanceResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'advance': instance.advance,
};

CreateProjectAdvanceRequest _$CreateProjectAdvanceRequestFromJson(
  Map<String, dynamic> json,
) => CreateProjectAdvanceRequest(
  userId: json['user_id'] as String,
  projectId: json['project_id'] as String,
  amount: (json['amount'] as num).toDouble(),
  date: json['date'] as String,
  note: json['note'] as String?,
);

Map<String, dynamic> _$CreateProjectAdvanceRequestToJson(
  CreateProjectAdvanceRequest instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'project_id': instance.projectId,
  'amount': instance.amount,
  'date': instance.date,
  'note': instance.note,
};

CreateProjectAdvanceResponse _$CreateProjectAdvanceResponseFromJson(
  Map<String, dynamic> json,
) => CreateProjectAdvanceResponse(
  success: json['success'] as bool,
  message: json['message'] as String?,
  advance: json['advance'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CreateProjectAdvanceResponseToJson(
  CreateProjectAdvanceResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'advance': instance.advance,
};

CreateAttendanceRequest _$CreateAttendanceRequestFromJson(
  Map<String, dynamic> json,
) => CreateAttendanceRequest(
  date: json['date'] as String,
  shift: json['shift'] as String,
  note: json['note'] as String?,
);

Map<String, dynamic> _$CreateAttendanceRequestToJson(
  CreateAttendanceRequest instance,
) => <String, dynamic>{
  'date': instance.date,
  'shift': instance.shift,
  'note': instance.note,
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

ProjectsListResponse _$ProjectsListResponseFromJson(
  Map<String, dynamic> json,
) => ProjectsListResponse(
  data: (json['data'] as List<dynamic>)
      .map((e) => Project.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProjectsListResponseToJson(
  ProjectsListResponse instance,
) => <String, dynamic>{
  'data': instance.data,
  'pagination': instance.pagination,
};

ProjectDetailResponse _$ProjectDetailResponseFromJson(
  Map<String, dynamic> json,
) => ProjectDetailResponse(
  project: Project.fromJson(json['project'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProjectDetailResponseToJson(
  ProjectDetailResponse instance,
) => <String, dynamic>{'project': instance.project};

AttendanceRecordListResponse _$AttendanceRecordListResponseFromJson(
  Map<String, dynamic> json,
) => AttendanceRecordListResponse(
  data: (json['data'] as List<dynamic>)
      .map((e) => AttendanceRecord.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AttendanceRecordListResponseToJson(
  AttendanceRecordListResponse instance,
) => <String, dynamic>{
  'data': instance.data,
  'pagination': instance.pagination,
};

AdminCreateAttendanceResponse _$AdminCreateAttendanceResponseFromJson(
  Map<String, dynamic> json,
) => AdminCreateAttendanceResponse(
  success: json['success'] as bool,
  message: json['message'] as String?,
  attendance: json['attendance'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$AdminCreateAttendanceResponseToJson(
  AdminCreateAttendanceResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'attendance': instance.attendance,
};

CreateAttendanceResponse _$CreateAttendanceResponseFromJson(
  Map<String, dynamic> json,
) => CreateAttendanceResponse(
  success: json['success'] as bool,
  message: json['message'] as String?,
);

Map<String, dynamic> _$CreateAttendanceResponseToJson(
  CreateAttendanceResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
};

WorkerAdvancesListResponse _$WorkerAdvancesListResponseFromJson(
  Map<String, dynamic> json,
) => WorkerAdvancesListResponse(
  data: (json['data'] as List<dynamic>)
      .map((e) => WorkerAdvanceItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WorkerAdvancesListResponseToJson(
  WorkerAdvancesListResponse instance,
) => <String, dynamic>{
  'data': instance.data,
  'pagination': instance.pagination,
};

AdminCreateWorkerAdvanceResponse _$AdminCreateWorkerAdvanceResponseFromJson(
  Map<String, dynamic> json,
) => AdminCreateWorkerAdvanceResponse(
  success: json['success'] as bool,
  message: json['message'] as String?,
  advance: json['advance'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$AdminCreateWorkerAdvanceResponseToJson(
  AdminCreateWorkerAdvanceResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'advance': instance.advance,
};

WorkerAdvanceItem _$WorkerAdvanceItemFromJson(Map<String, dynamic> json) =>
    WorkerAdvanceItem(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      date: json['date'] as String,
      amount: (json['amount'] as num?)?.toInt(),
      workerAmount: (json['worker_amount'] as num?)?.toInt(),
      contractorAmount: (json['contractor_amount'] as num?)?.toInt(),
      status: json['status'] as String,
      workerNote: json['worker_note'] as String?,
      contractorNote: json['contractor_note'] as String?,
      workerSubmittedAt: json['worker_submitted_at'] as String?,
      contractorSubmittedAt: json['contractor_submitted_at'] as String?,
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$WorkerAdvanceItemToJson(WorkerAdvanceItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'date': instance.date,
      'amount': instance.amount,
      'worker_amount': instance.workerAmount,
      'contractor_amount': instance.contractorAmount,
      'status': instance.status,
      'worker_note': instance.workerNote,
      'contractor_note': instance.contractorNote,
      'worker_submitted_at': instance.workerSubmittedAt,
      'contractor_submitted_at': instance.contractorSubmittedAt,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

UserUpdateResponse _$UserUpdateResponseFromJson(Map<String, dynamic> json) =>
    UserUpdateResponse(
      success: json['success'] as bool,
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserUpdateResponseToJson(UserUpdateResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'user': instance.user,
    };

ProjectAdvanceItem _$ProjectAdvanceItemFromJson(Map<String, dynamic> json) =>
    ProjectAdvanceItem(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      projectId: json['project_id'] as String,
      amount: (json['amount'] as num?)?.toDouble(),
      workerAmount: (json['worker_amount'] as num?)?.toDouble(),
      contractorAmount: (json['contractor_amount'] as num?)?.toDouble(),
      status: json['status'] as String?,
      date: json['date'] as String,
      workerNote: json['worker_note'] as String?,
      contractorNote: json['contractor_note'] as String?,
      note: json['note'] as String?,
      workerSubmittedAt: json['worker_submitted_at'] as String?,
      contractorSubmittedAt: json['contractor_submitted_at'] as String?,
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProjectAdvanceItemToJson(ProjectAdvanceItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'project_id': instance.projectId,
      'amount': instance.amount,
      'worker_amount': instance.workerAmount,
      'contractor_amount': instance.contractorAmount,
      'status': instance.status,
      'date': instance.date,
      'worker_note': instance.workerNote,
      'contractor_note': instance.contractorNote,
      'note': instance.note,
      'worker_submitted_at': instance.workerSubmittedAt,
      'contractor_submitted_at': instance.contractorSubmittedAt,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'user': instance.user,
    };

ProjectAdvancesListResponse _$ProjectAdvancesListResponseFromJson(
  Map<String, dynamic> json,
) => ProjectAdvancesListResponse(
  data: (json['data'] as List<dynamic>)
      .map((e) => ProjectAdvanceItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProjectAdvancesListResponseToJson(
  ProjectAdvancesListResponse instance,
) => <String, dynamic>{
  'data': instance.data,
  'pagination': instance.pagination,
};

ReconcileAttendanceItem _$ReconcileAttendanceItemFromJson(
  Map<String, dynamic> json,
) => ReconcileAttendanceItem(
  date: json['date'] as String,
  shift: json['shift'] as String?,
  note: json['note'] as String?,
);

Map<String, dynamic> _$ReconcileAttendanceItemToJson(
  ReconcileAttendanceItem instance,
) => <String, dynamic>{
  'date': instance.date,
  'shift': instance.shift,
  'note': instance.note,
};

ReconcileResponse _$ReconcileResponseFromJson(
  Map<String, dynamic> json,
) => ReconcileResponse(
  success: json['success'] as bool,
  mismatchDates: (json['mismatch_dates'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  workerAttendance: (json['worker_attendance'] as List<dynamic>)
      .map((e) => ReconcileAttendanceItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  contractorAttendance: (json['contractor_attendance'] as List<dynamic>)
      .map((e) => ReconcileAttendanceItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ReconcileResponseToJson(ReconcileResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'mismatch_dates': instance.mismatchDates,
      'worker_attendance': instance.workerAttendance,
      'contractor_attendance': instance.contractorAttendance,
    };

YearlySummarySide _$YearlySummarySideFromJson(Map<String, dynamic> json) =>
    YearlySummarySide(
      totalFullDays: (json['total_full_days'] as num).toInt(),
      totalHalfDays: (json['total_half_days'] as num).toInt(),
      totalAbsentDays: (json['total_absent_days'] as num).toInt(),
      totalWorkDays: (json['total_work_days'] as num).toDouble(),
      totalAdvanceAmount: (json['total_advance_amount'] as num).toDouble(),
    );

Map<String, dynamic> _$YearlySummarySideToJson(YearlySummarySide instance) =>
    <String, dynamic>{
      'total_full_days': instance.totalFullDays,
      'total_half_days': instance.totalHalfDays,
      'total_absent_days': instance.totalAbsentDays,
      'total_work_days': instance.totalWorkDays,
      'total_advance_amount': instance.totalAdvanceAmount,
    };

YearlySummaryData _$YearlySummaryDataFromJson(Map<String, dynamic> json) =>
    YearlySummaryData(
      year: (json['year'] as num).toInt(),
      userId: json['user_id'] as String,
      workerSide: YearlySummarySide.fromJson(
        json['worker_side'] as Map<String, dynamic>,
      ),
      contractorSide: YearlySummarySide.fromJson(
        json['contractor_side'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$YearlySummaryDataToJson(YearlySummaryData instance) =>
    <String, dynamic>{
      'year': instance.year,
      'user_id': instance.userId,
      'worker_side': instance.workerSide,
      'contractor_side': instance.contractorSide,
    };

YearlySummaryResponse _$YearlySummaryResponseFromJson(
  Map<String, dynamic> json,
) => YearlySummaryResponse(
  success: json['success'] as bool,
  summary: YearlySummaryData.fromJson(json['summary'] as Map<String, dynamic>),
);

Map<String, dynamic> _$YearlySummaryResponseToJson(
  YearlySummaryResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'summary': instance.summary,
};

AttendanceMismatchItem _$AttendanceMismatchItemFromJson(
  Map<String, dynamic> json,
) => AttendanceMismatchItem(
  date: json['date'] as String,
  workerShift: json['worker_shift'] as String?,
  contractorShift: json['contractor_shift'] as String?,
  workerNote: json['worker_note'] as String?,
  contractorNote: json['contractor_note'] as String?,
);

Map<String, dynamic> _$AttendanceMismatchItemToJson(
  AttendanceMismatchItem instance,
) => <String, dynamic>{
  'date': instance.date,
  'worker_shift': instance.workerShift,
  'contractor_shift': instance.contractorShift,
  'worker_note': instance.workerNote,
  'contractor_note': instance.contractorNote,
};

AdvanceMismatchItem _$AdvanceMismatchItemFromJson(Map<String, dynamic> json) =>
    AdvanceMismatchItem(
      date: json['date'] as String,
      workerAmount: (json['worker_amount'] as num?)?.toDouble(),
      contractorAmount: (json['contractor_amount'] as num?)?.toDouble(),
      workerNote: json['worker_note'] as String?,
      contractorNote: json['contractor_note'] as String?,
    );

Map<String, dynamic> _$AdvanceMismatchItemToJson(
  AdvanceMismatchItem instance,
) => <String, dynamic>{
  'date': instance.date,
  'worker_amount': instance.workerAmount,
  'contractor_amount': instance.contractorAmount,
  'worker_note': instance.workerNote,
  'contractor_note': instance.contractorNote,
};

YearlyMismatchesResponse _$YearlyMismatchesResponseFromJson(
  Map<String, dynamic> json,
) => YearlyMismatchesResponse(
  success: json['success'] as bool?,
  year: (json['year'] as num).toInt(),
  userId: json['user_id'] as String,
  attendanceMismatches: (json['attendance_mismatches'] as List<dynamic>)
      .map((e) => AttendanceMismatchItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  advanceMismatches: (json['advance_mismatches'] as List<dynamic>)
      .map((e) => AdvanceMismatchItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$YearlyMismatchesResponseToJson(
  YearlyMismatchesResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'year': instance.year,
  'user_id': instance.userId,
  'attendance_mismatches': instance.attendanceMismatches,
  'advance_mismatches': instance.advanceMismatches,
};

CreateBulkAttendanceRequest _$CreateBulkAttendanceRequestFromJson(
  Map<String, dynamic> json,
) => CreateBulkAttendanceRequest(
  date: json['date'] as String,
  shift: json['shift'] as String,
  userIds: (json['user_ids'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$CreateBulkAttendanceRequestToJson(
  CreateBulkAttendanceRequest instance,
) => <String, dynamic>{
  'date': instance.date,
  'shift': instance.shift,
  'user_ids': instance.userIds,
};

BulkAttendanceResponse _$BulkAttendanceResponseFromJson(
  Map<String, dynamic> json,
) => BulkAttendanceResponse(
  success: json['success'] as bool,
  message: json['message'] as String?,
);

Map<String, dynamic> _$BulkAttendanceResponseToJson(
  BulkAttendanceResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
};

ReconcileAdvanceItem _$ReconcileAdvanceItemFromJson(
  Map<String, dynamic> json,
) => ReconcileAdvanceItem(
  date: json['date'] as String,
  amount: (json['amount'] as num?)?.toDouble(),
  note: json['note'] as String?,
);

Map<String, dynamic> _$ReconcileAdvanceItemToJson(
  ReconcileAdvanceItem instance,
) => <String, dynamic>{
  'date': instance.date,
  'amount': instance.amount,
  'note': instance.note,
};

ReconcileAdvanceResponse _$ReconcileAdvanceResponseFromJson(
  Map<String, dynamic> json,
) => ReconcileAdvanceResponse(
  success: json['success'] as bool,
  mismatchDates: (json['mismatch_dates'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  workerAdvances: (json['worker_advances'] as List<dynamic>?)
      ?.map((e) => ReconcileAdvanceItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  contractorAdvances: (json['contractor_advances'] as List<dynamic>?)
      ?.map((e) => ReconcileAdvanceItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ReconcileAdvanceResponseToJson(
  ReconcileAdvanceResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'mismatch_dates': instance.mismatchDates,
  'worker_advances': instance.workerAdvances,
  'contractor_advances': instance.contractorAdvances,
};
