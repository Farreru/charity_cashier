import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/login_params.dart';
import '../../../domain/usecases/post_login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final PostLoginUseCase _loginUseCase;
  LoginBloc(this._loginUseCase) : super(const LoginState()) {
    on<LoginInputChanged>(_onLoginInputChanged);
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  FutureOr<void> _onLoginInputChanged(LoginInputChanged event, emit) {
    if (event.type == "email") {
      emit(state.copyWith(email: event.value));
    } else if (event.type == "password") {
      emit(state.copyWith(password: event.value));
    }

    if (state.email.isNotEmpty && state.password.isNotEmpty) {
      emit(state.copyWith(isInputValid: true));
    } else {
      emit(state.copyWith(isInputValid: false));
    }
  }

  FutureOr<void> _onLoginButtonPressed(LoginButtonPressed event, emit) async {
    emit(state.copyWith(status: LoginStatus.loading));

    final result = await _loginUseCase(
        LoginParams(email: state.email, password: state.password));

    result.fold((l) => emit(state.copyWith(status: LoginStatus.failure)),
        (r) => emit(state.copyWith(status: LoginStatus.success)));
  }
}
