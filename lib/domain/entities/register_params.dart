class RegisterParams {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  const RegisterParams(
      {required this.name,
      required this.email,
      required this.password,
      required this.passwordConfirmation});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation
    };
  }

  factory RegisterParams.fromMap(Map<String, dynamic> map) {
    return RegisterParams(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      passwordConfirmation: map['password_confirmation'] as String,
    );
  }
}
