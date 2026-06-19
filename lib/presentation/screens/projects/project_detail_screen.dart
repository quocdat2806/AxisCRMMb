import 'package:axis_crm/presentation/widgets/page_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/core/network/api_client_dto.dart';
import 'package:axis_crm/core/utils/date_until.dart';
import 'package:axis_crm/entity/project.dart';

import '../../cubits/project_detail/project_detail_cubit.dart';
import '../../widgets/app_button.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/section_card.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProjectDetailCubit>(
      create: (_) =>
          ProjectDetailCubit(apiClient: getIt<ApiClient>(), project: project)
            ..loadProjectDetail(),
      child: const _ProjectDetailView(),
    );
  }
}

class _ProjectDetailView extends StatelessWidget {
  const _ProjectDetailView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectDetailCubit, ProjectDetailState>(
      builder: (BuildContext context, ProjectDetailState state) {
        final ProjectDetailCubit cubit = context.read<ProjectDetailCubit>();

        return Scaffold(
          backgroundColor: const Color(0xFFF4F7FC),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF4F7FC),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF17233C)),
              onPressed: () => context.pop(),
            ),
            title: PageTitle(title: 'Chi tiết công trình'),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(18),
                    children: <Widget>[
                      if (state.isLoading)
                        const Center(child: CircularProgressIndicator())
                      else if (state.project == null)
                        const EmptyState(message: 'Không tìm thấy công trình')
                      else ...[
                        _ProjectHeader(
                          project: state.project!,
                          totalAdvances: state.advances.fold<double>(
                            0.0,
                            (sum, item) => sum + (item.amount ?? 0.0),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Danh sách ứng tiền',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF17233C),
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (state.advances.isEmpty)
                          const EmptyState(message: 'Chưa có đơn ứng tiền nào')
                        else
                          ...state.advances.map(_AdvanceItem.new),
                      ],
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                  child: SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      label: 'Ứng tiền',
                      onPressed: () async {
                        final projectId = state.project?.id ?? '';
                        final projectName = state.project?.name ?? '';
                        await context.push(
                          '/project/$projectId/advance',
                          extra: projectName,
                        );
                        if (context.mounted) {
                          cubit.loadProjectDetail();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProjectHeader extends StatelessWidget {
  const _ProjectHeader({required this.project, required this.totalAdvances});

  final Project project;
  final double totalAdvances;

  @override
  Widget build(BuildContext context) {
    final formattedTotal = totalAdvances
        .toStringAsFixed(0)
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.');

    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF4FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.location_city,
                  color: Color(0xFF2457D6),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      project.name,
                      style: const TextStyle(
                        color: Color(0xFF17233C),
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    if (project.startedAt != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Bắt đầu: ${AppDateUtils.formatDate(project.startedAt!)}',
                        style: const TextStyle(
                          color: Color(0xFF667085),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      'Tổng tiền ứng: $formattedTotal vnđ',
                      style: const TextStyle(
                        color: Color(0xFFEA580C),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AdvanceItem extends StatelessWidget {
  const _AdvanceItem(this.advance);

  final ProjectAdvanceItem advance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SectionCard(
        child: Row(
          children: <Widget>[
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF7ED),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.payments, color: Color(0xFFEA580C)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Số tiền ứng ${advance.amount?.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.') ?? 0} vnđ',
                    style: const TextStyle(
                      color: Color(0xFF17233C),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Ngày ứng : ${advance.date.split('T').first.replaceAll('-', '-')}',
                    style: const TextStyle(
                      color: Color(0xFF667085),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (advance.note != null && advance.note!.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      'Ghi chú: ${advance.note}',
                      style: const TextStyle(
                        color: Color(0xFF667085),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
