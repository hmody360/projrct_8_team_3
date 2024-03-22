part of 'data_bloc.dart';

@immutable
sealed class DataEvent {}

class ChangeTimeEvent extends DataEvent {
  final String time;
  ChangeTimeEvent({required this.time});
}

class AddMedicationEvent extends DataEvent {
  final String name;
  final int pill;
  final int day;

  AddMedicationEvent(
      {required this.name, required this.pill, required this.day});
}

class DeleteMedicationEvent extends DataEvent {}

class GetMedicationEvent extends DataEvent {}

class EditMedicationEvent extends DataEvent {}
