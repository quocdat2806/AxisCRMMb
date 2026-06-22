import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/core/network/api_client_dto.dart';
import 'package:axis_crm/entity/user.dart';
import 'package:axis_crm/core/utils/date_until.dart';

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
      final DateTime firstDay = state.month;
      final List<DateTime?> lunarGridDays =
          AppDateUtils.generateLunarCalendarDays(firstDay);
      final List<DateTime> lunarDays = lunarGridDays
          .whereType<DateTime>()
          .toList();
      final DateTime lastDay = lunarDays.isEmpty ? firstDay : lunarDays.last;

      final String startDateStr = _formatApiDay(firstDay);
      final String endDateStr = _formatApiDay(lastDay);

      final response = await _apiClient.getAttendanceForUser(
        _userId,
        1,
        100,
        startDateStr,
        endDateStr,
      );

      final List<WorkerAttendanceDay> days = response.data.map((record) {
        final DateTime date = record.date;
        return WorkerAttendanceDay(
          day: date.day,
          shift: record.workerShift ?? record.shift ?? 'full',
          status: record.status,
          date: date,
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
    final DateTime firstDay = state.month;
    final List<DateTime?> lunarGridDays =
        AppDateUtils.generateLunarCalendarDays(firstDay);
    final List<DateTime> lunarDays = lunarGridDays
        .whereType<DateTime>()
        .toList();
    final DateTime lastDay = lunarDays.isEmpty ? firstDay : lunarDays.last;

    final String startDateStr = _formatApiDay(firstDay);
    final String endDateStr = _formatApiDay(lastDay);

    try {
      final response = await _apiClient.listWorkerAdvancesForUser(
        _userId,
        page,
        20,
        startDateStr,
        endDateStr,
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
    emit(state.copyWith(month: AppDateUtils.previousLunarMonth(state.month)));
    loadAttendance();
    loadWorkerAdvanceRecords();
  }

  void nextMonth() {
    emit(state.copyWith(month: AppDateUtils.nextLunarMonth(state.month)));
    loadAttendance();
    loadWorkerAdvanceRecords();
  }

  String _formatApiDay(DateTime date) {
    final String month = date.month.toString().padLeft(2, '0');
    final String day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }

  void refresh() {
    loadAttendance();
    loadWorkerAdvanceRecords(page: 1);
  }
}
