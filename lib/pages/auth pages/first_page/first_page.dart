import 'package:flutter/material.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/pages/auth%20pages/sign%20up%20page/signup_page.dart';
import 'package:project_8_team3/pages/auth%20pages/signIn%20page/signin_page.dart';
import 'package:project_8_team3/widgets/button_widget.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.getWidth(),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [greenText, darkGreen],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'assets/images/saedLogo.png',
            width: 180,
          ),
        ]),
      ),
      bottomSheet: Container(
        width: context.getWidth(),
        height: context.getHeight() * .35,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 64),
        decoration: BoxDecoration(
            color: whiteColor, borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          ButtonWidget(
            text: "تسجيل دخول",
            textColor: whiteColor,
            backgroundColor: darkGreen,
            onPressed: () {
              context.pushAndRemove(const SigninPage());
            },
          ),
          ButtonWidget(
            text: "تسجيل حساب جديد",
            textColor: blackColor,
            backgroundColor: whiteColor,
            onPressed: () {
              context.pushAndRemove(const SignUpPage());
            },
          ),
        ]),
      ),
    );
  }
}
