part of 'user_advance_cubit.dart';

class UserAdvanceRequest extends Equatable {
  const UserAdvanceRequest({
    required this.id,
    required this.date,
    required this.amount,
    required this.reason,
  });

  final String id;
  final DateTime date;
  final int amount;
  final String reason;

  @override
  List<Object> get props => <Object>[id, date, amount, reason];
}

class UserAdvanceState extends Equatable {
  const UserAdvanceState({
    required this.advanceMonth,
    required this.workerAdvances,
    required this.workerPage,
    required this.hasMoreWorkerAdvances,
    required this.advanceAmount,
    required this.advanceReason,
    required this.advanceDate,
    required this.isLoading,
    this.error,
    required this.isSubmitting,
    this.submitSuccess = false,
    this.submitError,
  });

  final DateTime advanceMonth;
  final List<WorkerAdvanceItem> workerAdvances;
  final int workerPage;
  final bool hasMoreWorkerAdvances;
  final String advanceAmount;
  final String advanceReason;
  final DateTime advanceDate;
  final bool isLoading;
  final String? error;
  final bool isSubmitting;
  final bool submitSuccess;
  final String? submitError;

  factory UserAdvanceState.initial({bool isOwner = false, String? userId}) {
    final DateTime now = DateTime.now();
    return UserAdvanceState(
      advanceMonth: DateTime(now.year, now.month),
      workerAdvances: const <WorkerAdvanceItem>[],
      workerPage: 1,
      hasMoreWorkerAdvances: true,
      advanceAmount: '',
      advanceReason: '',
      advanceDate: now,
      isLoading: false,
      error: null,
      isSubmitting: false,
      submitSuccess: false,
      submitError: null,
    );
  }

  int get monthlyAdvanceTotal {
    return workerAdvances.fold<int>(
      0,
      (int total, item) => total + (item.workerAmount ?? 0),
    );
  }

  UserAdvanceState copyWith({
    DateTime? advanceMonth,
    List<WorkerAdvanceItem>? workerAdvances,
    int? workerPage,
    bool? hasMoreWorkerAdvances,
    String? advanceAmount,
    String? advanceReason,
    DateTime? advanceDate,
    bool? isLoading,
    String? error,
    List<Map<String, dynamic>>? projects,
    String? selectedProjectId,
    bool? isOwner,
    String? userId,
    bool? isSubmitting,
    bool? submitSuccess,
    String? submitError,
  }) {
    return UserAdvanceState(
      advanceMonth: advanceMonth ?? this.advanceMonth,
      workerAdvances: workerAdvances ?? this.workerAdvances,
      workerPage: workerPage ?? this.workerPage,
      hasMoreWorkerAdvances:
          hasMoreWorkerAdvances ?? this.hasMoreWorkerAdvances,
      advanceAmount: advanceAmount ?? this.advanceAmount,
      advanceReason: advanceReason ?? this.advanceReason,
      advanceDate: advanceDate ?? this.advanceDate,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submitSuccess: submitSuccess ?? this.submitSuccess,
      submitError: submitError,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    advanceMonth,
    workerAdvances,
    workerPage,
    hasMoreWorkerAdvances,
    advanceAmount,
    advanceReason,
    advanceDate,
    isLoading,
    error,
    isSubmitting,
    submitSuccess,
    submitError,
  ];
}
