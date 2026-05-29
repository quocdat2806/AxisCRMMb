import 'package:axis_crm/core/utils/keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/navigation/app_router.dart';
import 'package:axis_crm/presentation/blocs/session/session_cubit.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppRouter().router;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SessionCubit>.value(
      value: getIt<SessionCubit>(),
      child: GestureDetector(
        onTap: () => KeyboardUtils.hideKeyboard(context),
        child: MaterialApp.router(
          theme: ThemeData(useMaterial3: true),
          routerConfig: _router,
        ),
      ),
    );
  }
}
