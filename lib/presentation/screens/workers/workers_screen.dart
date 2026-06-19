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
      child: const DefaultTabController(
        length: 2,
        child: _WorkersView(),
      ),
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
            appBar: AppBar(
              title: const PageTitle(title: 'Danh sách thợ'),
              backgroundColor: const Color(0xFFF4F7FC),
              elevation: 0,
              automaticallyImplyLeading: false,
              bottom: const TabBar(
                labelColor: Color(0xFF2563EB),
                unselectedLabelColor: Color(0xFF667085),
                indicatorColor: Color(0xFF2563EB),
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                tabs: [
                  Tab(text: 'Đang hoạt động'),
                  Tab(text: 'Đã ẩn'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                _WorkersList(
                  users: state.activeUsers,
                  isLoading: state.isLoading,
                  isActiveTab: true,
                ),
                _WorkersList(
                  users: state.hiddenUsers,
                  isLoading: state.isLoading,
                  isActiveTab: false,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _WorkersList extends StatelessWidget {
  const _WorkersList({
    required this.users,
    required this.isLoading,
    required this.isActiveTab,
  });

  final List<User> users;
  final bool isLoading;
  final bool isActiveTab;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (users.isEmpty) {
      return EmptyState(
        message: isActiveTab ? 'Chưa có thợ nào' : 'Chưa có thợ nào bị ẩn',
      );
    }

    return Stack(
      children: [
        Positioned.fill(
          child: RefreshIndicator(
            onRefresh: () => context.read<WorkersCubit>().loadWorkers(),
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(18, 16, 18, isActiveTab ? 90 : 18),
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                final user = users[index];
                return _UserItem(
                  user: user,
                  onTap: () => _navigateToDetail(context, user),
                  onAction: () => _showActionConfirmDialog(context, user, isActiveTab),
                  isActiveTab: isActiveTab,
                );
              },
            ),
          ),
        ),
        if (isActiveTab)
          Positioned(
            left: 18,
            right: 18,
            bottom: 18,
            child: AppButton(
              label: 'Chấm công hàng loạt',
              onPressed: () => _navigateToBulkAttendance(context, users),
            ),
          ),
      ],
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

  void _showActionConfirmDialog(
    BuildContext context,
    User user,
    bool isCurrentlyActive,
  ) {
    final title = isCurrentlyActive ? 'Xác nhận ẩn' : 'Xác nhận hiện';
    final content = isCurrentlyActive
        ? 'Bạn có chắc chắn muốn ẩn user này không?'
        : 'Bạn có chắc chắn muốn hiện user này không?';
    final confirmText = isCurrentlyActive ? 'Ẩn' : 'Hiện';
    final confirmColor = isCurrentlyActive ? Colors.red : const Color(0xFF2563EB);

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF17233C),
            ),
          ),
          content: Text(
            content,
            style: const TextStyle(fontSize: 14, color: Color(0xFF17233C)),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () async {
                final cubit = context.read<WorkersCubit>();
                Navigator.of(dialogContext).pop();

                // Show loading dialog
                showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext loadingContext) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );

                // Call API
                final success = await cubit.updateUserStatus(user.id, !isCurrentlyActive);

                if (context.mounted) {
                  // Dismiss loading dialog
                  Navigator.of(context).pop();

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isCurrentlyActive
                              ? 'Đã ẩn người dùng thành công'
                              : 'Đã hiển thị người dùng thành công',
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(cubit.state.error ?? 'Thao tác thất bại'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: Text(
                confirmText,
                style: TextStyle(
                  color: confirmColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _UserItem extends StatelessWidget {
  const _UserItem({
    required this.user,
    required this.onTap,
    required this.onAction,
    required this.isActiveTab,
  });

  final User user;
  final VoidCallback onTap;
  final VoidCallback onAction;
  final bool isActiveTab;

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
              TextButton(
                onPressed: onAction,
                child: Text(
                  isActiveTab ? 'Ẩn' : 'Hiện',
                  style: TextStyle(
                    color: isActiveTab ? Colors.red : const Color(0xFF2563EB),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
