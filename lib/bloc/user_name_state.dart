part of 'user_name_bloc.dart';

@immutable
sealed class UserNameState {}

final class UserNameInitial extends UserNameState {}

class GetUserNameState extends UserNameState {}
