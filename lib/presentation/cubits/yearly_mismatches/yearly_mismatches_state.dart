import 'package:equatable/equatable.dart';
import 'package:axis_crm/core/network/api_client_dto.dart';

class YearlyMismatchesState extends Equatable {
  const YearlyMismatchesState({
    this.isLoading = false,
    this.data,
    this.error,
  });

  final bool isLoading;
  final YearlyMismatchesResponse? data;
  final String? error;

  factory YearlyMismatchesState.initial() {
    return const YearlyMismatchesState();
  }

  YearlyMismatchesState copyWith({
    bool? isLoading,
    YearlyMismatchesResponse? data,
    String? error,
  }) {
    return YearlyMismatchesState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, data, error];
}
