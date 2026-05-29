part of 'leave_cubit.dart';

class LeaveState extends Equatable {
  const LeaveState({
    required this.leaveDate,
    required this.leaveReason,
    required this.leaveSubmitted,
  });

  final DateTime leaveDate;
  final String leaveReason;
  final bool leaveSubmitted;

  factory LeaveState.initial() {
    return LeaveState(
      leaveDate: DateTime.now(),
      leaveReason: '',
      leaveSubmitted: false,
    );
  }

  LeaveState copyWith({
    DateTime? leaveDate,
    String? leaveReason,
    bool? leaveSubmitted,
  }) {
    return LeaveState(
      leaveDate: leaveDate ?? this.leaveDate,
      leaveReason: leaveReason ?? this.leaveReason,
      leaveSubmitted: leaveSubmitted ?? this.leaveSubmitted,
    );
  }

  @override
  List<Object> get props => <Object>[leaveDate, leaveReason, leaveSubmitted];
}