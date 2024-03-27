import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:project_8_team3/data/model/medicattion_model.dart';
import 'package:project_8_team3/data/service/supabase_services.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/helper/sized.dart';
import 'package:project_8_team3/pages/app%20pages/bloc/data_bloc.dart';
import 'package:project_8_team3/widgets/button_widget.dart';
import 'package:project_8_team3/widgets/custom_widget.dart';
import 'package:project_8_team3/widgets/dropdown_Container_widget.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';

class EditMedicationPage extends StatelessWidget {
  const EditMedicationPage({super.key, required this.medication});
  final MedicationModel medication;

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    nameController.text = medication.medicationName;
    DateTime dateTime = DateTime.now();
    final bloc = context.read<DataBloc>();
    final locator = GetIt.I.get<DBService>();
    locator.days = medication.days;
    locator.pill = medication.pills;
    bloc.seletctedType = (medication.before == "قبل الاكل") ? 1 : 2;
    // bloc.selectedTime = DateTime.parse(medication.time);
    // bloc.selectedTimeText = DateFormat.jm().format(bloc.selectedTime);
    return BlocConsumer<DataBloc, DataState>(
      listener: (context, state) {
        if (state is SuccessEditingState) {
          context.popNav();
          context.showSuccessSnackBar(context, "تم تعديل بيانات الدواء");
          locator.days = 0;
          locator.pill = 0;
          locator.counts = 0;
          bloc.seletctedType = 0;
        }
        if (state is ErrorEditState) {
          context.showErrorSnackBar(context, "هناك مشكلة حاول مجددا");
          locator.days = 0;
          locator.pill = 0;
          locator.counts = 0;
          bloc.seletctedType = 0;
        }
        if (state is SuccessDeletingState) {
          context.showErrorSnackBar(context, "تم حذف هذا الدواء");
          context.popNav();
          context.popNav();
          locator.days = 0;
          locator.pill = 0;
          locator.counts = 0;
          bloc.seletctedType = 0;
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              leadingWidth: 80,
              leading: const CustomAppBar(),
            ),
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "تعديل الدواء",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "اسم الدواء",
                    style: TextStyle(fontSize: 15),
                  ),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      prefixIcon: Image.asset('assets/images/medIcon.png'),
                      hintText: "اكتب.....",
                      filled: true,
                      fillColor: greyColor,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "كم حبة باليوم و مدة الدواء",
                        style: TextStyle(fontSize: 15),
                      ),
                      gapH5,
                      Row(
                        children: [
                          Expanded(
                            child: DropDownWidget(
                              title: "يوم   ",
                              path: 'assets/images/calendar-fill 2.png',
                              type: "day",
                              page: 2,
                            ),
                          ),
                          gapWe10,
                          Expanded(
                            child: DropDownWidget(
                              count: 3,
                              title: "حبة   ",
                              path: 'assets/images/calendar-fill 1.png',
                              type: "pill",
                              page: 2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: greyColor,
                      borderRadius: const BorderRadius.all(Radius.circular(14)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            bloc.add(ChangeTypeEvent(num: 1));
                          },
                          child: Row(
                            children: [
                              Radio(
                                fillColor: MaterialStatePropertyAll(
                                    textfieldGreenColor),
                                value: 1,
                                groupValue: bloc.seletctedType,
                                onChanged: (_) {
                                  bloc.add(ChangeTypeEvent(num: 1));
                                },
                              ),
                              const Text("قبل الاكل"),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            bloc.add(ChangeTypeEvent(num: 2));
                          },
                          child: Row(
                            children: [
                              Radio(
                                fillColor: MaterialStatePropertyAll(
                                    textfieldGreenColor),
                                value: 2,
                                groupValue: bloc.seletctedType,
                                onChanged: (_) {
                                  bloc.add(ChangeTypeEvent(num: 2));
                                },
                              ),
                              const Text(" بعد الاكل"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "اشعارات",
                        style: TextStyle(fontSize: 15),
                      ),
                      gapH5,
                      Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(
                            color: greyColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(14)),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MaterialButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: TimePickerSpinner(
                                              locale: const Locale('en', ''),
                                              time: dateTime,
                                              is24HourMode: false,
                                              itemHeight: 80,
                                              normalTextStyle: const TextStyle(
                                                fontSize: 24,
                                              ),
                                              highlightedTextStyle: TextStyle(
                                                fontSize: 24,
                                                color: greenText,
                                              ),
                                              isForce2Digits: true,
                                              onTimeChange: (time) {
                                                bloc.add(ChangeTimeEvent(
                                                    time: time));
                                              },
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(dateTime);
                                                },
                                                child: const Text('خروج'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text(
                                      bloc.selectedTimeText.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  ),
                                  Icon(
                                    Icons.notifications,
                                    color: darkgreyColor,
                                  )
                                ]),
                          )),
                    ],
                  ),
                  gapH20,
                  ButtonWidget(
                    backgroundColor: textfieldGreenColor,
                    onPressed: () {
                      bloc.add(EditMedicationEvent(
                          name: nameController.text, med: medication));
                    },
                    text: "حفظ",
                    textColor: whiteColor,
                  ),
                  ButtonWidget(
                    backgroundColor: whiteColor,
                    onPressed: () {
                      context.showStatusDialog(
                        title: "تأكيد حذف الدواء",
                        dialogContent: "هل أنت متأكد من رغبتك في حذف الدواء ؟",
                        action1: "حذف",
                        textStatus: "حذف",
                        medication: medication,
                        onTap: (){

                          bloc.add(DeleteMedicationEvent(
                          medID: medication.medicationId));
                          context.popNav();
                          context.popNav();
                        }
                      );
                    },
                    text: "حذف",
                    textColor: textgreyColor,
                    borderColor: textfieldGreenColor,
                  ),
                ],
              ),
            )));
      },
    );
  }
}
