part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterInputChanged extends RegisterEvent {
  final String type;
  final String value;

  const RegisterInputChanged({
    required this.type,
    required this.value,
  });

  @override
  List<Object> get props => [type, value];
}

class RegisterButtonPressed extends RegisterEvent {
  @override
  List<Object> get props => [];
}

class RegisterCheckBoxTermsChanged extends RegisterEvent {
  final String type;
  final bool value;

  const RegisterCheckBoxTermsChanged({
    required this.type,
    required this.value,
  });

  @override
  List<Object> get props => [type, value];
}
