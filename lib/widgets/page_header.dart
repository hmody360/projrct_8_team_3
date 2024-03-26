import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/helper/sized.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key, required this.bottomText, required this.height,
  });
  final String bottomText;
  final double height;



  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(),
      height: height,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16)),
          gradient: LinearGradient(
              colors: [greenText, darkGreen],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 10, left: 16, right: 16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              gapH15,
              Image.asset(
                'assets/images/splashscreenlogo.png',
                width: 120,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  bottomText,
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              )
            ]),
      ),
    );
  }
}
