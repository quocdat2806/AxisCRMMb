import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/entity/user.dart';

import '../../blocs/workers/workers_cubit.dart';
import '../workers_detail/workers_detail_screen.dart';

class WorkersScreen extends StatelessWidget {
  const WorkersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkersCubit>(
      create: (_) => WorkersCubit(apiClient: getIt<ApiClient>())..loadWorkers(),
      child: const _WorkersView(),
    );
  }
}

class _WorkersView extends StatelessWidget {
  const _WorkersView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkersCubit, WorkersState>(
      builder: (BuildContext context, WorkersState state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xFFF4F7FC),
            body: ListView(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
              children: <Widget>[
                const _PageTitle(title: 'Danh sách thợ'),
                const SizedBox(height: 16),
                if (state.isLoading)
                  const Center(child: CircularProgressIndicator())
                else if (state.users.isEmpty)
                  const _EmptyState(message: 'Chưa có thợ nào')
                else
                  ...state.users.map(
                    (User user) => _UserItem(
                      user: user,
                      onTap: () => _navigateToDetail(context, user),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _navigateToDetail(BuildContext context, User user) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => WorkersDetailScreen(
          userId: user.id,
          userName: user.name,
        ),
      ),
    );
  }
}

class _UserItem extends StatelessWidget {
  const _UserItem({
    required this.user,
    required this.onTap,
  });

  final User user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: _SectionCard(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Tên : ${user.name}',
                      style: const TextStyle(
                        color: Color(0xFF17233C),
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'SĐT : ${user.phone}',
                      style: const TextStyle(
                        color: Color(0xFF667085),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5EAF3)),
      ),
      child: child,
    );
  }
}

class _PageTitle extends StatelessWidget {
  const _PageTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF17233C),
        fontSize: 24,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF98A2B3),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}