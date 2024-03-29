part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginInputChanged extends LoginEvent {
  final String type;
  final String value;

  const LoginInputChanged({
    required this.type,
    required this.value,
  });

  @override
  List<Object> get props => [type, value];
}

class LoginButtonPressed extends LoginEvent {
  @override
  List<Object> get props => [];
}
