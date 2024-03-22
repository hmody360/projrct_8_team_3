import 'package:flutter/material.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/sized.dart';


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
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: 72,
        width: 360,
        decoration: BoxDecoration(
          color: lightGray,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              gapWe10,
              Image.asset("assets/pall0.png"),
              gapWe5,
              Column(
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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Text(
                          time, //Time Med
                          style: const TextStyle(fontSize: 13),
                        ),
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
                ],
              ),

              gapWe10,
              gapWe20,
              gapWe20,
              gapWe20,
              //حالة اخذ الدواء

              (medIcons)
                  ? Row(
                      children: [
                        gapWe40,
                        Icon(
                          Icons.delete,
                          color: red,
                        ),
                        gapWe5,
                        Image.asset("assets/edit.png"),
                      ],
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
      ),
    );
  }
}
