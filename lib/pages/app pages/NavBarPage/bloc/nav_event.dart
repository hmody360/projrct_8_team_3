part of 'nav_bloc.dart';

@immutable
sealed class NavEvent {}

class ChangePageEvent extends NavEvent {
  final int num;
  ChangePageEvent({required this.num});
}
