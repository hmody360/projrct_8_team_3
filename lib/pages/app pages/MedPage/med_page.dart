import 'package:flutter/material.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/sized.dart';
import 'package:project_8_team3/widgets/card_widget.dart';

class MedPage extends StatelessWidget {
  const MedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
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
                    fontSize: 33,
                  ),
                ),
              ),
              ListView(
                shrinkWrap: true,
                children: const [
                  CardWidget(
                    nameMed: "الزنك",
                    time: "5:30 ص",
                    medIcons: true,
                    done: true,
                  ),
                  CardWidget(
                    nameMed: "الزنك",
                    time: "5:30 ص",
                    medIcons: true,
                    done: true,
                  ),
                  CardWidget(
                    nameMed: "الزنك",
                    time: "5:30 ص",
                    medIcons: true,
                    done: true,
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
