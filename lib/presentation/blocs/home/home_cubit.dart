import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/entity/daily_summary.dart';
import 'package:axis_crm/entity/user.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required User user, required ApiClient apiClient})
    : _apiClient = apiClient,
      super(HomeState.initial(user: user)) {
    loadSummary();
  }

  final ApiClient _apiClient;

  void previousHomeMonth() {
    emit(state.copyWith(homeMonth: _shiftMonth(state.homeMonth, -1)));
    loadSummary();
  }

  void nextHomeMonth() {
    emit(state.copyWith(homeMonth: _shiftMonth(state.homeMonth, 1)));
    loadSummary();
  }

  Future<void> loadSummary() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final response = await _apiClient.getCurrentWorkerSummary(
        _formatApiMonth(state.homeMonth),
      );

      emit(
        state.copyWith(
          isLoading: false,
          accumulatedAmount: response.summary.totalEarned,
          attendanceDays: response.summary.days,
        ),
      );
    } catch (e) {
      print('Error loading summary: $e');
      emit(state.copyWith(isLoading: false, error: e.toString()));
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
