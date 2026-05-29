part of 'workers_detail_cubit.dart';

class WorkersDetailState extends Equatable {
  const WorkersDetailState({
    required this.userId,
    required this.month,
    this.summary,
    this.isLoading = false,
    this.error,
  });

  final String userId;
  final DateTime month;
  final WorkerMonthlySummary? summary;
  final bool isLoading;
  final String? error;

  factory WorkersDetailState.initial({required String userId}) {
    final DateTime now = DateTime.now();
    return WorkersDetailState(
      userId: userId,
      month: DateTime(now.year, now.month),
    );
  }

  WorkersDetailState copyWith({
    String? userId,
    DateTime? month,
    WorkerMonthlySummary? summary,
    bool? isLoading,
    String? error,
  }) {
    return WorkersDetailState(
      userId: userId ?? this.userId,
      month: month ?? this.month,
      summary: summary ?? this.summary,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => <Object?>[userId, month, summary, isLoading, error];
}