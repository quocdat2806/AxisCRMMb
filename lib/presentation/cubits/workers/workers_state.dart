part of 'workers_cubit.dart';

class WorkersState extends Equatable {
  const WorkersState({
    this.activeUsers = const <User>[],
    this.hiddenUsers = const <User>[],
    this.isLoading = false,
    this.error,
  });

  final List<User> activeUsers;
  final List<User> hiddenUsers;
  final bool isLoading;
  final String? error;

  WorkersState copyWith({
    List<User>? activeUsers,
    List<User>? hiddenUsers,
    bool? isLoading,
    String? error,
  }) {
    return WorkersState(
      activeUsers: activeUsers ?? this.activeUsers,
      hiddenUsers: hiddenUsers ?? this.hiddenUsers,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => <Object?>[activeUsers, hiddenUsers, isLoading, error];
}