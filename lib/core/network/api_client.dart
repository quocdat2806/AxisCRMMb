import 'package:axis_crm/entity/auth_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:axis_crm/core/network/api_client_dto.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'http://173.16.0.2:8080')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  // Auth
  @POST('/v1/auth/login')
  Future<AuthResponse> login(@Body() LoginRequest request);

  // Users
  @GET('/v1/users')
  Future<UsersListResponse> listUsers();

  @GET('/v1/me/attendance')
  Future<AttendanceRecordListResponse> getCurrentWorkerAttendanceRecords(
    @Query('month') String month,
    @Query('page_size') int pageSize,
  );

  @POST('/v1/me/attendance')
  Future<CreateAttendanceResponse> createAttendance(
    @Body() CreateAttendanceRequest request,
  );

  @POST('/v1/attendance')
  Future<AdminCreateAttendanceResponse> adminCreateAttendance(
    @Body() Map<String, dynamic> request,
  );

  // Projects
  @GET('/v1/projects')
  Future<ProjectsListResponse> listProjects(
    @Query('status') String? status,
    @Query('page') int? page,
    @Query('page_size') int? pageSize,
    @Query('sort') String? sort,
    @Query('order') String? order,
  );

  @POST('/v1/projects')
  Future<ProjectDetailResponse> createProject(
    @Body() CreateProjectRequest request,
  );

  @GET('/v1/attendance')
  Future<AttendanceRecordListResponse> getAttendanceForUser(
    @Query('user_id') String userId,
    @Query('month') String month,
    @Query('page') int page,
    @Query('page_size') int pageSize,
  );

  // Advances
  @POST('/v1/me/worker-advances')
  Future<CreateWorkerAdvanceResponse> createWorkerAdvance(
    @Body() Map<String, dynamic> request,
  );

  @POST('/v1/project-advances')
  Future<CreateProjectAdvanceResponse> createProjectAdvance(
    @Body() CreateProjectAdvanceRequest request,
  );

  @GET('/v1/project-advances')
  Future<ProjectAdvancesListResponse> listProjectAdvances(
    @Query('project_id') String? projectId,
    @Query('user_id') String? userId,
    @Query('month') String? month,
    @Query('page') int? page,
    @Query('page_size') int? pageSize,
    @Query('sort') String? sort,
    @Query('order') String? order,
  );

  @POST('/v1/worker-advances')
  Future<AdminCreateWorkerAdvanceResponse> adminCreateWorkerAdvance(
    @Body() Map<String, dynamic> request,
  );

  @GET('/v1/me/worker-advances')
  Future<WorkerAdvancesListResponse> getWorkerAdvances(
    @Query('month') String month,
    @Query('page') int page,
    @Query('page_size') int pageSize,
  );

  @GET('/v1/worker-advances')
  Future<WorkerAdvancesListResponse> listWorkerAdvancesForUser(
    @Query('user_id') String userId,
    @Query('month') String? month,
    @Query('page') int page,
    @Query('page_size') int pageSize,
  );

  @PATCH('/v1/users/{id}')
  Future<UserUpdateResponse> updateUser(
    @Path('id') String id,
    @Body() Map<String, dynamic> request,
  );

  @GET('/v1/me/attendance/reconcile')
  Future<ReconcileResponse> getReconcileAttendance(
    @Query('month') String month,
  );

  @GET('/v1/me/yearly-summary')
  Future<YearlySummaryResponse> getMyYearlySummary(
    @Query('year') String year,
  );

  @GET('/v1/yearly-summary')
  Future<YearlySummaryResponse> getUserYearlySummary(
    @Query('user_id') String userId,
    @Query('year') String year,
  );

  @GET('/v1/me/yearly-mismatches')
  Future<YearlyMismatchesResponse> getMyYearlyMismatches(
    @Query('year') String year,
  );

  @GET('/v1/yearly-mismatches')
  Future<YearlyMismatchesResponse> getUserYearlyMismatches(
    @Query('user_id') String userId,
    @Query('year') String year,
  );

  @POST('/v1/attendance/bulk')
  Future<BulkAttendanceResponse> createBulkAttendance(
    @Body() CreateBulkAttendanceRequest request,
  );
}
