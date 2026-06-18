import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/entity/user.dart';
import 'yearly_mismatches_state.dart';

class YearlyMismatchesCubit extends Cubit<YearlyMismatchesState> {
  YearlyMismatchesCubit({
    required ApiClient apiClient,
    required this.year,
    this.targetUser,
  })  : _apiClient = apiClient,
        super(YearlyMismatchesState.initial()) {
    loadYearlyMismatches();
  }

  final ApiClient _apiClient;
  final String year;
  final User? targetUser;

  Future<void> loadYearlyMismatches() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final response = targetUser != null
          ? await _apiClient.getUserYearlyMismatches(targetUser!.id, year)
          : await _apiClient.getMyYearlyMismatches(year);

      if (response.success ?? true) {
        emit(state.copyWith(isLoading: false, data: response));
      } else {
        emit(state.copyWith(isLoading: false, error: 'Lấy dữ liệu ngày lệch thất bại'));
      }
    } catch (e) {
      String errorMsg = 'Lấy dữ liệu ngày lệch thất bại';
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
}
