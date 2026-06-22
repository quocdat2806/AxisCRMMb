import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/entity/user.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/events/event_bus.dart';

part 'admin_advance_state.dart';

class AdminAdvanceCubit extends Cubit<AdminAdvanceState> {
  AdminAdvanceCubit({
    required ApiClient apiClient,
    String? preselectedUserId,
    String? preselectedUserName,
  })  : _apiClient = apiClient,
        super(AdminAdvanceState.initial(
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
      final List<User> workers = response.data;

      emit(state.copyWith(
        isLoadingWorkers: false,
        workers: workers,
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

  void amountChanged(String amount) {
    final String digitsOnly = amount.replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.isEmpty) {
      emit(state.copyWith(amount: ''));
      return;
    }
    final int value = int.tryParse(digitsOnly) ?? 0;
    final String formatted = value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
    emit(state.copyWith(amount: formatted));
  }

  void dateChanged(DateTime date) {
    emit(state.copyWith(date: date));
  }

  void noteChanged(String note) {
    emit(state.copyWith(note: note));
  }

  Future<void> submit() async {
    if (state.isSubmitting) return;
    if (state.selectedWorkerId == null || state.amount.isEmpty) return;

    final int? amountInt = int.tryParse(state.amount.replaceAll('.', '').replaceAll(',', ''));
    if (amountInt == null || amountInt <= 0) return;

    final String dateStr =
        '${state.date.year}-${state.date.month.toString().padLeft(2, '0')}-${state.date.day.toString().padLeft(2, '0')}';

    emit(state.copyWith(isSubmitting: true, submitSuccess: false, submitError: null));

    try {
      final response = await _apiClient.adminCreateWorkerAdvance(<String, dynamic>{
        'user_id': state.selectedWorkerId,
        'amount': amountInt,
        'date': dateStr,
        'note': state.note.isEmpty ? null : state.note,
      });

      if (response.success) {
        emit(state.copyWith(
          isSubmitting: false,
          submitSuccess: true,
        ));
        getIt<EventBus>().fire(AdvanceUpdatedEvent());
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
      amount: '',
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