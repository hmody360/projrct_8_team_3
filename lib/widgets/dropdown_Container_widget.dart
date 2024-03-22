import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project_8_team3/data/service/supabase_services.dart';

import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/sized.dart';

class dropdownWidget extends StatefulWidget {
  dropdownWidget(
      {super.key,
      required this.path,
      required this.title,
      this.count = 30,
      required this.type});
  String title;
  String path;
  int count;
  String type;
  @override
  State<dropdownWidget> createState() => _dropdownWidgetState();
}

class _dropdownWidgetState extends State<dropdownWidget> {
  String dropDownValue = "....";

  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<DBService>();
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
          color: greyColor,
          borderRadius: const BorderRadius.all(Radius.circular(14)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
                  if (value != null) {
                    if (widget.type == "day") {
                      locator.days = value;
                    } else if(widget.type == "pill"){
                      locator.pill = value;
                    } else if(widget.type == "counts"){
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
            sizedBoxw20,
            Image.asset(widget.path)
          ],
        ),
      ),
    );
  }
}
