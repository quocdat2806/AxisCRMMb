import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/core/network/api_client_dto.dart';
import 'package:axis_crm/entity/project.dart';

import '../../blocs/projects/projects_cubit.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProjectsCubit>(
      create: (_) => ProjectsCubit(apiClient: getIt<ApiClient>())..loadProjects(),
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
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showCreateDialog(context, cubit),
            child: const Icon(Icons.add),
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 88),
            children: <Widget>[
              const _PageTitle(title: 'Công trình'),
              const SizedBox(height: 16),
              if (state.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (state.projects.isEmpty)
                const _EmptyState(message: 'Chưa có công trình nào')
              else
                ...state.projects.map(_ProjectItem.new),
            ],
          ),
        );
      },
    );
  }

  void _showCreateDialog(BuildContext context, ProjectsCubit cubit) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController locationController = TextEditingController();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFF4F7FC),
      builder: (BuildContext dialogContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(dialogContext).viewInsets.bottom,
          ),
          child: _CreateProjectSheet(
            nameController: nameController,
            locationController: locationController,
            onCreate: () {
              cubit.createProject(CreateProjectRequest(
                name: nameController.text.trim(),
                location: locationController.text.trim().isEmpty
                    ? null
                    : locationController.text.trim(),
                startedAt: DateTime.now().toIso8601String().split('T')[0],
              ));
              Navigator.of(dialogContext).pop();
            },
          ),
        );
      },
    );
  }
}

class _CreateProjectSheet extends StatelessWidget {
  const _CreateProjectSheet({
    required this.nameController,
    required this.locationController,
    required this.onCreate,
  });

  final TextEditingController nameController;
  final TextEditingController locationController;
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
          AppTextField(
            label: 'Địa điểm',
            hintText: 'Nhập địa điểm (tuỳ chọn)',
            controller: locationController,
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
      child: _SectionCard(
        child: Row(
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
                  const SizedBox(height: 4),
                  Text(
                    project.location ?? 'Chưa có địa điểm',
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
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0F101828),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
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