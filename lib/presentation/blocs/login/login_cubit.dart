import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/core/network/api_client_dto.dart';
import 'package:axis_crm/entity/user.dart';
import 'package:axis_crm/presentation/blocs/session/session_cubit.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void phoneChanged(String value) {
    emit(state.copyWith(phone: value.trim()));
  }

  void nameChanged(String value) {
    emit(state.copyWith(name: value.trim()));
  }

  Future<void> submit() async {
    if (!state.canSubmit || state.isSubmitting) return;

    emit(state.copyWith(isSubmitting: true, error: null));

    try {
      final apiClient = getIt<ApiClient>();
      final response = await apiClient.login(
        LoginRequest(phone: state.phone, name: state.name),
      );
      getIt<SessionCubit>().setUser(response.user);
      emit(state.copyWith(isSubmitting: false, user: response.user));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, error: e.toString()));
    }
  }
}
