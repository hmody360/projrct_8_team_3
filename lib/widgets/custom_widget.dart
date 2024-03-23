import 'package:flutter/material.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.width = 40});
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.popNav();
      },
      child: Container(
        margin: const EdgeInsetsDirectional.only(start: 20),
        width: width,
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
            color: greyColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(14),
            )),
        child: Center(
            child: Icon(
          Icons.arrow_back,
          color: darkGreyColor,
        )),
      ),
    );
  }
}
