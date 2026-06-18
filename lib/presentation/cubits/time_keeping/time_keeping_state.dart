part of 'time_keeping_cubit.dart';

class TimeKeepingState extends Equatable {
  const TimeKeepingState({
    required this.timeKeepingDate,
    required this.timeKeepingType,
    required this.timeKeepingReason,
    required this.timeKeepingSubmitted,
    required this.isSubmitting,
    this.submitError,
  });

  final DateTime timeKeepingDate;
  final String timeKeepingType;
  final String timeKeepingReason;
  final bool timeKeepingSubmitted;
  final bool isSubmitting;
  final String? submitError;

  factory TimeKeepingState.initial() {
    return TimeKeepingState(
      timeKeepingDate: DateTime.now(),
      timeKeepingType: 'Cả ngày',
      timeKeepingReason: '',
      timeKeepingSubmitted: false,
      isSubmitting: false,
      submitError: null,
    );
  }

  TimeKeepingState copyWith({
    DateTime? timeKeepingDate,
    String? timeKeepingType,
    String? timeKeepingReason,
    bool? timeKeepingSubmitted,
    bool? isSubmitting,
    String? submitError,
  }) {
    return TimeKeepingState(
      timeKeepingDate: timeKeepingDate ?? this.timeKeepingDate,
      timeKeepingType: timeKeepingType ?? this.timeKeepingType,
      timeKeepingReason: timeKeepingReason ?? this.timeKeepingReason,
      timeKeepingSubmitted: timeKeepingSubmitted ?? this.timeKeepingSubmitted,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submitError: submitError,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    timeKeepingDate,
    timeKeepingType,
    timeKeepingReason,
    timeKeepingSubmitted,
    isSubmitting,
    submitError,
  ];
}