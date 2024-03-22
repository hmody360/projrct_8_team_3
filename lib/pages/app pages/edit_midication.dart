import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/sized.dart';
import 'package:project_8_team3/widgets/button_widget.dart';
import 'package:project_8_team3/widgets/custom_widget.dart';
import 'package:project_8_team3/widgets/dropdown_Container_widget.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';

class EditMedicationPage extends StatefulWidget {
  const EditMedicationPage({super.key});

  @override
  State<EditMedicationPage> createState() => _EditMedicationPageState();
}

class _EditMedicationPageState extends State<EditMedicationPage> {
  DateTime dateTime = DateTime.now();
  String selectedTime = " 00:00 ص";
  @override
  Widget build(BuildContext context) {
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
                "تعديل الدواء",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              sizedBoxh50,
              const Text(
                "اسم الدواء",
                style: TextStyle(fontSize: 15),
              ),
              TextField(
                decoration: InputDecoration(
                  icon: Image.asset('assets/images/medIcon.png'),
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
              sizedBoxh60,
              const Text(
                "كم حبة باليوم و مدة الدواء",
                style: TextStyle(fontSize: 15),
              ),
              Row(
                children: [
                  dropdownWidget(
                    title: "يوم",
                    path: 'assets/images/calendar-fill 2.png',
                  ),
                  sizedBoxw15,
                  dropdownWidget(
                    title: "حبة",
                    path: 'assets/images/calendar-fill 1.png',
                  ),
                ],
              ),
              sizedBoxh60,
              const Text(
                "اشعارات",
                style: TextStyle(fontSize: 15),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                    color: greyColor,
                    borderRadius: const BorderRadius.all(Radius.circular(14)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                                        setState(() {
                                          // dateTime = time;
                                          selectedTime =
                                              DateFormat.jm().format(time);
                                        });
                                      },
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(dateTime);
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
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                          Icon(
                            Icons.notifications,
                            color: darkgreyColor,
                          )
                        ]),
                  )),
              const Spacer(),
              ButtonWidget(
                backgroundColor: textfieldGreenColor,
                onPressed: () {},
                text: "حفظ",
                textColor: whiteColor,
              ),
              sizedBoxH10,
              ButtonWidget(
                backgroundColor: whiteColor,
                onPressed: () {},
                text: "حذف",
                textColor: textgreyColor,
                borderColor: textfieldGreenColor,
              ),
            ],
          ),
        )));
  }
}
