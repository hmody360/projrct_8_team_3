import 'package:flutter/material.dart';
import 'package:project_8_team3/helper/sized.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatelessWidget {
   TextFieldWidget({super.key, required this.text,required this.controller});
  final String text;
  TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        sizedBoxh5,
        TextField(
          controller: controller,
          decoration: InputDecoration(
              border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          )),
        )
      ],
    );
  }
}
