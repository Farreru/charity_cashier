part of 'register_bloc.dart';

enum RegisterStatus { idle, loading, success, failure }

class RegisterState extends Equatable {
  final String name;
  final String email;
  final String password;
  final String password_confirmation;
  final bool isInputValid;
  final RegisterStatus status;
  final bool CheckTerms;

  const RegisterState({
    this.name = "",
    this.email = "",
    this.password = "",
    this.password_confirmation = "",
    this.isInputValid = false,
    this.status = RegisterStatus.idle,
    this.CheckTerms = false,
  });

  @override
  List<Object> get props => [
        name,
        email,
        password,
        password_confirmation,
        isInputValid,
        status,
        CheckTerms
      ];

  RegisterState copyWith({
    String? name,
    String? email,
    String? password,
    String? password_confirmation,
    bool? isInputValid,
    RegisterStatus? status,
    bool? CheckTerms,
  }) {
    return RegisterState(
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        password_confirmation:
            password_confirmation ?? this.password_confirmation,
        isInputValid: isInputValid ?? this.isInputValid,
        status: status ?? this.status,
        CheckTerms: CheckTerms ?? this.CheckTerms);
  }
}
