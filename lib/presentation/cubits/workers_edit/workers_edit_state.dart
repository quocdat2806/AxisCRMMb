part of 'workers_edit_cubit.dart';

class WorkersEditState extends Equatable {
  const WorkersEditState({
    required this.user,
    this.nickname = '',
    this.dailyRate = '',
    this.isSubmitting = false,
    this.submitSuccess = false,
    this.submitError,
    this.updatedUser,
  });

  final User user;
  final String nickname;
  final String dailyRate;
  final bool isSubmitting;
  final bool submitSuccess;
  final String? submitError;
  final User? updatedUser;

  factory WorkersEditState.initial({
    required User user,
    required String currentDailyRate,
  }) {
    return WorkersEditState(
      user: user,
      nickname: user.nickname ?? '',
      dailyRate: currentDailyRate,
    );
  }

  WorkersEditState copyWith({
    String? nickname,
    String? dailyRate,
    bool? isSubmitting,
    bool? submitSuccess,
    String? submitError,
    User? updatedUser,
  }) {
    return WorkersEditState(
      user: user,
      nickname: nickname ?? this.nickname,
      dailyRate: dailyRate ?? this.dailyRate,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submitSuccess: submitSuccess ?? this.submitSuccess,
      submitError: submitError,
      updatedUser: updatedUser ?? this.updatedUser,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        user,
        nickname,
        dailyRate,
        isSubmitting,
        submitSuccess,
        submitError,
        updatedUser,
      ];
}

