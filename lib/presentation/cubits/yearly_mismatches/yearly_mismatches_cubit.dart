import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/entity/user.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/events/event_bus.dart';
import 'package:lunar/lunar.dart';
import 'yearly_mismatches_state.dart';

class YearlyMismatchesCubit extends Cubit<YearlyMismatchesState> {
  YearlyMismatchesCubit({
    required ApiClient apiClient,
    required this.year,
    this.targetUser,
  })  : _apiClient = apiClient,
        super(YearlyMismatchesState.initial()) {
    loadYearlyMismatches();
    _subscribeEvents();
  }

  final ApiClient _apiClient;
  final String year;
  final User? targetUser;
  StreamSubscription<WorksheetUpdatedEvent>? _eventSubscription;

  void _subscribeEvents() {
    _eventSubscription = getIt<EventBus>().on<WorksheetUpdatedEvent>().listen((event) {
      loadYearlyMismatches();
    });
  }

  @override
  Future<void> close() {
    _eventSubscription?.cancel();
    return super.close();
  }

  Future<void> loadYearlyMismatches() async {
    emit(state.copyWith(isLoading: true, error: null));

    final int yearInt = int.tryParse(year) ?? DateTime.now().year;
    final (String startDateStr, String endDateStr) = _getLunarYearRange(yearInt);

    try {
      final response = targetUser != null
          ? await _apiClient.getUserYearlyMismatches(targetUser!.id, null, startDateStr, endDateStr)
          : await _apiClient.getMyYearlyMismatches(null, startDateStr, endDateStr);

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

  (String, String) _getLunarYearRange(int lunarYear) {
    final LunarYear ly = LunarYear.fromYear(lunarYear);
    final List<LunarMonth> monthsInYear = ly.getMonthsInYear();

    final LunarMonth firstMonth = monthsInYear.first;
    final LunarMonth lastMonth = monthsInYear.last;

    final Lunar firstDayLunar = Lunar.fromYmd(lunarYear, firstMonth.getMonth().abs(), 1);
    final Solar firstDaySolar = firstDayLunar.getSolar();

    final int lastDayOfMonth = lastMonth.getDayCount();
    final Lunar lastDayLunar = Lunar.fromYmd(lunarYear, lastMonth.getMonth().abs(), lastDayOfMonth);
    final Solar lastDaySolar = lastDayLunar.getSolar();

    final String startDateStr = '${firstDaySolar.getYear()}-${firstDaySolar.getMonth().toString().padLeft(2, '0')}-${firstDaySolar.getDay().toString().padLeft(2, '0')}';
    final String endDateStr = '${lastDaySolar.getYear()}-${lastDaySolar.getMonth().toString().padLeft(2, '0')}-${lastDaySolar.getDay().toString().padLeft(2, '0')}';

    return (startDateStr, endDateStr);
  }
}
