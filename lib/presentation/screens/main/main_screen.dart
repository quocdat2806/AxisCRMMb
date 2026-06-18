import 'package:axis_crm/presentation/cubits/main/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/entity/user.dart';

import '../user_advance/user_advance_screen.dart';
import '../projects/projects_screen.dart';
import '../timekeeping/timekeeping_screen.dart';
import '../worksheet/worksheet_screen.dart';
import '../workers/workers_screen.dart';
import '../profile/profile_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
      create: (_) => MainCubit(),
      child: _MainView(user: user),
    );
  }
}

class _MainView extends StatelessWidget {
  const _MainView({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    if (user.isOwner) {
      return _OwnerView(user: user);
    }
    return _UserView(user: user);
  }
}

class _OwnerView extends StatelessWidget {
  const _OwnerView({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, MainState state) {
        return Scaffold(
          body: IndexedStack(
            index: state.currentTab,
            children: const <Widget>[WorkersScreen(), ProjectsScreen()],
          ),

          bottomNavigationBar: NavigationBarTheme(
            data: const NavigationBarThemeData(
              indicatorColor: Colors.transparent,
            ),
            child: NavigationBar(
              selectedIndex: state.currentTab,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,

              onDestinationSelected: context.read<MainCubit>().tabChanged,
              destinations: const <NavigationDestination>[
                NavigationDestination(
                  icon: Text(
                    'Công nhân',
                    style: TextStyle(
                      color: Color(0xFF667085),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  selectedIcon: Text(
                    'Công nhân',
                    style: TextStyle(
                      color: Color(0xFF2457D6),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  label: '',
                ),
                NavigationDestination(
                  icon: Text(
                    'Công trình',
                    style: TextStyle(
                      color: Color(0xFF667085),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  selectedIcon: Text(
                    'Công trình',
                    style: TextStyle(
                      color: Color(0xFF2457D6),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  label: '',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _UserView extends StatelessWidget {
  const _UserView({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listenWhen: (previous, current) =>
          current.justReturnedFromOtherTab && current.previousTab == 2,
      listener: (context, state) {
        context.read<MainCubit>().clearJustReturned();
      },
      builder: (BuildContext context, MainState state) {
        return Scaffold(
          body: IndexedStack(
            index: state.currentTab,
            children: <Widget>[
              _WorksheetWithRefresh(user: user),
              const UserAdvanceScreen(),
              const TimekeepingScreen(),
              ProfileScreen(user: user),
            ],
          ),
          bottomNavigationBar: NavigationBarTheme(
            data: const NavigationBarThemeData(
              indicatorColor: Colors.transparent,
            ),
            child: NavigationBar(
              height: 60,
              selectedIndex: state.currentTab,
              onDestinationSelected: context.read<MainCubit>().tabChanged,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              destinations: const <NavigationDestination>[
                NavigationDestination(
                  icon: Text(
                    'Bảng công',
                    style: TextStyle(
                      color: Color(0xFF667085),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  selectedIcon: Text(
                    'Bảng công',
                    style: TextStyle(
                      color: Color(0xFF2457D6),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  label: '',
                ),
                NavigationDestination(
                  icon: Text(
                    'Ứng tiền',
                    style: TextStyle(
                      color: Color(0xFF667085),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  selectedIcon: Text(
                    'Ứng tiền',
                    style: TextStyle(
                      color: Color(0xFF2457D6),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  label: '',
                ),
                NavigationDestination(
                  icon: Text(
                    'Chấm công',
                    style: TextStyle(
                      color: Color(0xFF667085),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  selectedIcon: Text(
                    'Chấm công',
                    style: TextStyle(
                      color: Color(0xFF2457D6),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  label: '',
                ),
                NavigationDestination(
                  icon: Text(
                    'Cá nhân',
                    style: TextStyle(
                      color: Color(0xFF667085),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  selectedIcon: Text(
                    'Cá nhân',
                    style: TextStyle(
                      color: Color(0xFF2457D6),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  label: '',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _WorksheetWithRefresh extends StatefulWidget {
  const _WorksheetWithRefresh({required this.user});

  final User user;

  @override
  State<_WorksheetWithRefresh> createState() => _WorksheetWithRefreshState();
}

class _WorksheetWithRefreshState extends State<_WorksheetWithRefresh> {
  Key _worksheetKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainCubit, MainState>(
      listenWhen: (previous, current) =>
          current.justReturnedFromOtherTab && current.previousTab == 2,
      listener: (context, state) {
        setState(() {
          _worksheetKey = UniqueKey();
        });
      },
      child: WorksheetScreen(key: _worksheetKey, user: widget.user),
    );
  }
}
