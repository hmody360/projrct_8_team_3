part of 'data_bloc.dart';

@immutable
sealed class DataEvent {}

class ChangeTimeEvent extends DataEvent {
  final DateTime time;
  ChangeTimeEvent({required this.time});
}

class ChangeTypeEvent extends DataEvent {
  final int num;
  ChangeTypeEvent({required this.num});
}

class AddMedicationEvent extends DataEvent {
  final String name;

  AddMedicationEvent({required this.name});
}

class DeleteMedicationEvent extends DataEvent {
  final String medID;

  DeleteMedicationEvent({required this.medID});
}

class GetMedicationEvent extends DataEvent {}

class EditMedicationEvent extends DataEvent {}
