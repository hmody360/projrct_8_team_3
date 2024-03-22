part of 'splash_bloc.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}


final class SessionAvailabilityStat extends SplashState {
  final dynamic isAvailable;
  SessionAvailabilityStat({required this.isAvailable});
}
