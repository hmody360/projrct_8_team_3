import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/sized.dart';
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
  });
  //Home Page Requirds:
  final nameMed;
  final time;
  final condition;
  final conditionColor;
  //Med Page Requirds:
  final bool medIcons;
  final bool done;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: lightGray,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
            start: 8, end: 30, top: 8, bottom: 8),
        child: Row(
          children: [
            gapWe10,
            SvgPicture.asset("assets/medication.svg"),
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
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  gapH5,
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 20),
                    child: Row(
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
                  ),
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
                        InkWell(
                          child: Icon(
                            Icons.delete,
                            color: red,
                          ),
                        ),
                        sizedBoxw10,
                        InkWell(child: Image.asset("assets/edit.png")),
                        sizedBoxw10,
                        InkWell(
                            onTap: () {
                              moreBottomSheet(context);
                            },
                            child:
                                const Icon(Icons.keyboard_arrow_down_rounded))
                      ],
                    ),
                  )
                : Row(
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
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  moreBottomSheet(BuildContext context) {
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
                  const Text(
                    "تنبيه دواء الزنك\nبعد الاكل، 8:00",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonWidget(
                    onPressed: () {},
                    text: ("اخذ الدواء"),
                    backgroundColor: greenText,
                    textColor: whiteColor,
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
                    onPressed: () {},
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
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "اعادة الجدولة\n8:00",
                    textAlign: TextAlign.center,
                    style: TextStyle(
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
                      const Row(
                        children: [
                          TimeAferWidget(
                            time: "10 دقائق",
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          TimeAferWidget(
                            time: "30 دقيقة",
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        children: [
                          TimeAferWidget(
                            time: "60 دقيقة",
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          TimeAferWidget(
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
          );
        });
  }
}
