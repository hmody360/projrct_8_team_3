part of 'sign_in_bloc.dart';

@immutable
sealed class SignInState {}

final class SignInInitial extends SignInState {}

final class LoadingSignInState extends SignInState {}

final class SuccessSignInState extends SignInState {}

final class ErrorSignInState extends SignInState {
  final String massage;
  ErrorSignInState({required this.massage});
}
