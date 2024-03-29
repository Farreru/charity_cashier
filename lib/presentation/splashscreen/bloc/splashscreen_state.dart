part of 'splashscreen_bloc.dart';

enum SplashscreenStatus { idle, loading, success, failure }

class SplashscreenState extends Equatable {
  final SplashscreenStatus status;

  const SplashscreenState({this.status = SplashscreenStatus.idle});

  SplashscreenState copyWith({
    SplashscreenStatus? status,
  }) {
    return SplashscreenState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}
