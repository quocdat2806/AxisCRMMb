part of 'worksheet_cubit.dart';

enum AttendanceType { worked, absent, half, empty }

class AttendanceDay extends Equatable {
  const AttendanceDay({
    required this.day,
    required this.type,
    this.note,
    this.date,
  });

  final int day;
  final AttendanceType type;
  final String? note;
  final DateTime? date;

  @override
  List<Object?> get props => <Object?>[day, type, note, date];
}

class WorksheetState extends Equatable {
  const WorksheetState({
    required this.user,
    required this.currentMonth,
    required this.attendanceDays,
    required this.isLoading,
    this.error,
    required this.fullDays,
    required this.halfDays,
    required this.absentDays,
  });

  final User user;
  final DateTime currentMonth;
  final List<AttendanceDay> attendanceDays;
  final bool isLoading;
  final String? error;
  final int fullDays;
  final int halfDays;
  final int absentDays;

  factory WorksheetState.initial({required User user}) {
    final DateTime now = DateTime.now();
    return WorksheetState(
      user: user,
      currentMonth: AppDateUtils.getFirstDayOfLunarMonth(now),
      attendanceDays: const <AttendanceDay>[],
      isLoading: false,
      error: null,
      fullDays: 0,
      halfDays: 0,
      absentDays: 0,
    );
  }

  WorksheetState copyWith({
    User? user,
    DateTime? currentMonth,
    List<AttendanceDay>? attendanceDays,
    bool? isLoading,
    String? error,
    int? fullDays,
    int? halfDays,
    int? absentDays,
  }) {
    return WorksheetState(
      user: user ?? this.user,
      currentMonth: currentMonth ?? this.currentMonth,
      attendanceDays: attendanceDays ?? this.attendanceDays,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      fullDays: fullDays ?? this.fullDays,
      halfDays: halfDays ?? this.halfDays,
      absentDays: absentDays ?? this.absentDays,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    user,
    currentMonth,
    attendanceDays,
    isLoading,
    error,
    fullDays,
    halfDays,
    absentDays,
  ];
}