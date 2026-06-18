import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/core/network/api_client_dto.dart';
import 'package:axis_crm/entity/project.dart';

part 'projects_state.dart';

class ProjectsCubit extends Cubit<ProjectsState> {
  ProjectsCubit({required ApiClient apiClient})
      : _apiClient = apiClient,
        super(const ProjectsState());

  final ApiClient _apiClient;

  Future<void> loadProjects({String? status}) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final response = await _apiClient.listProjects(status, null, null, null, null);
      emit(state.copyWith(isLoading: false, projects: response.data));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> createProject(CreateProjectRequest request) async {
    try {
      await _apiClient.createProject(request);
      await loadProjects();
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}