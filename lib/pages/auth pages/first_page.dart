import 'package:flutter/material.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/helper/sized.dart';
import 'package:project_8_team3/pages/auth%20pages/sign%20up%20page/signup_page.dart';
import 'package:project_8_team3/pages/auth%20pages/signIn%20page/signin_page.dart';
import 'package:project_8_team3/widgets/button_widget.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [greenText, darkGreen],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          sizedBoxHeight250,
          Image.asset(
            'assets/images/saedLogo.png',
            width: 180,
          ),
          sizedBoxh50,
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: whiteColor, borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(children: [
                  sizedBoxh40,
                  ButtonWidget(
                    text: "تسجيل دخول",
                    textColor: whiteColor,
                    backgroundColor: darkGreen,
                    onPressed: () {
                      context.pushAndRemove(const SigninPage());
                    },
                  ),
                  sizedBoxh30,
                  ButtonWidget(
                    text: "  تسجيل حساب جديد",
                    textColor: blackColor,
                    backgroundColor: whiteColor,
                    onPressed: () {
                      context.pushAndRemove(const SignUp());
                    },
                  ),
                ]),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
