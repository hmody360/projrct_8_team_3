part of 'redirect_bloc.dart';

@immutable
sealed class RedirectState {}

final class RedirectInitial extends RedirectState {}

final class RedirectedState extends RedirectState {
  final Widget pageView;

  RedirectedState({required this.pageView});
}