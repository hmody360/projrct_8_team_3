import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_8_team3/data/model/medicattion_model.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/sized.dart';
import 'package:project_8_team3/pages/app%20pages/bloc/data_bloc.dart';
import 'package:project_8_team3/widgets/button_widget.dart';
import 'package:project_8_team3/widgets/time_after_widget.dart';

extension Screen on BuildContext {
  getWidth() {
    return MediaQuery.of(this).size.width;
  }

  getHeight() {
    return MediaQuery.of(this).size.height;
  }

  pushTo({required Widget view, Function(dynamic)? onValue}) {
    return Navigator.of(this)
        .push(MaterialPageRoute(builder: (context) => view))
        .then(onValue ?? (value) {});
  }

  getDialog({required String content}) {
    return showDialog(
        context: this,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(137, 158, 158, 158),
            elevation: 0,
            content: SizedBox(
              height: 200,
              width: 200,
              child: Center(child: Text(content)),
            ),
          );
        });
  }

  showSuccessSnackBar(
    BuildContext context,
    String msg,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      behavior: SnackBarBehavior.floating,
      content: Text(
        msg,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.green,
    ));
  }

  showErrorSnackBar(
    BuildContext context,
    String msg,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      behavior: SnackBarBehavior.floating,
      content: Text(
        msg,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.red,
    ));
  }

  popNav() {
    Navigator.pop(this);
  }

  // Push and remove
  pushAndRemove(Widget screen) {
    Navigator.pushAndRemoveUntil(this,
        MaterialPageRoute(builder: (context) => screen), (route) => false);
  }

  moreBottomSheet(BuildContext context, MedicationModel med) {
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
                        context.showStatusDialog(
                            title: "تأكيد أخذ الدواء",
                            dialogContent: "هل أنت متأكد من أخذك للدواء ؟",
                            action1: "تأكيد",
                            textStatus: "تم أخذ الدواء",
                            medication: med,
                            onTap: () {
                              context.popNav();
                              bloc.add(EditCompletedEvent(
                                  med: med, completed: true));
                            });
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
                      context.showStatusDialog(
                          title: "تاكيد إعادة جدولة الدواء",
                          dialogContent:
                              "هل أنت متأكد من  إعادة جدولة هذا الدواء ؟",
                          action1: "إعادة جدولة",
                          textStatus: "إعادة جدولة",
                          medication: med,
                          onTap: () {
                            context.popNav();
                            reschadulBottomSheet(med);
                          });
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
                      context.showStatusDialog(
                          title: "تاكيد تخطي الدواء",
                          dialogContent: "هل أنت متأكد من تخطي هذا الدواء ؟",
                          action1: "تخطي",
                          textStatus: "تم التخطي",
                          medication: med,
                          onTap: () {
                            context.popNav();
                            bloc.add(
                                EditCompletedEvent(med: med, completed: false));
                          });
                    },
                    text: ("تخطي"),
                    backgroundColor: greenText,
                    textColor: whiteColor,
                  ),
                  gapH15,
                ],
              ),
            ),
          );
        });
  }

  reschadulBottomSheet(MedicationModel med) {
    final bloc = read<DataBloc>();
    showModalBottomSheet(
        context: this,
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
                            TimeAferWidget(
                              onPressed: () {
                                final time1 = med.time.trim();
                                DateTime time = DateFormat.jm().parse(time1);
                                DateFormat.jm().format(DateTime.now());
                                print(
                                    "----------${DateFormat.jm().format(time)}");
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
                              time: "10 دقائق",
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            TimeAferWidget(
                              onPressed: () {
                                 final time1 = med.time.trim();
                                DateTime time = DateFormat.jm().parse(time1);
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
                              time: "30 دقيقة",
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            TimeAferWidget(
                              onPressed: () {
                                final time1 = med.time.trim();
                                DateTime time = DateFormat.jm().parse(time1);
                                DateFormat.jm().format(DateTime.now());
                                print(
                                    "----------${DateFormat.jm().format(time)}");
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
                              time: "60 دقيقة",
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            TimeAferWidget(
                              onPressed: () {
                                 final time1 = med.time.trim();
                                DateTime time = DateFormat.jm().parse(time1);
                                DateFormat.jm().format(DateTime.now());
                                print(
                                    "----------${DateFormat.jm().format(time)}");
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
                              time: "120 دقيقة",
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

  showStatusDialog({
    // BuildContext context,
    required String title,
    required String dialogContent,
    required String action1,
    String? textStatus,
    MedicationModel? medication,
    final onTap,
    final onTap1,
    final onTap2,
    final onTap3,
  }) {
    showDialog(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.right,
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w600, color: greenText),
        ),
        content: Text(
          dialogContent,
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 16, color: blackColor),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // onTap,
              context.popNav();
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child: Text(
                "إلغاء",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: gray, fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          TextButton(
            onPressed:
                onTap,
            child: Container(
              padding: const EdgeInsets.all(14),
              child: Text(
                action1,
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: greenText,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
