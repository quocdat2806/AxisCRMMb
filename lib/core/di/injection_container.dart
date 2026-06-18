import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/core/services/user_session_service.dart';
import 'package:axis_crm/presentation/cubits/session/session_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDependencies() async {
  if (getIt.isRegistered<ApiClient>()) return;

  await _registerCore();
  _registerNetwork();
  _registerRepositories();
  _registerBlocs();
}

Future<void> _registerCore() async {
  final UserSessionService sessionService = UserSessionService();
  await sessionService.init();
  getIt.registerSingleton<UserSessionService>(sessionService);
}

void _registerNetwork() {
  const String baseUrl = 'http://173.16.0.2:8080';
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

  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    logPrint: (obj) => print('[API] $obj'),
  ));

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        final String? userId = session.userId;
        if (userId != null && userId.isNotEmpty) {
          options.headers['X-User-ID'] = userId;
        }
        print('[API] Request: ${options.method} ${options.uri}');
        print('[API] Query params: ${options.queryParameters}');
        handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        print('[API] Response: ${response.statusCode} ${response.requestOptions.uri}');
        print('[API] Response data: ${response.data}');
        handler.next(response);
      },
      onError: (DioException e, ErrorInterceptorHandler handler) {
        print('[API] Error: ${e.message}');
        print('[API] Error response: ${e.response?.data}');
        handler.next(e);
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
