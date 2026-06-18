part of 'workers_detail_cubit.dart';

class WorkerAttendanceDay {
  final int day;
  final String shift;
  final String status;

  WorkerAttendanceDay({
    required this.day,
    required this.shift,
    required this.status,
  });
}

class WorkersDetailState extends Equatable {
  const WorkersDetailState({
    required this.user,
    required this.month,
    this.attendanceDays = const [],
    this.workerAdvanceRecords = const [],
    this.workerAdvancePage = 1,
    this.hasMoreWorkerAdvanceRecords = true,
    this.isLoading = false,
    this.error,
  });

  final User user;
  final DateTime month;
  final List<WorkerAttendanceDay> attendanceDays;
  final List<WorkerAdvanceItem> workerAdvanceRecords;
  final int workerAdvancePage;
  final bool hasMoreWorkerAdvanceRecords;
  final bool isLoading;
  final String? error;

  String get userId => user.id;

  factory WorkersDetailState.initial({required User user}) {
    final DateTime now = DateTime.now();
    return WorkersDetailState(
      user: user,
      month: DateTime(now.year, now.month),
    );
  }

  int get fullDays => attendanceDays.where((d) => d.shift == 'full').length;
  int get halfDays => attendanceDays.where((d) => d.shift == 'half').length;
  int get absentDays => attendanceDays.where((d) => d.shift == 'absent').length;

  WorkersDetailState copyWith({
    User? user,
    DateTime? month,
    List<WorkerAttendanceDay>? attendanceDays,
    List<WorkerAdvanceItem>? workerAdvanceRecords,
    int? workerAdvancePage,
    bool? hasMoreWorkerAdvanceRecords,
    bool? isLoading,
    String? error,
  }) {
    return WorkersDetailState(
      user: user ?? this.user,
      month: month ?? this.month,
      attendanceDays: attendanceDays ?? this.attendanceDays,
      workerAdvanceRecords: workerAdvanceRecords ?? this.workerAdvanceRecords,
      workerAdvancePage: workerAdvancePage ?? this.workerAdvancePage,
      hasMoreWorkerAdvanceRecords:
          hasMoreWorkerAdvanceRecords ?? this.hasMoreWorkerAdvanceRecords,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    user,
    month,
    attendanceDays,
    workerAdvanceRecords,
    workerAdvancePage,
    hasMoreWorkerAdvanceRecords,
    isLoading,
    error,
  ];
}

