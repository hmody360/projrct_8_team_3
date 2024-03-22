import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/sized.dart';

// ignore: must_be_immutable
class dropdownWidget extends StatefulWidget {
  dropdownWidget({super.key, required this.path, required this.title});
  String title;
  String path;

  @override
  State<dropdownWidget> createState() => _dropdownWidgetState();
}

class _dropdownWidgetState extends State<dropdownWidget> {
  String dropDownValue = "....";

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
          color: greyColor,
          borderRadius: const BorderRadius.all(Radius.circular(14)),
        ),
        child: Row(
          children: [
            DropdownButton<int>(
              underline: const Text(""),
              icon: Row(
                children: [
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Color(0xff9B9B9B),
                  ),
                  Text(widget.title),
                  sizedBoxw20,
                  Text(dropDownValue),
                ],
              ),
              onChanged: (value) {
                setState(() {
                  dropDownValue = value.toString();
                });
              },
              items: List.generate(30, (index) => index + 1)
                  .map((value) => DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      ))
                  .toList(),
            ),
            sizedBoxw20,
            SizedBox(
              height: 30,
              child: SvgPicture.asset(
                widget.path,
                colorFilter: ColorFilter.mode(darkGreyColor, BlendMode.srcIn),
              ),
            )
          ],
        ),
      ),
    );
  }
}
