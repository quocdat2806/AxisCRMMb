import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/core/network/api_client_dto.dart';
import 'package:axis_crm/entity/project.dart';

part 'project_detail_state.dart';

class ProjectDetailCubit extends Cubit<ProjectDetailState> {
  ProjectDetailCubit({
    required ApiClient apiClient,
    required Project project,
  })  : _apiClient = apiClient,
        _project = project,
        super(ProjectDetailState(project: project));

  final ApiClient _apiClient;
  final Project _project;

  Future<void> loadProjectDetail() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final advancesResponse = await _apiClient.listProjectAdvances(
        _project.id,
        null,
        null,
        null,
        null,
        null,
        null,
      );

      emit(state.copyWith(
        isLoading: false,
        advances: advancesResponse.data,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> createProjectAdvance(CreateProjectAdvanceRequest request) async {
    try {
      await _apiClient.createProjectAdvance(request);
      await loadProjectDetail();
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}