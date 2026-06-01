part of 'worksheet_cubit.dart';

enum AttendanceType { worked, absent, half, empty }

class AttendanceDay extends Equatable {
  const AttendanceDay({required this.day, required this.type});

  final int day;
  final AttendanceType type;

  @override
  List<Object> get props => <Object>[day, type];
}

class WorksheetState extends Equatable {
  const WorksheetState({
    required this.user,
    required this.homeMonth,
    required this.accumulatedAmount,
    required this.attendanceDays,
    required this.isLoading,
    this.error,
  });

  final User user;
  final DateTime homeMonth;
  final int accumulatedAmount;
  final List<DailySummary> attendanceDays;
  final bool isLoading;
  final String? error;

  factory WorksheetState.initial({required User user}) {
    final DateTime now = DateTime.now();
    return WorksheetState(
      user: user,
      homeMonth: DateTime(now.year, now.month),
      accumulatedAmount: 0,
      attendanceDays: const <DailySummary>[],
      isLoading: false,
      error: null,
    );
  }

  WorksheetState copyWith({
    User? user,
    DateTime? homeMonth,
    int? accumulatedAmount,
    List<DailySummary>? attendanceDays,
    bool? isLoading,
    String? error,
  }) {
    return WorksheetState(
      user: user ?? this.user,
      homeMonth: homeMonth ?? this.homeMonth,
      accumulatedAmount: accumulatedAmount ?? this.accumulatedAmount,
      attendanceDays: attendanceDays ?? this.attendanceDays,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    user,
    homeMonth,
    accumulatedAmount,
    attendanceDays,
    isLoading,
    error,
  ];
}
