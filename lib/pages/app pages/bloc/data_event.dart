part of 'data_bloc.dart';

@immutable
sealed class DataEvent {}

class AddMedicationEvent extends DataEvent {}

class DeleteMedicationEvent extends DataEvent {}

class GetMedicationEvent extends DataEvent {}

class EditMedicationEvent extends DataEvent {}
