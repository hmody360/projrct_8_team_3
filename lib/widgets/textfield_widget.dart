import 'package:flutter/material.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/sized.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {super.key, required this.text, required this.controller, this.obscure, this.height, this.isEditible = true});
  final String text;
  final TextEditingController? controller;
  final bool? obscure;
  final double? height;
  final bool? isEditible;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        gapH5,
        SizedBox(
          height: height,
          child: TextField(
            readOnly: !isEditible!,
            enabled: isEditible,
            controller: controller,
            obscureText: obscure ?? false,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: green)),
                border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            )),
          ),
        )
      ],
    );
  }
}
