import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/check_auth_usecase.dart';

part 'splashscreen_event.dart';
part 'splashscreen_state.dart';

class SplashscreenBloc extends Bloc<SplashscreenEvent, SplashscreenState> {
  final CheckAuthUseCase _checkAuthUseCase;

  SplashscreenBloc(this._checkAuthUseCase) : super(const SplashscreenState()) {
    on<SplashscreenStarted>(_onSplashscreenStarted);
  }

  FutureOr<void> _onSplashscreenStarted(SplashscreenStarted event, emit) async {
    emit(state.copyWith(status: SplashscreenStatus.loading));

    final res = await _checkAuthUseCase();

    res.fold(
      (l) => emit(state.copyWith(status: SplashscreenStatus.failure)),
      (r) => emit(
        state.copyWith(status: SplashscreenStatus.success),
      ),
    );
  }
}
