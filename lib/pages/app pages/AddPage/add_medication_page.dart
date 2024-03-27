import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:project_8_team3/data/service/supabase_services.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/helper/sized.dart';
import 'package:project_8_team3/widgets/button_widget.dart';
import 'package:project_8_team3/widgets/custom_widget.dart';
import 'package:project_8_team3/widgets/dropdown_Container_widget.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';
import 'package:project_8_team3/pages/app%20pages/bloc/data_bloc.dart';

// ignore: must_be_immutable
class AddMedicationPage extends StatelessWidget {
  AddMedicationPage({super.key});

  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();
    final bloc = context.read<DataBloc>();
    final locator = GetIt.I.get<DBService>();

    return BlocConsumer<DataBloc, DataState>(
      listener: (context, state) {
        if (state is SuccessAddingState) {
          context.popNav();
          context.showSuccessSnackBar(context, "تم اضافة الدواء");
          locator.days = 0;
          locator.pill = 0;
          locator.counts = 0;
          bloc.seletctedType = 0;
        }
        if (state is ErrorHomeState) {
          context.showErrorSnackBar(context, "هناك مشكلة حاول مجددا");
          locator.days = 0;
          locator.pill = 0;
          locator.counts = 0;
          bloc.seletctedType = 1;
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
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
                    "إضافة دواء",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "اسم الدواء",
                        style: TextStyle(fontSize: 15),
                      ),
                      gapH5,
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
                    ],
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: DropDownWidget(
                              title: "يوم  ",
                              path: 'assets/images/calendar-fill 2.png',
                              type: "day",
                              page: 1,
                            ),
                          ),
                          gapWe10,
                          Expanded(
                            child: DropDownWidget(
                              count: 3,
                              title: "حبة  ",
                              path: 'assets/images/calendar-fill 1.png',
                              type: "pill",
                              page: 1,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "عدد الجرعات",
                            style: TextStyle(fontSize: 15),
                          ),
                          gapH5,
                          SizedBox(
                            width: 150,
                            height: MediaQuery.of(context).size.height * 0.07,
                            child: DropDownWidget(
                              type: 'counts',
                              title: "جرعة  ",
                              path: 'assets/images/calendar-fill 1.png',
                              count: 3,
                              page: 1,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "إشعارات",
                            style: TextStyle(fontSize: 15),
                          ),
                          gapH5,
                          Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.07,
                              decoration: BoxDecoration(
                                color: greyColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(14)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
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
                                                  locale:
                                                      const Locale('en', ''),
                                                  time: dateTime,
                                                  is24HourMode: false,
                                                  itemHeight: 80,
                                                  normalTextStyle:
                                                      const TextStyle(
                                                    fontSize: 24,
                                                  ),
                                                  highlightedTextStyle:
                                                      TextStyle(
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
                                                    child: const Text('OK'),
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
                      )
                    ],
                  ),
                  ButtonWidget(
                    backgroundColor: textfieldGreenColor,
                    onPressed: () {
                      bloc.add(AddMedicationEvent(name: nameController.text));
                      Navigator.pop(context);
                    },
                    text: "إضافة",
                    textColor: whiteColor,
                  )
                ],
              ),
            )));
      },
    );
  }
}
