import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/entity/user.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/events/event_bus.dart';

part 'admin_worksheet_state.dart';

class AdminWorksheetCubit extends Cubit<AdminWorksheetState> {
  AdminWorksheetCubit({
    required ApiClient apiClient,
    String? preselectedUserId,
    String? preselectedUserName,
  })  : _apiClient = apiClient,
        super(AdminWorksheetState.initial(
          preselectedUserId: preselectedUserId,
          preselectedUserName: preselectedUserName,
        )) {
    if (preselectedUserId == null) {
      loadWorkers();
    }
  }

  final ApiClient _apiClient;

  Future<void> loadWorkers() async {
    emit(state.copyWith(isLoadingWorkers: true));

    try {
      final response = await _apiClient.listUsers();
      emit(state.copyWith(
        isLoadingWorkers: false,
        workers: response.data,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingWorkers: false,
        error: e.toString(),
      ));
    }
  }

  void workerChanged(String? workerId) {
    emit(state.copyWith(selectedWorkerId: workerId));
  }

  void dateChanged(DateTime date) {
    emit(state.copyWith(date: date));
  }

  void shiftTypeChanged(String shiftType) {
    emit(state.copyWith(shiftType: shiftType));
  }

  void noteChanged(String note) {
    emit(state.copyWith(note: note));
  }

  Future<void> submit() async {
    if (state.isSubmitting) return;
    if (state.selectedWorkerId == null) return;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selectedDate = DateTime(state.date.year, state.date.month, state.date.day);

    if (selectedDate.isAfter(today)) {
      emit(state.copyWith(submitError: 'Không thể chấm công cho ngày tương lai'));
      return;
    }

    final String dateStr =
        '${state.date.year}-${state.date.month.toString().padLeft(2, '0')}-${state.date.day.toString().padLeft(2, '0')}';

    emit(state.copyWith(isSubmitting: true, submitError: null, submitSuccess: false));

    try {
      final response = await _apiClient.adminCreateAttendance(<String, dynamic>{
        'user_id': state.selectedWorkerId,
        'date': dateStr,
        'shift': state.shiftType,
        'note': state.note.isEmpty ? null : state.note,
      });

      if (response.success) {
        emit(state.copyWith(
          isSubmitting: false,
          submitSuccess: true,
        ));
        getIt<EventBus>().fire(WorksheetUpdatedEvent());
      } else {
        emit(state.copyWith(
          isSubmitting: false,
          submitError: response.message ?? 'Gửi duyệt thất bại',
        ));
      }
    } catch (e) {
      String errorMsg = 'Gửi duyệt thất bại';
      if (e is DioException) {
        final responseData = e.response?.data;
        if (responseData is Map<String, dynamic> && responseData['message'] is String) {
          errorMsg = responseData['message'] as String;
        } else {
          errorMsg = e.message ?? e.toString();
        }
      } else {
        errorMsg = e.toString();
      }
      emit(state.copyWith(
        isSubmitting: false,
        submitError: errorMsg,
      ));
    }
  }

  void resetForm() {
    emit(state.copyWith(
      shiftType: 'full',
      note: '',
      date: DateTime.now(),
      submitSuccess: false,
      submitError: null,
    ));
  }

  void clearError() {
    emit(state.copyWith(submitError: null));
  }
}