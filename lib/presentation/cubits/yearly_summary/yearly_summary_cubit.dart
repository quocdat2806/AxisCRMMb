import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/entity/user.dart';
import 'yearly_summary_state.dart';

class YearlySummaryCubit extends Cubit<YearlySummaryState> {
  YearlySummaryCubit({
    required ApiClient apiClient,
    this.targetUser,
  })  : _apiClient = apiClient,
        super(YearlySummaryState.initial()) {
    loadYearlySummary();
  }

  final ApiClient _apiClient;
  final User? targetUser;

  Future<void> loadYearlySummary() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final response = targetUser != null
          ? await _apiClient.getUserYearlySummary(targetUser!.id, state.currentYear)
          : await _apiClient.getMyYearlySummary(state.currentYear);

      if (response.success) {
        emit(state.copyWith(isLoading: false, data: response.summary));
      } else {
        emit(state.copyWith(isLoading: false, error: 'Lấy dữ liệu tổng kết thất bại'));
      }
    } catch (e) {
      String errorMsg = 'Lấy dữ liệu tổng kết thất bại';
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

  void previousYear() {
    final int currentYearInt = int.tryParse(state.currentYear) ?? DateTime.now().year;
    emit(state.copyWith(currentYear: (currentYearInt - 1).toString()));
    loadYearlySummary();
  }

  void nextYear() {
    final int currentYearInt = int.tryParse(state.currentYear) ?? DateTime.now().year;
    emit(state.copyWith(currentYear: (currentYearInt + 1).toString()));
    loadYearlySummary();
  }
}
