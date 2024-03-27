import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

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
  final String nameMed;
  final String time;
  final String? condition;
  final Color? conditionColor;
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

    DateTime conTime = DateFormat("h:mm").parse(time);
    DateTime now = DateTime.now();
    DateTime targerTime =
        DateTime(now.year, now.month, now.day, conTime.hour, conTime.minute);

    print("pp${time}pp");
    print("cc${targerTime}cc");
    print(" ======== time============= ");
    // print(DateFormat('h:mm a').parse(time));

    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // all(24),
      height: medIcons ? context.getWidth() * 0.44 : context.getWidth() * 0.25,
      width: context.getWidth() * 0.9,
      // 97,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: lightGray,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              gapWe10,
              SvgPicture.asset("assets/images/medication.svg"),
              gapWe20,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    gapH5,
                    Text(
                      nameMed, //Name Med
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    gapH5,
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
                    gapH20,
                  ],
                ),
              ),
              gapWe5,
              (medIcons)
                  ? Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          gapH20,
                          Row(
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
                                    context.moreBottomSheet(context, med);
                                  },
                                  child: const Icon(
                                      Icons.keyboard_arrow_down_rounded)),
                              gapH20,
                            ],
                          ),
                          gapH30,
                        ],
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                              condition!, //Condition Med
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              medIcons
                  ? Container(
                      width: context.getWidth() * 0.7,
                      padding: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: blackColor, width: 1)),
                        // color: Colors.amber,
                      ),
                      child: SizedBox(
                        width: context.getWidth() * 0.6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(" الوقت المتبقي : "),
                            TimerCountdown(
                              hoursDescription: "ساعة",
                              minutesDescription: "دقيقة",
                              secondsDescription: "ثانية",
                              format: CountDownTimerFormat.hoursMinutesSeconds,
                              endTime: DateTime.now().add(
                                Duration(
                                  hours: time.contains("PM") ? conTime.hour + 12 : conTime.hour, //microsecondsSinceEpoch,
                                  minutes: conTime.minute,
                                  seconds: 00,
                                ),
                              ),
                              onEnd: () {
                                print("لقد تجاوز الوقت المححد لأخذ الدواء ");
                              },
                            ),
                            // gapWe40,
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}