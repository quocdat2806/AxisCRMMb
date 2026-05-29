import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/entity/user.dart';
import 'package:axis_crm/presentation/blocs/session/session_cubit.dart';
import 'package:axis_crm/presentation/screens/login/login_screen.dart';
import 'package:axis_crm/presentation/screens/main/main_screen.dart';
import './router_path.dart';

class AppRouter {
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  late final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouterPath.login,
    errorBuilder: (_, GoRouterState state) =>
        const Scaffold(body: Center(child: Text('Page not found'))),
    routes: <RouteBase>[
      GoRoute(
        name: RouterPath.login,
        path: RouterPath.login,
        builder: (_, _) => const LoginScreen(),
      ),
      GoRoute(
        name: RouterPath.main,
        path: RouterPath.main,
        builder: (_, GoRouterState state) {
          final Object? extra = state.extra;
          final User? user = extra is User
              ? extra
              : getIt<SessionCubit>().state.user;
          if (user == null) {
            return const LoginScreen();
          }
          return MainScreen(user: user);
        },
      ),
    ],
  );
}
