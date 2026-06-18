part of 'admin_worksheet_cubit.dart';

class AdminWorksheetState extends Equatable {
  const AdminWorksheetState({
    required this.workers,
    required this.selectedWorkerId,
    required this.selectedWorkerName,
    required this.date,
    required this.shiftType,
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
  final DateTime date;
  final String shiftType;
  final String note;
  final bool isLoadingWorkers;
  final bool isSubmitting;
  final bool submitSuccess;
  final String? submitError;
  final String? error;

  factory AdminWorksheetState.initial({String? preselectedUserId, String? preselectedUserName}) {
    return AdminWorksheetState(
      workers: const [],
      selectedWorkerId: preselectedUserId,
      selectedWorkerName: preselectedUserName,
      date: DateTime.now(),
      shiftType: 'full',
      note: '',
      isLoadingWorkers: preselectedUserId != null,
      isSubmitting: false,
      submitSuccess: false,
      submitError: null,
      error: null,
    );
  }

  AdminWorksheetState copyWith({
    List<User>? workers,
    String? selectedWorkerId,
    String? selectedWorkerName,
    DateTime? date,
    String? shiftType,
    String? note,
    bool? isLoadingWorkers,
    bool? isSubmitting,
    bool? submitSuccess,
    String? submitError,
    String? error,
  }) {
    return AdminWorksheetState(
      workers: workers ?? this.workers,
      selectedWorkerId: selectedWorkerId ?? this.selectedWorkerId,
      selectedWorkerName: selectedWorkerName ?? this.selectedWorkerName,
      date: date ?? this.date,
      shiftType: shiftType ?? this.shiftType,
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
    date,
    shiftType,
    note,
    isLoadingWorkers,
    isSubmitting,
    submitSuccess,
    submitError,
    error,
  ];
}