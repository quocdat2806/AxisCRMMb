import 'package:equatable/equatable.dart';
import 'package:axis_crm/core/network/api_client_dto.dart';

class YearlySummaryState extends Equatable {
  const YearlySummaryState({
    required this.currentYear,
    this.isLoading = false,
    this.data,
    this.error,
  });

  final String currentYear;
  final bool isLoading;
  final YearlySummaryData? data;
  final String? error;

  factory YearlySummaryState.initial() {
    return YearlySummaryState(
      currentYear: DateTime.now().year.toString(),
    );
  }

  YearlySummaryState copyWith({
    String? currentYear,
    bool? isLoading,
    YearlySummaryData? data,
    String? error,
  }) {
    return YearlySummaryState(
      currentYear: currentYear ?? this.currentYear,
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      error: error,
    );
  }

  @override
  List<Object?> get props => [currentYear, isLoading, data, error];
}
