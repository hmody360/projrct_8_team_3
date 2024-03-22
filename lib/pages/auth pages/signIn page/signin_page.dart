import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/helper/sized.dart';
import 'package:project_8_team3/pages/app%20pages/HomePage/home_page.dart';
import 'package:project_8_team3/pages/app%20pages/NavBarPage/bootom_bar_bar.dart';
import 'package:project_8_team3/pages/auth%20pages/sign%20up%20page/signup_page.dart';
import 'package:project_8_team3/pages/auth%20pages/signIn%20page/bloc/sign_in_bloc.dart';
import 'package:project_8_team3/widgets/button_widget.dart';
import 'package:project_8_team3/widgets/textfield_widget.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    return BlocProvider(
      create: (context) => SignInBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<SignInBloc>();
        return BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state is LoadingSignInState) {
              showDialog(
                  barrierDismissible: false,
                  barrierColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      content: SizedBox(
                        height: 80,
                        width: 80,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  });
            }
            if (state is SuccessSignInState) {
              Navigator.pop(context);
              context.showSuccessSnackBar(context, "successs log in");
              context.pushAndRemove(const BottomBarScreen());
            }
            if (state is ErrorSignInState) {
              Navigator.pop(context);
              context.showErrorSnackBar(context, state.massage);
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                            colors: [greenText, darkGreen],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            sizedBoxh60,
                            Image.asset(
                              'assets/images/newIcon.png',
                              width: 150,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 20, top: 30),
                              alignment: Alignment.centerRight,
                              child: Text(
                                "  تسجيل الدخول",
                                style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldWidget(
                          text: "الايميل",
                          controller: emailController,
                        ),
                        sizedBoxh30,
                        TextFieldWidget(
                          text: "كلمة المرور",
                          controller: passController,
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(0)),
                            onPressed: () {},
                            child: Text(
                              "هل نسيت كلمة المرور؟",
                              style: TextStyle(
                                  color: greenText,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                        sizedBoxh30,
                        ButtonWidget(
                          backgroundColor: darkGreen,
                          text: "تسجيل دخول",
                          onPressed: () {
                            if (emailController.text.isNotEmpty &&
                                passController.text.isNotEmpty) {
                              bloc.add(AddSignInEvent(
                                  email: emailController.text,
                                  password: passController.text));
                            } else {
                              context.showErrorSnackBar(
                                  context, "please fill the required data");
                            }
                          },
                          textColor: whiteColor,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "لا يوجد لديك حساب",
                              style: TextStyle(fontSize: 20),
                            ),
                            TextButton(
                              onPressed: () {
                                context.pushAndRemove(const SignUp());
                              },
                              child: Text(
                                "سجل الآن",
                                style:
                                    TextStyle(fontSize: 20, color: greenText),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
