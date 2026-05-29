import 'package:axis_crm/core/error/error_mapper.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/core/services/user_session_service.dart';
import 'package:axis_crm/presentation/blocs/session/session_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void initDependencies() {
  if (getIt.isRegistered<ApiClient>()) return;

  _registerCore();
  _registerNetwork();
  _registerRepositories();
  _registerBlocs();
}

void _registerCore() {
  getIt.registerSingleton<ErrorMapper>(const ErrorMapper());
  getIt.registerSingleton<UserSessionService>(UserSessionService());
}

void _registerNetwork() {
  const String baseUrl = 'http://localhost:8080';
  final UserSessionService session = getIt<UserSessionService>();
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: const {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        final String? userId = session.userId;
        if (userId != null && userId.isNotEmpty) {
          options.headers['X-User-ID'] = userId;
        }
        handler.next(options);
      },
    ),
  );

  getIt.registerSingleton<ApiClient>(ApiClient(dio, baseUrl: baseUrl));
}

void _registerRepositories() {}

void _registerBlocs() {
  getIt.registerSingleton<SessionCubit>(
    SessionCubit(sessionService: getIt<UserSessionService>()),
  );
}
