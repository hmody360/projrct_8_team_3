import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/sized.dart';
import 'package:project_8_team3/widgets/button_widget.dart';
import 'package:project_8_team3/widgets/custom_widget.dart';
import 'package:project_8_team3/widgets/dropdown_Container_widget.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';
import 'package:project_8_team3/pages/app%20pages/bloc/data_bloc.dart';




class AddMedicationPage extends StatefulWidget {
  const AddMedicationPage({super.key});

  @override
  State<AddMedicationPage> createState() => _AddMedicationPageState();
}

class _AddMedicationPageState extends State<AddMedicationPage> {
  TextEditingController nameController = TextEditingController();
  DateTime dateTime = DateTime.now();
  String selectedTime = " 00:00 ص";
    int seletctedType = 1;
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DataBloc>();
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 80,
          leading: const CustomAppBar(),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "إضافة دواء",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              sizedBoxh40,
              const Text(
                "اسم الدواء",
                style: TextStyle(fontSize: 15),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  icon: Image.asset('assets/medIcon.png'),
                  hintText: "اكتب.....",
                  filled: true,
                  fillColor: greyColor,
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: transparent),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: transparent),
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              sizedBoxh40,
              const Text(
                "كم حبة باليوم و مدة الدواء",
                style: TextStyle(fontSize: 15),
              ),
              Row(
                children: [
                  dropdownWidget(
                    title: "يوم",
                    path: 'assets/calendar-fill 2.png',
                  ),
                  sizedBoxw15,
                  dropdownWidget(
                    title: "حبة",
                    path: 'assets/calendar-fill 1.png',
                  ),
                ],
              ),
              sizedBoxh40,
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
                        setState(() {
                          seletctedType = 1;
                        });
                      },
                      child: Row(
                        children: [
                          Radio(
                            fillColor:
                                MaterialStatePropertyAll(textfieldGreenColor),
                            value: 1,
                            groupValue: seletctedType,
                            onChanged: (_) {
                              setState(() {
                                seletctedType = 1;
                              });
                            },
                          ),
                          const Text("قبل الاكل"),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          seletctedType = 2;
                        });
                      },
                      child: Row(
                        children: [
                          Radio(
                            fillColor:
                                MaterialStatePropertyAll(textfieldGreenColor),
                            value: 2,
                            groupValue: seletctedType,
                            onChanged: (_) {
                              setState(() {
                                seletctedType = 2;
                              });
                            },
                          ),
                          const Text(" بعد الاكل"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              sizedBoxh40,
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "عدد الجرعات",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: dropdownWidget(
                            title: "جرعة",
                            path: 'assets/calendar-fill 1.png',
                            count: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  sizedBoxw15,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "اشعارات",
                          style: TextStyle(fontSize: 15),
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            decoration: BoxDecoration(
                              color: greyColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(14)),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
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
                                                normalTextStyle:
                                                    const TextStyle(
                                                  fontSize: 24,
                                                ),
                                                highlightedTextStyle: TextStyle(
                                                  fontSize: 24,
                                                  color: greenText,
                                                ),
                                                isForce2Digits: true,
                                                onTimeChange: (time) {
                                                  setState(() {
                                                    // dateTime = time;
                                                    selectedTime =
                                                        DateFormat.jm()
                                                            .format(time);
                                                  });
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
                                        selectedTime.toString(),
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
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              sizedBoxh60,
              sizedBoxh60,
              ButtonWidget(
                backgroundColor: textfieldGreenColor,
                onPressed: () {},
                text: "إنهاء",
                textColor: whiteColor,
              )
            ],
          ),
        )));
  }
}
