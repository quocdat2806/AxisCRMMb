import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/entity/attendance_record.dart';
import 'package:axis_crm/entity/user.dart';

part 'worksheet_state.dart';

class WorksheetCubit extends Cubit<WorksheetState> {
  WorksheetCubit({required User user, required ApiClient apiClient})
    : _apiClient = apiClient,
      super(WorksheetState.initial(user: user)) {
    loadWorksheet();
  }

  final ApiClient _apiClient;

  void previousMonth() {
    emit(state.copyWith(currentMonth: _shiftMonth(state.currentMonth, -1)));
    loadWorksheet();
  }

  void nextMonth() {
    emit(state.copyWith(currentMonth: _shiftMonth(state.currentMonth, 1)));
    loadWorksheet();
  }

  Future<void> loadWorksheet() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final response = await _apiClient.getCurrentWorkerAttendanceRecords(
        _formatApiMonth(state.currentMonth),
        50,
      );

      final List<AttendanceDay> days = response.data.map((
        AttendanceRecord record,
      ) {
        final AttendanceType type = _typeFromShift(record);
        final String? note = record.workerNote;
        return AttendanceDay(day: record.date.day, type: type, note: note);
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

  DateTime _shiftMonth(DateTime source, int offset) {
    return DateTime(source.year, source.month + offset);
  }

  String _formatApiMonth(DateTime date) {
    final String month = date.month.toString().padLeft(2, '0');
    return '${date.year}-$month';
  }
}
