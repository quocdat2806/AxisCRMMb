import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/core/network/api_client_dto.dart';
import 'package:axis_crm/core/utils/date_until.dart';
import 'package:axis_crm/entity/project.dart';

import '../../cubits/projects/projects_cubit.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_date_picker_dialog.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/section_card.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/page_title.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProjectsCubit>(
      create: (_) =>
          ProjectsCubit(apiClient: getIt<ApiClient>())..loadProjects(),
      child: const _ProjectsView(),
    );
  }
}

class _ProjectsView extends StatelessWidget {
  const _ProjectsView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsCubit, ProjectsState>(
      builder: (BuildContext context, ProjectsState state) {
        final ProjectsCubit cubit = context.read<ProjectsCubit>();

        return Scaffold(
          backgroundColor: const Color(0xFFF4F7FC),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(18),
                  child: PageTitle(title: 'Công trình'),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    children: <Widget>[
                      if (state.isLoading)
                        const Center(child: CircularProgressIndicator())
                      else if (state.projects.isEmpty)
                        const EmptyState(message: 'Chưa có công trình nào')
                      else
                        ...state.projects.map(_ProjectItem.new),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                  child: SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      label: 'Tạo công trình',
                      onPressed: () => _showCreateDialog(context, cubit),
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

  void _showCreateDialog(BuildContext context, ProjectsCubit cubit) {
    final TextEditingController nameController = TextEditingController();
    DateTime? selectedDate;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFF4F7FC),
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(dialogContext).viewInsets.bottom,
              ),
              child: _CreateProjectSheet(
                nameController: nameController,
                selectedDate: selectedDate,
                onDateTap: () async {
                  final date = await showDialog<DateTime>(
                    context: dialogContext,
                    builder: (_) => const AppDatePickerDialog(),
                  );
                  if (date != null) {
                    setState(() => selectedDate = date);
                  }
                },
                onCreate: () {
                  cubit.createProject(
                    CreateProjectRequest(
                      name: nameController.text.trim(),
                      startedAt: selectedDate != null
                          ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                          : null,
                    ),
                  );
                  Navigator.of(dialogContext).pop();
                },
              ),
            );
          },
        );
      },
    );
  }
}

class _CreateProjectSheet extends StatelessWidget {
  const _CreateProjectSheet({
    required this.nameController,
    required this.selectedDate,
    required this.onDateTap,
    required this.onCreate,
  });

  final TextEditingController nameController;
  final DateTime? selectedDate;
  final VoidCallback onDateTap;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Tạo công trình',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Color(0xFF17233C),
            ),
          ),
          const SizedBox(height: 18),
          AppTextField(
            label: 'Tên công trình',
            hintText: 'Nhập tên công trình',
            controller: nameController,
          ),
          const SizedBox(height: 14),
          const Text(
            'Thời gian bắt đầu',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF344054),
            ),
          ),
          const SizedBox(height: 6),
          InkWell(
            onTap: onDateTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFCDCED1)),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      selectedDate != null
                          ? AppDateUtils.formatDate(selectedDate!)
                          : 'Chọn ngày (tuỳ chọn)',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: selectedDate != null
                            ? const Color(0xFF17233C)
                            : const Color(0xFF98A2B3),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.calendar_today,
                    size: 20,
                    color: Color(0xFF667085),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: AppButton(
              label: 'Tạo công trình',
              onPressed: nameController.text.trim().isEmpty ? null : onCreate,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        ],
      ),
    );
  }
}

class _ProjectItem extends StatelessWidget {
  const _ProjectItem(this.project);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SectionCard(
        onTap: () => context.push('/project/${project.id}', extra: project),
        child: Row(
          children: <Widget>[
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF4FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.location_city, color: Color(0xFF2457D6)),
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
                  const SizedBox(height: 4),
                  Text(
                    project.startedAt != null
                        ? 'Bắt đầu: ${AppDateUtils.formatDate(project.startedAt!)}'
                        : 'Chưa có thời gian bắt đầu',
                    style: const TextStyle(
                      color: Color(0xFF667085),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: project.status == 'active'
                    ? const Color(0xFF16A34A).withValues(alpha: 0.12)
                    : const Color(0xFF98A2B3).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                project.status == 'active' ? 'Đang hoạt động' : project.status,
                style: TextStyle(
                  color: project.status == 'active'
                      ? const Color(0xFF16A34A)
                      : const Color(0xFF98A2B3),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
