import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/entity/user.dart';

import '../../blocs/main/main_cubit.dart';
import '../advance/advance_screen.dart';
import '../home/worksheet_screen.dart';
import '../timekeeping/timekeeping_screen.dart';
import '../projects/projects_screen.dart';
import '../workers/workers_screen.dart';

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
            children: const <Widget>[
              WorkersScreen(),
              AdvanceScreen(),
              TimekeepingScreen(),
              ProjectsScreen(),
            ],
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: state.currentTab,
            onDestinationSelected: context.read<MainCubit>().tabChanged,
            destinations: const <NavigationDestination>[
              NavigationDestination(
                icon: Icon(Icons.people_outlined),
                selectedIcon: Icon(Icons.people),
                label: 'Thợ',
              ),
              NavigationDestination(
                icon: Icon(Icons.payments_outlined),
                selectedIcon: Icon(Icons.payments),
                label: 'Ứng tiền',
              ),
              NavigationDestination(
                icon: Icon(Icons.event_busy_outlined),
                selectedIcon: Icon(Icons.event_busy),
                label: 'Chấm công',
              ),
              NavigationDestination(
                icon: Icon(Icons.location_city_outlined),
                selectedIcon: Icon(Icons.location_city),
                label: 'Công trình',
              ),
            ],
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
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, MainState state) {
        return Scaffold(
          body: IndexedStack(
            index: state.currentTab,
            children: <Widget>[
              WorksheetScreen(user: user),
              const AdvanceScreen(),
              const TimekeepingScreen(),
            ],
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: state.currentTab,
            onDestinationSelected: context.read<MainCubit>().tabChanged,
            destinations: const <NavigationDestination>[
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Bảng công',
              ),
              NavigationDestination(
                icon: Icon(Icons.payments_outlined),
                selectedIcon: Icon(Icons.payments),
                label: 'Ứng tiền',
              ),
              NavigationDestination(
                icon: Icon(Icons.event_busy_outlined),
                selectedIcon: Icon(Icons.event_busy),
                label: 'Chấm công',
              ),
            ],
          ),
        );
      },
    );
  }
}
