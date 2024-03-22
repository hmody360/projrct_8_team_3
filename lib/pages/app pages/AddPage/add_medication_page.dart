import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/sized.dart';
import 'package:project_8_team3/widgets/button_widget.dart';
import 'package:project_8_team3/widgets/custom_widget.dart';
import 'package:project_8_team3/widgets/dropdown_Container_widget.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';

class AddMedicationPage extends StatefulWidget {
  const AddMedicationPage({super.key});

  @override
  State<AddMedicationPage> createState() => _AddMedicationPageState();
}

class _AddMedicationPageState extends State<AddMedicationPage> {
  DateTime dateTime = DateTime.now();
  String selectedTime = " 00:00 ص";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
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
              sizedBoxh50,
              const Text(
                "اسم الدواء",
                style: TextStyle(fontSize: 15),
              ),
              TextField(
                decoration: InputDecoration(
                  icon: SvgPicture.asset(
                    "assets/medication.svg",
                    colorFilter:
                        ColorFilter.mode(darkGreyColor, BlendMode.srcIn),
                  ),
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
                    path: 'assets/calendar.svg',
                  ),
                  sizedBoxw15,
                  dropdownWidget(
                    title: "حبة",
                    path: 'assets/pill.svg',
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
