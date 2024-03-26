part of 'redirect_bloc.dart';

@immutable
sealed class RedirectEvent {}

final class RedirectToPageEvent extends RedirectEvent {
  
}