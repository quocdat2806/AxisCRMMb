part of 'workers_cubit.dart';

class WorkersState extends Equatable {
  const WorkersState({
    this.users = const <User>[],
    this.isLoading = false,
    this.error,
  });

  final List<User> users;
  final bool isLoading;
  final String? error;

  WorkersState copyWith({
    List<User>? users,
    bool? isLoading,
    String? error,
  }) {
    return WorkersState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => <Object?>[users, isLoading, error];
}