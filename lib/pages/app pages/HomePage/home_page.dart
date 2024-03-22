import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/helper/sized.dart';
import 'package:project_8_team3/widgets/card_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: Size(context.getWidth(), context.getHeight() / 5),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                color: teal,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "مرحبا",
                    style: TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    "سارة",
                    style: TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              left: 32,
              top: 40,
              child: Text(
                "E",
                style: TextStyle(color: whiteColor, fontSize: 15),
              ),
            ),
            Positioned(
              top: 85,
              left: 32,
              child: Container(
                height: 144,
                width: 112,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    gapH10,
                    SvgPicture.asset("assets/saed.svg"),
                    Text(
                      "ساعد",
                      style: TextStyle(
                        color: teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              gapH40,
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "أدويتي",
                  style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              ListView(
                shrinkWrap: true,
                children: [
                  gapH15,
                  CardWidget(
                    nameMed: "الزنك",
                    time: "5:30 ص",
                    condition: "تم اخذ الدواء",
                    conditionColor: teal,
                    medIcons: false,
                    done: false,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
