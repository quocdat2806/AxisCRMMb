import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/entity/attendance_record.dart';
import 'package:axis_crm/entity/user.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/events/event_bus.dart';
import 'package:axis_crm/core/utils/date_until.dart';

part 'worksheet_state.dart';

class WorksheetCubit extends Cubit<WorksheetState> {
  WorksheetCubit({required User user, required ApiClient apiClient})
    : _apiClient = apiClient,
      super(WorksheetState.initial(user: user)) {
    loadWorksheet();
    _subscribeEvents();
  }

  final ApiClient _apiClient;
  StreamSubscription<WorksheetUpdatedEvent>? _eventSubscription;

  void _subscribeEvents() {
    _eventSubscription = getIt<EventBus>().on<WorksheetUpdatedEvent>().listen((event) {
      loadWorksheet();
    });
  }

  @override
  Future<void> close() {
    _eventSubscription?.cancel();
    return super.close();
  }

  void previousMonth() {
    emit(state.copyWith(currentMonth: AppDateUtils.previousLunarMonth(state.currentMonth)));
    loadWorksheet();
  }

  void nextMonth() {
    emit(state.copyWith(currentMonth: AppDateUtils.nextLunarMonth(state.currentMonth)));
    loadWorksheet();
  }

  Future<void> loadWorksheet() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final DateTime firstDay = state.currentMonth;
      final List<DateTime?> lunarGridDays = AppDateUtils.generateLunarCalendarDays(firstDay);
      final List<DateTime> lunarDays = lunarGridDays.whereType<DateTime>().toList();
      final DateTime lastDay = lunarDays.isEmpty ? firstDay : lunarDays.last;

      final String startDateStr = _formatApiDay(firstDay);
      final String endDateStr = _formatApiDay(lastDay);

      final response = await _apiClient.getCurrentWorkerAttendanceRecords(
        100,
        startDateStr,
        endDateStr,
      );

      final List<AttendanceDay> days = response.data.map((
        AttendanceRecord record,
      ) {
        final AttendanceType type = _typeFromShift(record);
        final String? note = record.workerNote;
        return AttendanceDay(
          day: record.date.day,
          type: type,
          note: note,
          date: record.date,
        );
      }).toList();

      int fullCount = 0;
      int halfCount = 0;
      int absentCount = 0;

      for (final AttendanceDay day in days) {
        switch (day.type) {
          case AttendanceType.worked:
            fullCount++;
            break;
          case AttendanceType.half:
            halfCount++;
            break;
          case AttendanceType.absent:
            absentCount++;
            break;
          default:
            break;
        }
      }

      emit(
        state.copyWith(
          isLoading: false,
          attendanceDays: days,
          fullDays: fullCount,
          halfDays: halfCount,
          absentDays: absentCount,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  AttendanceType _typeFromShift(AttendanceRecord record) {
    final String? effectiveShift = record.shift ?? record.workerShift;

    if (effectiveShift == null) {
      return AttendanceType.empty;
    }

    switch (effectiveShift) {
      case 'full':
        return AttendanceType.worked;
      case 'half':
        return AttendanceType.half;
      case 'absent':
        return AttendanceType.absent;
      default:
        return AttendanceType.empty;
    }
  }

  String _formatApiDay(DateTime date) {
    final String month = date.month.toString().padLeft(2, '0');
    final String day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }
}
