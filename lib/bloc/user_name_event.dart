part of 'user_name_bloc.dart';

@immutable
sealed class UserNameEvent {}

class GetUserNameEvent extends UserNameEvent {}
