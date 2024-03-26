import 'package:flutter/material.dart';
import 'package:project_8_team3/helper/colors.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key,
      required this.backgroundColor,
      required this.text,
      required this.textColor,
      this.borderColor,
      required this.onPressed});
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shadowColor: borderColor,
            elevation: 2,
            minimumSize: const Size(double.infinity, 60),
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: borderColor ?? transparent),
                borderRadius: const BorderRadius.all(Radius.circular(10)))),
        onPressed: onPressed,
        child: Text(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          text,
          style: TextStyle(
              color: textColor, fontWeight: FontWeight.w900, fontSize: 20),
        ));
  }
}
