import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/entity/user.dart';

part 'workers_edit_state.dart';

class WorkersEditCubit extends Cubit<WorkersEditState> {
  WorkersEditCubit({
    required ApiClient apiClient,
    required User user,
    required String currentDailyRate,
  }) : _apiClient = apiClient,
       super(
         WorkersEditState.initial(
           user: user,
           currentDailyRate: currentDailyRate,
         ),
       );

  final ApiClient _apiClient;

  void nicknameChanged(String value) {
    emit(state.copyWith(nickname: value));
  }

  void dailyRateChanged(String value) {
    emit(state.copyWith(dailyRate: value));
  }

  Future<void> submitUpdate() async {
    if (state.isSubmitting) return;
    if (state.nickname.trim().isEmpty || state.dailyRate.trim().isEmpty) return;

    final int? dailyRateInt = int.tryParse(
      state.dailyRate.replaceAll('.', '').replaceAll(',', ''),
    );
    if (dailyRateInt == null || dailyRateInt <= 0) return;

    emit(
      state.copyWith(
        isSubmitting: true,
        submitSuccess: false,
        submitError: null,
      ),
    );

    try {
      final response = await _apiClient.updateUser(
        state.user.id,
        <String, dynamic>{
          'nickname': state.nickname.trim(),
          'default_daily_rate': dailyRateInt,
        },
      );

      if (response.success) {
        // Nếu backend không trả về user thì tự construct từ thông tin cập nhật
        final updatedUser =
            response.user ??
            state.user.copyWith(
              nickname: state.nickname.trim(),
              defaultDailyRate: dailyRateInt,
            );

        emit(
          state.copyWith(
            isSubmitting: false,
            submitSuccess: true,
            updatedUser: updatedUser,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isSubmitting: false,
            submitError: response.message ?? 'Cập nhật thất bại',
          ),
        );
      }
    } catch (e) {
      String errorMsg = 'Cập nhật thất bại';
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

  void clearError() {
    emit(state.copyWith(submitError: null));
  }
}
