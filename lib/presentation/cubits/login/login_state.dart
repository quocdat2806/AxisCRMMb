part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.phone = '',
    this.name = '',
    this.isSubmitting = false,
    this.user,
    this.error,
  });

  final String phone;
  final String name;
  final bool isSubmitting;
  final User? user;
  final String? error;

  bool get canSubmit => phone.isNotEmpty && name.isNotEmpty;

  LoginState copyWith({
    String? phone,
    String? name,
    bool? isSubmitting,
    User? user,
    String? error,
  }) {
    return LoginState(
      phone: phone ?? this.phone,
      name: name ?? this.name,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      user: user ?? this.user,
      error: error,
    );
  }

  @override
  List<Object?> get props => [phone, name, isSubmitting, user, error];
}