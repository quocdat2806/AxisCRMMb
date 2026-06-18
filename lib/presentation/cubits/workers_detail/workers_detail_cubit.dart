import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/core/network/api_client_dto.dart';
import 'package:axis_crm/entity/user.dart';

part 'workers_detail_state.dart';

class WorkersDetailCubit extends Cubit<WorkersDetailState> {
  WorkersDetailCubit({required User user, required ApiClient apiClient})
    : _apiClient = apiClient,
      super(WorkersDetailState.initial(user: user)) {
    loadAttendance();
    loadWorkerAdvanceRecords();
  }

  final ApiClient _apiClient;

  String get _userId => state.user.id;

  void updateUser(User user) {
    emit(state.copyWith(user: user));
  }

  Future<void> loadAttendance() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final response = await _apiClient.getAttendanceForUser(
        _userId,
        _formatApiMonth(state.month),
        1,
        100,
      );

      final List<WorkerAttendanceDay> days = response.data.map((record) {
        final DateTime date = record.date;
        return WorkerAttendanceDay(
          day: date.day,
          shift: record.workerShift ?? record.shift ?? 'full',
          status: record.status,
        );
      }).toList();

      emit(state.copyWith(isLoading: false, attendanceDays: days));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> loadWorkerAdvanceRecords({int page = 1}) async {
    if (page == 1) {
      emit(state.copyWith(isLoading: true, error: null));
    }
    final String apiMonth = _formatApiMonth(state.month);

    try {
      final response = await _apiClient.listWorkerAdvancesForUser(
        _userId,
        apiMonth,
        page,
        20,
      );

      final bool hasMore = response.data.length >= 20;

      if (page == 1) {
        emit(
          state.copyWith(
            isLoading: false,
            workerAdvanceRecords: response.data,
            workerAdvancePage: page,
            hasMoreWorkerAdvanceRecords: hasMore,
          ),
        );
      } else {
        emit(
          state.copyWith(
            workerAdvanceRecords: [
              ...state.workerAdvanceRecords,
              ...response.data,
            ],
            workerAdvancePage: page,
            hasMoreWorkerAdvanceRecords: hasMore,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> loadMoreWorkerAdvanceRecords() async {
    if (!state.hasMoreWorkerAdvanceRecords) return;
    await loadWorkerAdvanceRecords(page: state.workerAdvancePage + 1);
  }

  void previousMonth() {
    emit(state.copyWith(month: _shiftMonth(state.month, -1)));
    loadAttendance();
    loadWorkerAdvanceRecords();
  }

  void nextMonth() {
    emit(state.copyWith(month: _shiftMonth(state.month, 1)));
    loadAttendance();
    loadWorkerAdvanceRecords();
  }

  DateTime _shiftMonth(DateTime source, int offset) {
    return DateTime(source.year, source.month + offset);
  }

  String _formatApiMonth(DateTime date) {
    final String month = date.month.toString().padLeft(2, '0');
    return '${date.year}-$month';
  }

  void refresh() {
    loadAttendance();
    loadWorkerAdvanceRecords(page: 1);
  }
}
