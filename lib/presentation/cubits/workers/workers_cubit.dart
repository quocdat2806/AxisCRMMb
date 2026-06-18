import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/entity/user.dart';

part 'workers_state.dart';

class WorkersCubit extends Cubit<WorkersState> {
  WorkersCubit({required ApiClient apiClient})
      : _apiClient = apiClient,
        super(const WorkersState());

  final ApiClient _apiClient;

  Future<void> loadWorkers() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final response = await _apiClient.listUsers();
      emit(state.copyWith(isLoading: false, users: response.data));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}