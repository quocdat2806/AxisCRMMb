import 'package:equatable/equatable.dart';
import 'package:axis_crm/core/network/api_client_dto.dart';
import 'package:axis_crm/core/utils/date_until.dart';

class ReconcileAdvanceState extends Equatable {
  const ReconcileAdvanceState({
    required this.currentMonth,
    this.isLoading = false,
    this.data,
    this.error,
  });

  final DateTime currentMonth;
  final bool isLoading;
  final ReconcileAdvanceResponse? data;
  final String? error;

  factory ReconcileAdvanceState.initial() {
    final now = DateTime.now();
    return ReconcileAdvanceState(
      currentMonth: AppDateUtils.getFirstDayOfLunarMonth(now),
    );
  }

  ReconcileAdvanceState copyWith({
    DateTime? currentMonth,
    bool? isLoading,
    ReconcileAdvanceResponse? data,
    String? error,
  }) {
    return ReconcileAdvanceState(
      currentMonth: currentMonth ?? this.currentMonth,
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      error: error,
    );
  }

  @override
  List<Object?> get props => [currentMonth, isLoading, data, error];
}
