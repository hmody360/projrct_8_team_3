
import 'package:flutter/material.dart';
import 'package:project_8_team3/helper/colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 20),
      width: 40,
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
    );
  }
}