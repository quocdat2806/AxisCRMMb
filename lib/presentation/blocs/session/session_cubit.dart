import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/services/user_session_service.dart';
import 'package:axis_crm/entity/user.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit({required UserSessionService sessionService})
    : _sessionService = sessionService,
      super(SessionState(user: sessionService.user));

  final UserSessionService _sessionService;

  User? get user => state.user;
  String? get userId => state.user?.id;

  String get requireUserId {
    final String? id = userId;
    if (id == null || id.isEmpty) {
      throw StateError('User is not logged in');
    }
    return id;
  }

  void setUser(User user) {
    _sessionService.setUser(user);
    emit(SessionState(user: user));
  }

  void clear() {
    _sessionService.clear();
    emit(const SessionState());
  }
}
