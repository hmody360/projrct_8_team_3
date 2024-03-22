import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:project_8_team3/data/service/supabase_services.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
      final locator = GetIt.I.get<DBService>();
  DataBloc() : super(DataInitial()) {
    on<DataEvent>((event, emit) {});
    on<DeleteMedicationEvent>(deleteMed);
    on<GetMedicationEvent>(getMed);
    on<AddMedicationEvent>(addMed);
    on<EditMedicationEvent>(editMed);
  }

  FutureOr<void> deleteMed(
      DeleteMedicationEvent event, Emitter<DataState> emit) async {}

  FutureOr<void> getMed(
      GetMedicationEvent event, Emitter<DataState> emit) async {

    try {
      emit(LoadingMedicationState());
      emit(SuccessMedicationState(: await locator.getMedications()));
    } catch (error) {
      emit(ErrorMedicationState(msg: error.toString()));
    }
  }

  FutureOr<void> addMed(
      AddMedicationEvent event, Emitter<DataState> emit) async {}

  FutureOr<void> editMed(
      EditMedicationEvent event, Emitter<DataState> emit) async {}
}
