import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:project_8_team3/data/model/medicattion_model.dart';
import 'package:project_8_team3/data/service/supabase_services.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final locator = GetIt.I.get<DBService>();
  List<MedicationModel> medicationsData = [];
  DateTime selectedTime = DateTime.now();
  String selectedTimeText = " 00:00 ص";
  int seletctedType = 1;
  late String userName;

  DataBloc() : super(DataInitial()) {
    on<DataEvent>((event, emit) {});
    on<DeleteMedicationEvent>(deleteMed);
    on<ChangeTimeEvent>(changeTime);
    on<ChangeTypeEvent>(changeType);
    on<GetMedicationEvent>(getMed);
    on<AddMedicationEvent>(addMed);
    on<EditMedicationEvent>(editMed);
    on<EditCompletedEvent>(EditCompleted);
    on<ChoiceEvent>(choice);
  }

  FutureOr<void> deleteMed(
      DeleteMedicationEvent event, Emitter<DataState> emit) async {
    try {
      await locator.deleteMedications(midId: event.medID);
      emit(SuccessDeletingState());
      await getMed(GetMedicationEvent(), emit);
    } catch (error) {
      emit(ErrorDeletingState(msg: error.toString()));
    }
  }

  FutureOr<void> getMed(
      GetMedicationEvent event, Emitter<DataState> emit) async {
    try {
      await locator.getCurrentUser();
      // userName = await locator.getUserName();
      emit(LoadingHomeState());
      medicationsData = await locator.getMedications();
      emit(SuccessHomeState(medications: medicationsData));
    } catch (error) {
      emit(ErrorHomeState(msg: error.toString()));
    }
  }

  FutureOr<void> addMed(
      AddMedicationEvent event, Emitter<DataState> emit) async {
        if(locator.name.trim().isNotEmpty && locator.days)
    try {
      String condition;
      await locator.getCurrentUser();
      emit(LoadingHomeState());
      if (seletctedType == 1) {
        condition = "قبل الاكل";
      } else {
        condition = "بعد الاكل";
      }
      if (locator.counts == 1) {
        final addMed = await locator.addMedications(
          before: condition,
          name: event.name,
          pills: locator.pill,
          days: locator.days,
          time: DateFormat.jm().format(selectedTime),
        );
      } else if (locator.counts == 2) {
        print('Selected Time: $selectedTime');
        final name1 = "${event.name} - الجرعة الاولي";
        final name2 = "${event.name} - الجرعة الثانيه";
        final addMed = await locator.addMedications(
          before: condition,
          name: name1,
          pills: locator.pill,
          days: locator.days,
          time: DateFormat.jm().format(selectedTime),
        );
        DateTime time2 = selectedTime.add(const Duration(hours: 12));
        print('Time 12 hours later: $time2');
        final String time2Text = DateFormat.jm().format(time2);

        final addMed2 = await locator.addMedications(
          before: condition,
          name: name2,
          pills: locator.pill,
          days: locator.days,
          time: time2Text,
        );
      } else if (locator.counts == 3) {
        final name1 = "${event.name} - الجرعة الاولي";
        final name2 = "${event.name} - الجرعة الثانيه";
        final name3 = "${event.name} - الجرعة الثالثة";

        final addMed = await locator.addMedications(
          before: condition,
          name: name1,
          pills: locator.pill,
          days: locator.days,
          time: DateFormat.jm().format(selectedTime),
        );

        var time2 = selectedTime.add(const Duration(hours: 8));
        final time2Text = DateFormat.jm().format(time2);

        final addMed2 = await locator.addMedications(
          before: condition,
          name: name2,
          pills: locator.pill,
          days: locator.days,
          time: time2Text,
        );

        var time3 = time2.add(const Duration(hours: 8));
        final time3Text = DateFormat.jm().format(time3);

        final addMed3 = await locator.addMedications(
            before: condition,
            name: name3,
            pills: locator.pill,
            days: locator.days,
            time: time3Text);
      }
      // emit(SuccessAddingState());
      medicationsData = await locator.getMedications();
      emit(SuccessHomeState(medications: medicationsData));
    } catch (error) {
      emit(ErrorHomeState(msg: error.toString()));
    }
  }

  FutureOr<void> editMed(
      EditMedicationEvent event, Emitter<DataState> emit) async {
    try {
      String condition;
      await locator.getCurrentUser();
      if (seletctedType == 1) {
        condition = "قبل الاكل";
      } else {
        condition = "بعد الاكل";
      }
      emit(LoadingHomeState());
      await locator.editMedications(
        name: event.name,
        pills: locator.pill,
        days: locator.days,
        before: condition,
        medication: event.med,
        time: DateFormat.jm().format(selectedTime),
      );
      emit(SuccessEditingState());
      medicationsData = await locator.getMedications();
      emit(SuccessHomeState(medications: medicationsData));
    } catch (error) {
      emit(ErrorHomeState(msg: error.toString()));
    }
  }

  FutureOr<void> changeTime(ChangeTimeEvent event, Emitter<DataState> emit) async{
    selectedTime = event.time;
    selectedTimeText = DateFormat.jm().format(selectedTime);
    emit(ChangeState());
    await getMed(GetMedicationEvent(), emit);
  }

  FutureOr<void> changeType(ChangeTypeEvent event, Emitter<DataState> emit) async{
    seletctedType = event.num;
    medicationsData = await locator.getMedications();
    emit(ChangeState());
    await getMed(GetMedicationEvent(), emit);
  }

  FutureOr<void> EditCompleted(
      EditCompletedEvent event, Emitter<DataState> emit) async {
    try {
      emit(LoadingHomeState());
      await locator.editIsCompleted(
          isCompleted: event.completed, medication: event.med);
      emit(EditCompletedState());
      medicationsData = await locator.getMedications();
      emit(SuccessHomeState(medications: medicationsData));
    } catch (error) {
      emit(ErrorHomeState(msg: error.toString()));
    }
  }

  FutureOr<void> choice(ChoiceEvent event, Emitter<DataState> emit) async {
    try {
      emit(LoadingHomeState());
      await locator.editUpdate(
        date: event.date,
        isUpdate: event.isUpdate,
        medication: event.med,
        updateTime: event.time,
      );
      emit(EditChoiceState());
      medicationsData = await locator.getMedications();
      emit(SuccessHomeState(medications: medicationsData));
    } catch (error) {
      emit(ErrorHomeState(msg: error.toString()));
    }
  }
}
