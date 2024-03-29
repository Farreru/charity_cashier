part of 'login_bloc.dart';

enum LoginStatus { idle, loading, success, failure }

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool isInputValid;
  final LoginStatus status;

  const LoginState({
    this.email = "",
    this.password = "",
    this.isInputValid = false,
    this.status = LoginStatus.idle,
  });

  @override
  List<Object> get props => [email, password, isInputValid, status];

  LoginState copyWith({
    String? email,
    String? password,
    bool? isInputValid,
    LoginStatus? status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isInputValid: isInputValid ?? this.isInputValid,
      status: status ?? this.status,
    );
  }
}
