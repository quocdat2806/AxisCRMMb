import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:axis_crm/entity/entity.dart';
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

  @GET('/v1/users/{id}')
  Future<WorkerDetailResponse> getWorkerDetail(@Path('id') String id);

  @PATCH('/v1/workers/{id}')
  Future<WorkerDetailResponse> updateWorker(
    @Path('id') String id,
    @Body() UpdateWorkerRequest request,
  );

  @GET('/v1/users/{id}/summary')
  Future<WorkerSummaryResponse> getWorkerSummary(
    @Path('id') String id,
    @Query('month') String month,
  );

  @GET('/v1/me')
  Future<WorkerDetailResponse> getCurrentWorker();

  @GET('/v1/me/summary')
  Future<WorkerSummaryResponse> getCurrentWorkerSummary(
    @Query('month') String month,
  );

  @GET('/v1/me/advances')
  Future<AdvancesListResponse> getCurrentWorkerAdvances(
    @Query('month') String month,
  );

  @GET('/v1/me/attendance')
  Future<AttendanceListResponse> getCurrentWorkerAttendance(
    @Query('month') String month,
  );

  @GET('/v1/me/leaves')
  Future<LeavesListResponse> getCurrentWorkerLeaves(
    @Query('month') String month,
  );

  // Projects
  @GET('/v1/projects')
  Future<ProjectsListResponse> listProjects(@Query('status') String? status);

  @POST('/v1/projects')
  Future<ProjectDetailResponse> createProject(
    @Body() CreateProjectRequest request,
  );

  @GET('/v1/projects/{id}')
  Future<ProjectDetailResponse> getProjectDetail(@Path('id') String id);

  @PATCH('/v1/projects/{id}')
  Future<ProjectDetailResponse> updateProject(
    @Path('id') String id,
    @Body() UpdateProjectRequest request,
  );

  @POST('/v1/projects/{id}/location')
  Future<ProjectDetailResponse> setProjectLocation(
    @Path('id') String id,
    @Body() SetProjectLocationRequest request,
  );

  // Attendance
  @GET('/v1/attendance/eligibility')
  Future<EligibilityResponse> checkAttendanceEligibility(
    @Query('project_id') String projectId,
    @Query('lat') double lat,
    @Query('lng') double lng,
  );

  @POST('/v1/attendance/check-in')
  Future<AttendanceResponse> checkIn(@Body() CheckInRequest request);

  @POST('/v1/attendance/check-out')
  Future<AttendanceResponse> checkOut(@Body() CheckOutRequest request);

  @GET('/v1/attendance')
  Future<AttendanceListResponse> listAttendance(
    @Query('user_id') String? userId,
    @Query('project_id') String? projectId,
    @Query('month') String? month,
  );

  @PATCH('/v1/attendance/{id}')
  Future<AttendanceResponse> updateAttendance(
    @Path('id') String id,
    @Body() UpdateAttendanceRequest request,
  );

  @DELETE('/v1/attendance/{id}')
  Future<void> deleteAttendance(@Path('id') String id);

  // Advances
  @POST('/v1/advances')
  Future<AdvanceResponse> createAdvance(@Body() CreateAdvanceRequest request);

  @GET('/v1/advances')
  Future<AdvancesListResponse> listAdvances(
    @Query('user_id') String? userId,
    @Query('month') String? month,
  );

  @DELETE('/v1/advances/{id}')
  Future<void> deleteAdvance(@Path('id') String id);

  // Leaves
  @POST('/v1/leaves')
  Future<LeaveResponse> createLeave(@Body() CreateLeaveRequest request);

  @GET('/v1/leaves')
  Future<LeavesListResponse> listLeaves(
    @Query('user_id') String? userId,
    @Query('month') String? month,
  );

  @DELETE('/v1/leaves/{id}')
  Future<void> deleteLeave(@Path('id') String id);
}
