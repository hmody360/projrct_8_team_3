// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:project_8_team3/data/model/medicattion_model.dart';
import 'package:project_8_team3/data/service/supabase_services.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/helper/sized.dart';
import 'package:project_8_team3/pages/app%20pages/MedPage/edit_midication.dart';
import 'package:project_8_team3/pages/app%20pages/bloc/data_bloc.dart';
import 'package:project_8_team3/widgets/button_widget.dart';
import 'package:project_8_team3/widgets/time_after_widget.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.nameMed,
    required this.time,
    this.condition,
    this.conditionColor,
    this.medIcons = false,
    this.done = true,
    required this.med,
  });
  //Home Page Requirds:
  final nameMed;
  final time;
  final condition;
  final conditionColor;
  //Med Page Requirds:
  final bool medIcons;
  final bool done;
  final MedicationModel med;

  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<DBService>();
    final bloc = context.read<DataBloc>();
    void edit() async {
      await locator.editNotUpdate(medication: med);
    }

    // final DateTime date = DateTime.parse(med.updateTimeDate);
    // if (date != DateTime.now()) {
    //   edit();
    // }
    // final date2 = med.createdAt.add(Duration(days: med.days));
    // if (DateTime.now().isAfter(date2)) {
    //   bloc.add(DeleteMedicationEvent(medID: med.medicationId));
    // }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12) , // all(24),
      height: context.getWidth() * 0.2,
      width: context.getWidth() * 0.9,
      // 97,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: lightGray,
        borderRadius: BorderRadius.circular(24),
      ),
      child:
      //  Padding(
      //   padding: const EdgeInsetsDirectional.only(
      //       start: 8, end: 30, top: 8, bottom: 8),
      //   child:
         Row(
          children: [
            gapWe10,
            SvgPicture.asset("assets/images/medication.svg"),
            gapWe20,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gapH5,
                  Text(
                    nameMed, //Name Med
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  gapH5,
                  // Padding(
                  //   padding: const EdgeInsetsDirectional.only(end: 12),
                    // child: 
                    Row(
                      children: [
                        Text(
                          time, //Time Med
                          style: const TextStyle(fontSize: 13),
                        ),
                        (medIcons)
                            ?
                            //حالة اخذ الدواء
                            (done)
                                ? const Text(
                                    ". تم", //Done or not Med
                                    style: TextStyle(fontSize: 13),
                                  )
                                : const Text(
                                    ". لم تتم", //Done or not Med
                                    style: TextStyle(fontSize: 13),
                                  )
                            : const SizedBox(),
                      ],
                    ),
                  // ),
                ],
              ),
            ),

            gapWe10,
            gapWe20,
            //حالة اخذ الدواء

            (medIcons)
                ? Expanded(
                    child: Row(
                      children: [
                        const Spacer(),
                        gapH10,
                        InkWell(
                            onTap: () {
                              context.pushTo(
                                  view: EditMedicationPage(
                                medication: med,
                              ));
                            },
                            child: Image.asset("assets/images/edit.png")),
                        gapH10,
                        InkWell(
                            onTap: () {
                              moreBottomSheet(context);
                            },
                            child:
                                const Icon(Icons.keyboard_arrow_down_rounded))
                      ],
                    ),
                  )
                : Column(
                    children: [
                      gapH10,
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color: conditionColor, //Color Med
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          gapWe5,
                          Text(
                            condition, //Condition Med
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      if (condition == "تم اعادة الجدولة")
                        Text(
                          med.updateTime,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                    ],
                  ),
          ],
        )
      );
    // );
  }

  moreBottomSheet(BuildContext context) {
    final bloc = context.read<DataBloc>();
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "تنبيه دواء ${med.medicationName}\nبعد الاكل،${med.time}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocListener<DataBloc, DataState>(
                    listener: (context, state) {
                      if (state is EditCompletedState) {
                        context.popNav();
                        context.showSuccessSnackBar(
                            context, "تم تغيير حالة اخذ الدواء");
                      }
                      if (state is ErrorHomeState) {
                        context.showErrorSnackBar(
                            context, "هناك مشكلة حاول مجددا");
                      }
                    },
                    child: ButtonWidget(
                      onPressed: () {
                        bloc.add(EditCompletedEvent(med: med, completed: true));
                      },
                      text: ("اخذ الدواء"),
                      backgroundColor: greenText,
                      textColor: whiteColor,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ButtonWidget(
                    onPressed: () {
                      Navigator.pop(context);
                      reschadulBottomSheet(context);
                    },
                    text: ("اعادة جدولة"),
                    backgroundColor: greenText,
                    textColor: whiteColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ButtonWidget(
                    onPressed: () {
                      bloc.add(EditCompletedEvent(med: med, completed: false));
                    },
                    text: ("تخطي"),
                    backgroundColor: greenText,
                    textColor: whiteColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        });
  }

  reschadulBottomSheet(BuildContext context) {
    final bloc = context.read<DataBloc>();
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: BlocListener<DataBloc, DataState>(
                listener: (context, state) {
                  if (state is EditChoiceState) {
                    context.popNav();
                    context.popNav();
                    context.showSuccessSnackBar(
                        context, "تم اعادة جدولة الدواء");
                  }
                  if (state is ErrorHomeState) {
                    context.showErrorSnackBar(context, "هناك مشكلة حاول مجددا");
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "اعادة الجدولة\n ${med.time}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Divider(
                          color: greenText,
                        ),
                        Text("إضافة وقت",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: greenText)),
                        gapH10,
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                DateTime time = DateTime.parse(
                                    DateFormat.jm().format(DateTime.now()));
                                var time2 =
                                    time.add(const Duration(minutes: 10));
                                final reTime = DateFormat.jm().format(time2);
                                bloc.add(ChoiceEvent(
                                    isUpdate: true,
                                    time: reTime,
                                    date:
                                        DateFormat.jm().format(DateTime.now()),
                                    med: med));
                              },
                              child: const TimeAferWidget(
                                time: "10 دقائق",
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                print("innnnnnnnnnnnn1");
                                print("----------1");
                                final time1 = med.time.trim();
                                DateTime time = DateFormat.jm().parse(time1);
                                print("----------2");
                                DateFormat.jm().format(DateTime.now());
                                print(
                                    "----------${DateFormat.jm().format(time)}");
                                var time2 =
                                    time.add(const Duration(minutes: 30));
                                final reTime = DateFormat.jm().format(time2);
                                bloc.add(ChoiceEvent(
                                    isUpdate: true,
                                    time: reTime,
                                    date:
                                        DateFormat.jm().format(DateTime.now()),
                                    med: med));
                              },
                              child: const TimeAferWidget(
                                time: "30 دقيقة",
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                DateTime time = DateTime.parse(med.time);
                                var time2 =
                                    time.add(const Duration(minutes: 60));
                                final reTime = DateFormat.jm().format(time2);
                                bloc.add(ChoiceEvent(
                                    isUpdate: true,
                                    time: reTime,
                                    date:
                                        DateFormat.jm().format(DateTime.now()),
                                    med: med));
                              },
                              child: const TimeAferWidget(
                                time: "60 دقيقة",
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                DateTime time = DateTime.parse(med.time);
                                var time2 =
                                    time.add(const Duration(minutes: 120));
                                final reTime = DateFormat.jm().format(time2);
                                bloc.add(ChoiceEvent(
                                    isUpdate: true,
                                    time: reTime,
                                    date:
                                        DateFormat.jm().format(DateTime.now()),
                                    med: med));
                              },
                              child: const TimeAferWidget(
                                time: "120 دقيقة",
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
