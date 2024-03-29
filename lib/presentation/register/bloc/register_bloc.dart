import 'dart:async';
import 'package:charity_cashier/domain/entities/register_params.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/post_register_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final PostRegisterUseCase _registerUseCase;
  RegisterBloc(this._registerUseCase) : super(const RegisterState()) {
    on<RegisterInputChanged>(_onRegisterInputChanged);
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
    on<RegisterCheckBoxTermsChanged>(_onRegisterCheckBoxTermsChanged);
  }

  FutureOr<void> _onRegisterCheckBoxTermsChanged(
      RegisterCheckBoxTermsChanged event, emit) {
    if (event.type == "checkbox") {
      emit(state.copyWith(CheckTerms: event.value));
    }

    if (state.CheckTerms == true &&
        state.name.isNotEmpty &&
        state.email.isNotEmpty &&
        state.password.isNotEmpty) {
      emit(state.copyWith(isInputValid: true));
    } else {
      emit(state.copyWith(isInputValid: false));
    }
  }

  FutureOr<void> _onRegisterInputChanged(RegisterInputChanged event, emit) {
    if (event.type == "email") {
      emit(state.copyWith(email: event.value));
    } else if (event.type == "password") {
      emit(state.copyWith(password: event.value));
    } else if (event.type == "password_confirmation") {
      emit(state.copyWith(password_confirmation: event.value));
    } else if (event.type == "name") {
      emit(state.copyWith(name: event.value));
    }
  }

  FutureOr<void> _onRegisterButtonPressed(
      RegisterButtonPressed event, emit) async {
    emit(state.copyWith(status: RegisterStatus.loading));

    final result = await _registerUseCase(RegisterParams(
        name: state.name,
        email: state.email,
        password: state.password,
        passwordConfirmation: state.password_confirmation));

    result.fold((l) => emit(state.copyWith(status: RegisterStatus.failure)),
        (r) => emit(state.copyWith(status: RegisterStatus.success)));
  }
}
