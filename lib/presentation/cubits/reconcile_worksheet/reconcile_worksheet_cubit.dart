import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'reconcile_worksheet_state.dart';

class ReconcileWorksheetCubit extends Cubit<ReconcileWorksheetState> {
  ReconcileWorksheetCubit({required ApiClient apiClient})
      : _apiClient = apiClient,
        super(ReconcileWorksheetState.initial()) {
    loadReconcileData();
  }

  final ApiClient _apiClient;

  Future<void> loadReconcileData() async {
    emit(state.copyWith(isLoading: true, error: null));
    final String formattedMonth = _formatApiMonth(state.currentMonth);

    try {
      final response = await _apiClient.getReconcileAttendance(formattedMonth);
      emit(state.copyWith(isLoading: false, data: response));
    } catch (e) {
      String errorMsg = 'Lấy dữ liệu đối chiếu thất bại';
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
      emit(state.copyWith(isLoading: false, error: errorMsg));
    }
  }

  void previousMonth() {
    final prevMonth = DateTime(state.currentMonth.year, state.currentMonth.month - 1);
    emit(state.copyWith(currentMonth: prevMonth));
    loadReconcileData();
  }

  void nextMonth() {
    final nextMonth = DateTime(state.currentMonth.year, state.currentMonth.month + 1);
    emit(state.copyWith(currentMonth: nextMonth));
    loadReconcileData();
  }

  String _formatApiMonth(DateTime date) {
    final String month = date.month.toString().padLeft(2, '0');
    return '${date.year}-$month';
  }
}
