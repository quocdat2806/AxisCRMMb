import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/entity/worker_monthly_summary.dart';

part 'workers_detail_state.dart';

class WorkersDetailCubit extends Cubit<WorkersDetailState> {
  WorkersDetailCubit({
    required String userId,
    required ApiClient apiClient,
  })  : _userId = userId,
        _apiClient = apiClient,
        super(WorkersDetailState.initial(userId: userId)) {
    loadSummary();
  }

  final String _userId;
  final ApiClient _apiClient;

  Future<void> loadSummary() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final response = await _apiClient.getWorkerSummary(
        _userId,
        _formatApiMonth(state.month),
      );
      emit(state.copyWith(isLoading: false, summary: response.summary));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void previousMonth() {
    emit(state.copyWith(month: _shiftMonth(state.month, -1)));
    loadSummary();
  }

  void nextMonth() {
    emit(state.copyWith(month: _shiftMonth(state.month, 1)));
    loadSummary();
  }

  DateTime _shiftMonth(DateTime source, int offset) {
    return DateTime(source.year, source.month + offset);
  }

  String _formatApiMonth(DateTime date) {
    final String month = date.month.toString().padLeft(2, '0');
    return '${date.year}-$month';
  }
}