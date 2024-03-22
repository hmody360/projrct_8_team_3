import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:project_8_team3/data/model/medicattion_model.dart';
import 'package:project_8_team3/data/service/supabase_services.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final locator = GetIt.I.get<DBService>();
  List<MedicationModel> medicationsData = [];
  String selectedTime = " 00:00 ص";
  DataBloc() : super(DataInitial()) {
    on<DataEvent>((event, emit) {});
    on<DeleteMedicationEvent>(deleteMed);
    on<ChangeTimeEvent>(changeTime);
    on<GetMedicationEvent>(getMed);
    on<AddMedicationEvent>(addMed);
    on<EditMedicationEvent>(editMed);
  }

  FutureOr<void> deleteMed(
      DeleteMedicationEvent event, Emitter<DataState> emit) async {}

  FutureOr<void> getMed(
      GetMedicationEvent event, Emitter<DataState> emit) async {
    try {
      await locator.getCurrentUser();
      emit(LoadingHomeState());
      medicationsData = await locator.getMedications();
      Future.delayed(const Duration(seconds: 1));
      emit(SuccessHomeState(medications: medicationsData));
    } catch (error) {
      emit(ErrorHomeState(msg: error.toString()));
    }
  }

  FutureOr<void> addMed(
      AddMedicationEvent event, Emitter<DataState> emit) async {}

  FutureOr<void> editMed(
      EditMedicationEvent event, Emitter<DataState> emit) async {}

  FutureOr<void> changeTime(ChangeTimeEvent event, Emitter<DataState> emit) {
    selectedTime = event.time;
    emit(ChangeTimeState());
  }
}
