import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/core/network/api_client_dto.dart';
import 'package:axis_crm/core/events/event_bus.dart';

part 'time_keeping_state.dart';

class TimeKeepingCubit extends Cubit<TimeKeepingState> {
  TimeKeepingCubit() : super(TimeKeepingState.initial());

  void timeKeepingDateChanged(DateTime value) {
    emit(state.copyWith(timeKeepingDate: value));
  }

  void timeKeepingTypeChanged(String value) {
    emit(state.copyWith(timeKeepingType: value));
  }

  void timeKeepingReasonChanged(String value) {
    emit(state.copyWith(timeKeepingReason: value));
  }

  Future<void> submitTimeKeepingRequest() async {
    if (state.isSubmitting) return;
    emit(state.copyWith(isSubmitting: true, submitError: null));

    try {
      final dateStr =
          '${state.timeKeepingDate.year}-${state.timeKeepingDate.month.toString().padLeft(2, '0')}-${state.timeKeepingDate.day.toString().padLeft(2, '0')}';
      final shift = _getShiftValue(state.timeKeepingType);

      final response = await getIt<ApiClient>().createAttendance(
        CreateAttendanceRequest(
          date: dateStr,
          shift: shift,
          note: state.timeKeepingReason.isEmpty
              ? null
              : state.timeKeepingReason,
        ),
      );

      if (response.success) {
        emit(
          state.copyWith(
            isSubmitting: false,
            timeKeepingSubmitted: true,
            timeKeepingReason: '',
          ),
        );
        getIt<EventBus>().fire(WorksheetUpdatedEvent());
      } else {
        emit(
          state.copyWith(
            isSubmitting: false,
            submitError: response.message ?? 'Chấm công thất bại',
          ),
        );
      }
    } catch (e) {
      String errorMsg = 'Chấm công thất bại';
      if (e is DioException) {
        final responseData = e.response?.data;
        if (responseData is Map<String, dynamic> &&
            responseData['message'] is String) {
          errorMsg = responseData['message'] as String;
        } else {
          errorMsg = e.message ?? e.toString();
        }
      } else {
        errorMsg = e.toString();
      }
      emit(state.copyWith(isSubmitting: false, submitError: errorMsg));
    }
  }

  String _getShiftValue(String type) {
    switch (type) {
      case 'Cả ngày':
        return 'full';
      case 'Nửa ngày':
        return 'half';
      case 'Nghỉ':
        return 'absent';
      default:
        return 'full';
    }
  }

  void clearTimeKeepingMessage() {
    emit(state.copyWith(timeKeepingSubmitted: false, submitError: null));
  }
}
