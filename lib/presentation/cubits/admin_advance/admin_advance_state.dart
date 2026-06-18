part of 'admin_advance_cubit.dart';

class AdminAdvanceState extends Equatable {
  const AdminAdvanceState({
    required this.workers,
    required this.selectedWorkerId,
    required this.selectedWorkerName,
    required this.amount,
    required this.date,
    required this.note,
    required this.isLoadingWorkers,
    required this.isSubmitting,
    this.submitSuccess = false,
    this.submitError,
    this.error,
  });

  final List<User> workers;
  final String? selectedWorkerId;
  final String? selectedWorkerName;
  final String amount;
  final DateTime date;
  final String note;
  final bool isLoadingWorkers;
  final bool isSubmitting;
  final bool submitSuccess;
  final String? submitError;
  final String? error;

  factory AdminAdvanceState.initial({String? preselectedUserId, String? preselectedUserName}) {
    return AdminAdvanceState(
      workers: const [],
      selectedWorkerId: preselectedUserId,
      selectedWorkerName: preselectedUserName,
      amount: '',
      date: DateTime.now(),
      note: '',
      isLoadingWorkers: preselectedUserId != null,
      isSubmitting: false,
      submitSuccess: false,
      submitError: null,
      error: null,
    );
  }

  AdminAdvanceState copyWith({
    List<User>? workers,
    String? selectedWorkerId,
    String? selectedWorkerName,
    String? amount,
    DateTime? date,
    String? note,
    bool? isLoadingWorkers,
    bool? isSubmitting,
    bool? submitSuccess,
    String? submitError,
    String? error,
  }) {
    return AdminAdvanceState(
      workers: workers ?? this.workers,
      selectedWorkerId: selectedWorkerId ?? this.selectedWorkerId,
      selectedWorkerName: selectedWorkerName ?? this.selectedWorkerName,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      note: note ?? this.note,
      isLoadingWorkers: isLoadingWorkers ?? this.isLoadingWorkers,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submitSuccess: submitSuccess ?? this.submitSuccess,
      submitError: submitError,
      error: error,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    workers,
    selectedWorkerId,
    selectedWorkerName,
    amount,
    date,
    note,
    isLoadingWorkers,
    isSubmitting,
    submitSuccess,
    submitError,
    error,
  ];
}