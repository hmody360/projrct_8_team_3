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
  int seletctedType = 1;

  DataBloc() : super(DataInitial()) {
    on<DataEvent>((event, emit) {});
    on<DeleteMedicationEvent>(deleteMed);
    on<ChangeTimeEvent>(changeTime);
    on<ChangeTypeEvent>(changeType);
    on<GetMedicationEvent>(getMed);
    on<AddMedicationEvent>(addMed);
    on<EditMedicationEvent>(editMed);
  }

  FutureOr<void> deleteMed(
      DeleteMedicationEvent event, Emitter<DataState> emit) async {
    try {
      emit(LoadingHomeState());
      await locator.deleteMedications(midId: event.medID);
      medicationsData = await locator.getMedications();
      Future.delayed(const Duration(seconds: 1));
      emit(SuccessHomeState(medications: medicationsData));
    } catch (error) {
      emit(ErrorHomeState(msg: error.toString()));
    }
  }

  FutureOr<void> getMed(
      GetMedicationEvent event, Emitter<DataState> emit) async {
    try {
      await locator.getCurrentUser();
      emit(LoadingHomeState());
      medicationsData = await locator.getMedications();
      emit(SuccessHomeState(medications: medicationsData));
    } catch (error) {
      emit(ErrorHomeState(msg: error.toString()));
    }
  }

  FutureOr<void> addMed(
      AddMedicationEvent event, Emitter<DataState> emit) async {
    try {
      String condition;
      await locator.getCurrentUser();
      emit(LoadingHomeState());
      if (seletctedType == 1) {
        condition = "قبل الاكل";
      } else {
        condition = "بعد الاكل";
      }
      final addMed = await locator.addMedications(
          before: condition,
          name: event.name,
          pills: locator.pill,
          days: locator.days);
      medicationsData = await locator.getMedications();
      emit(SuccessHomeState(medications: medicationsData));
    } catch (error) {
      emit(ErrorHomeState(msg: error.toString()));
    }
  }

  FutureOr<void> editMed(
      EditMedicationEvent event, Emitter<DataState> emit) async {}

  FutureOr<void> changeTime(ChangeTimeEvent event, Emitter<DataState> emit) {
    selectedTime = event.time;
    emit(ChangeState());
  }

  FutureOr<void> changeType(ChangeTypeEvent event, Emitter<DataState> emit) {
    seletctedType = event.num;
    emit(ChangeState());
  }
}
