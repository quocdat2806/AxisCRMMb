import 'package:axis_crm/presentation/widgets/page_title.dart';
import 'package:axis_crm/presentation/widgets/section_card.dart';
import 'package:axis_crm/presentation/widgets/empty_state.dart';
import 'package:axis_crm/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/entity/user.dart';

import '../../cubits/workers/workers_cubit.dart';
import '../workers_detail/workers_detail_screen.dart';
import '../bulk_attendance/bulk_attendance_screen.dart';

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
            body: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 90),
                    children: <Widget>[
                      const PageTitle(title: 'Danh sách thợ'),
                      const SizedBox(height: 16),
                      if (state.isLoading)
                        const Center(child: CircularProgressIndicator())
                      else if (state.users.isEmpty)
                        const EmptyState(message: 'Chưa có thợ nào')
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
                if (!state.isLoading && state.users.isNotEmpty)
                  Positioned(
                    left: 18,
                    right: 18,
                    bottom: 18,
                    child: AppButton(
                      label: 'Chấm công hàng loạt',
                      onPressed: () => _navigateToBulkAttendance(context, state.users),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _navigateToDetail(BuildContext context, User user) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => WorkersDetailScreen(
          user: user,
        ),
      ),
    );
    if (context.mounted) {
      context.read<WorkersCubit>().loadWorkers();
    }
  }

  void _navigateToBulkAttendance(BuildContext context, List<User> users) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BulkAttendanceScreen(
          users: users,
        ),
      ),
    );
    if (context.mounted) {
      context.read<WorkersCubit>().loadWorkers();
    }
  }
}

class _UserItem extends StatelessWidget {
  const _UserItem({required this.user, required this.onTap});

  final User user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SectionCard(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Tên : ${user.name}${user.nickname != null && user.nickname!.isNotEmpty ? ' (${user.nickname})' : ''}',
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
