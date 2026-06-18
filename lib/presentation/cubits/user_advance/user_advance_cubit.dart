import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/core/network/api_client_dto.dart';

part 'user_advance_state.dart';

class UserAdvanceCubit extends Cubit<UserAdvanceState> {
  UserAdvanceCubit({bool isOwner = false, String? userId})
    : super(UserAdvanceState.initial()) {
    loadWorkerAdvances();
  }

  void previousAdvanceMonth() {
    emit(state.copyWith(advanceMonth: _shiftMonth(state.advanceMonth, -1)));
    loadWorkerAdvances();
  }

  void nextAdvanceMonth() {
    emit(state.copyWith(advanceMonth: _shiftMonth(state.advanceMonth, 1)));
    loadWorkerAdvances();
  }

  Future<void> loadWorkerAdvances({int page = 1}) async {
    if (isClosed) return;
    if (page == 1) {
      emit(state.copyWith(isLoading: true, error: null));
    }

    try {
      final response = await getIt<ApiClient>().getWorkerAdvances(
        _formatApiMonth(state.advanceMonth),
        page,
        100,
      );

      if (isClosed) return;

      final List<WorkerAdvanceItem> advances = response.data;

      final bool hasMore = advances.length >= 100;

      if (page == 1) {
        emit(
          state.copyWith(
            isLoading: false,
            workerAdvances: advances,
            workerPage: page,
            hasMoreWorkerAdvances: hasMore,
          ),
        );
      } else {
        emit(
          state.copyWith(
            workerAdvances: [...state.workerAdvances, ...advances],
            workerPage: page,
            hasMoreWorkerAdvances: hasMore,
          ),
        );
      }
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> loadMoreWorkerAdvances() async {
    if (!state.hasMoreWorkerAdvances) return;
    await loadWorkerAdvances(page: state.workerPage + 1);
  }

  Future<void> loadProjects() async {
    try {
      final response = await getIt<ApiClient>().listProjects('active', null, null, null, null);
      final List<Map<String, dynamic>> projects = response.data
          .map((p) => <String, dynamic>{'id': p.id, 'name': p.name})
          .toList();
      emit(state.copyWith(projects: projects));
    } catch (e) {
      // ignore error
    }
  }

  void advanceAmountChanged(String value) {
    emit(state.copyWith(advanceAmount: value));
  }

  void advanceReasonChanged(String value) {
    emit(state.copyWith(advanceReason: value));
  }

  void advanceDateChanged(DateTime value) {
    emit(state.copyWith(advanceDate: value));
  }

  void selectedProjectChanged(String? projectId) {
    emit(state.copyWith(selectedProjectId: projectId));
  }

  Future<void> createAdvance() async {
    if (state.isSubmitting) return;

    final int amount =
        int.tryParse(
          state.advanceAmount.replaceAll('.', '').replaceAll(',', ''),
        ) ??
        0;
    if (amount <= 0) return;

    emit(state.copyWith(isSubmitting: true, submitError: null));

    try {
      final dateStr =
          '${state.advanceDate.year}-${state.advanceDate.month.toString().padLeft(2, '0')}-${state.advanceDate.day.toString().padLeft(2, '0')}';

      bool success;
      String? errorMessage;

      final response = await getIt<ApiClient>()
          .createWorkerAdvance(<String, dynamic>{
            'amount': amount,
            'date': dateStr,
            'note': state.advanceReason.isEmpty ? null : state.advanceReason,
          });
      success = response.success;
      errorMessage = response.message;

      if (isClosed) return;

      if (success) {
        emit(
          state.copyWith(
            isSubmitting: false,
            submitSuccess: true,
            advanceAmount: '',
            advanceReason: '',
            advanceDate: DateTime.now(),
            selectedProjectId: null,
          ),
        );
        if (!isClosed) loadWorkerAdvances();
      } else {
        emit(
          state.copyWith(
            isSubmitting: false,
            submitError: errorMessage ?? 'Tạo ứng tiền thất bại',
          ),
        );
      }
    } catch (e) {
      if (isClosed) return;
      String errorMsg = 'Tạo ứng tiền thất bại';
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

  void clearSubmitStatus() {
    emit(state.copyWith(submitSuccess: false, submitError: null));
  }

  DateTime _shiftMonth(DateTime source, int offset) {
    return DateTime(source.year, source.month + offset);
  }

  String _formatApiMonth(DateTime date) {
    final String month = date.month.toString().padLeft(2, '0');
    return '${date.year}-$month';
  }
}
