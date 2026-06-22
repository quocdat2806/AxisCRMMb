import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/events/event_bus.dart';
import 'package:axis_crm/core/utils/date_until.dart';
import 'reconcile_advance_state.dart';

class ReconcileAdvanceCubit extends Cubit<ReconcileAdvanceState> {
  ReconcileAdvanceCubit({required ApiClient apiClient})
      : _apiClient = apiClient,
        super(ReconcileAdvanceState.initial()) {
    loadReconcileData();
    _subscribeEvents();
  }

  final ApiClient _apiClient;
  StreamSubscription<AdvanceUpdatedEvent>? _eventSubscription;

  void _subscribeEvents() {
    _eventSubscription = getIt<EventBus>().on<AdvanceUpdatedEvent>().listen((event) {
      loadReconcileData();
    });
  }

  @override
  Future<void> close() {
    _eventSubscription?.cancel();
    return super.close();
  }

  Future<void> loadReconcileData() async {
    emit(state.copyWith(isLoading: true, error: null));

    final DateTime firstDay = AppDateUtils.getFirstDayOfLunarMonth(state.currentMonth);
    final List<DateTime?> lunarGridDays = AppDateUtils.generateLunarCalendarDays(firstDay);
    final List<DateTime> lunarDays = lunarGridDays.whereType<DateTime>().toList();
    final DateTime lastDay = lunarDays.isEmpty ? firstDay : lunarDays.last;

    final String startDateStr = _formatApiDay(firstDay);
    final String endDateStr = _formatApiDay(lastDay);

    try {
      final response = await _apiClient.getReconcileAdvances(startDateStr, endDateStr);
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
    final prevMonth = AppDateUtils.previousLunarMonth(state.currentMonth);
    emit(state.copyWith(currentMonth: prevMonth));
    loadReconcileData();
  }

  void nextMonth() {
    final nextMonth = AppDateUtils.nextLunarMonth(state.currentMonth);
    emit(state.copyWith(currentMonth: nextMonth));
    loadReconcileData();
  }

  String _formatApiDay(DateTime date) {
    final String month = date.month.toString().padLeft(2, '0');
    final String day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }
}
