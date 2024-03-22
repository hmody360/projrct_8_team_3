part of 'data_bloc.dart';

@immutable
sealed class DataState {}

final class DataInitial extends DataState {}

final class LoadingMedicationState extends DataState {}

final class ErrorMedicationState extends DataState {
  final String msg;

  ErrorMedicationState({required this.msg});
}

final class SuccessMedicationState extends DataState {
  final 
}
