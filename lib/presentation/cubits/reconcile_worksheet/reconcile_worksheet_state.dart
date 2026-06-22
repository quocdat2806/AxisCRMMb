import 'package:equatable/equatable.dart';
import 'package:axis_crm/core/network/api_client_dto.dart';
import 'package:axis_crm/core/utils/date_until.dart';

class ReconcileWorksheetState extends Equatable {
  const ReconcileWorksheetState({
    required this.currentMonth,
    this.isLoading = false,
    this.data,
    this.error,
  });

  final DateTime currentMonth;
  final bool isLoading;
  final ReconcileResponse? data;
  final String? error;

  factory ReconcileWorksheetState.initial() {
    final now = DateTime.now();
    return ReconcileWorksheetState(
      currentMonth: AppDateUtils.getFirstDayOfLunarMonth(now),
    );
  }

  ReconcileWorksheetState copyWith({
    DateTime? currentMonth,
    bool? isLoading,
    ReconcileResponse? data,
    String? error,
  }) {
    return ReconcileWorksheetState(
      currentMonth: currentMonth ?? this.currentMonth,
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      error: error,
    );
  }

  @override
  List<Object?> get props => [currentMonth, isLoading, data, error];
}
