part of 'session_cubit.dart';

class SessionState extends Equatable {
  const SessionState({this.user});

  final User? user;

  bool get isLoggedIn => user != null;

  @override
  List<Object?> get props => <Object?>[user];
}