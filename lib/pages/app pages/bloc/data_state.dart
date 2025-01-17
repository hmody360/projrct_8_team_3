part of 'data_bloc.dart';

@immutable
sealed class DataState {}

final class DataInitial extends DataState {}

final class LoadingHomeState extends DataState {}

final class ChangeState extends DataState {}

final class SuccessAddingState extends DataState {
  
}

final class SuccessEditingState extends DataState {}

final class SuccessDeletingState extends DataState {}

final class EditCompletedState extends DataState {}

final class EditChoiceState extends DataState {}

final class ErrorEditState extends DataState {
    final String msg;
  ErrorEditState({required this.msg});
}

final class ErrorDeletingState extends DataState {
    final String msg;
  ErrorDeletingState({required this.msg});
}


final class ErrorHomeState extends DataState {
  final String msg;
  ErrorHomeState({required this.msg});
}

final class SuccessHomeState extends DataState {
  final List<MedicationModel> medications;
  SuccessHomeState({required this.medications});
}
