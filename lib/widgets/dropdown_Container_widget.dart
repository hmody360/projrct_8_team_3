import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project_8_team3/data/service/supabase_services.dart';

import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/helper/sized.dart';

// ignore: must_be_immutable
class DropDownWidget extends StatefulWidget {
  DropDownWidget({
    super.key,
    required this.path,
    required this.title,
    this.count = 30,
    required this.type,
    required this.page,
  });
  String title;
  String path;
  int count;
  String type;
  final int page;
  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String dropDownValue = "....";
  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<DBService>();
    if (widget.page == 2) {
      if (widget.type == "day") {
        dropDownValue = locator.days.toString();
      }
      if (widget.type == "pill") {
        dropDownValue = locator.pill.toString();
      }
    }
    return Container(
      padding: const EdgeInsets.all(8),
      width: context.getWidth(),
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
        color: greyColor,
        borderRadius: const BorderRadius.all(Radius.circular(14)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DropdownButton<int>(
            menuMaxHeight: 160,
            borderRadius: BorderRadius.circular(20),
            underline: const Text(""),
            icon: Row(
              children: [
                const Icon(
                  Icons.arrow_drop_down,
                  color: Color(0xff9B9B9B),
                ),
                Text(widget.title),
                gapH20,
                Text(dropDownValue),
              ],
            ),
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  if (widget.type == "day") {
                    locator.days = value;
                  } else if (widget.type == "pill") {
                    locator.pill = value;
                  } else if (widget.type == "counts") {
                    locator.counts = value;
                  }
                }
                dropDownValue = value.toString();
              });
            },
            items: List.generate(widget.count, (index) => index + 1)
                .map((value) => DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    ))
                .toList(),
          ),
          gapH20,
          Image.asset(widget.path)
        ],
      ),
    );
  }
}
