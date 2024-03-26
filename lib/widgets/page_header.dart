import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/helper/sized.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key, required this.bottomText, required this.height, this.showImage = true, this.canGoBack = false,
  });
  final String bottomText;
  final double height;
  final bool? showImage;
  final bool? canGoBack;



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
              (canGoBack!) ? Align(alignment: Alignment.centerLeft, child: IconButton(onPressed: (){context.popNav();}, icon: Icon(Icons.arrow_forward_ios_rounded, color: whiteColor,)),) : sizedBoxEmpty,
              (showImage!) ? gapH15 : sizedBoxEmpty,
              (showImage!) ? Image.asset(
                'assets/images/splashscreenlogo.png',
                width: 120,
              ) : sizedBoxEmpty,
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
