import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/helper/sized.dart';
import 'package:project_8_team3/pages/app%20pages/NavBarPage/bootom_bar_bar.dart';
import 'package:project_8_team3/pages/auth%20pages/OTP_Pages/verify_email_page.dart';
import 'package:project_8_team3/pages/auth%20pages/sign%20up%20page/signup_page.dart';
import 'package:project_8_team3/pages/auth%20pages/signIn%20page/bloc/sign_in_bloc.dart';
import 'package:project_8_team3/widgets/button_widget.dart';
import 'package:project_8_team3/widgets/page_header.dart';
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
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size(context.getWidth(), 270),
              child: const PageHeader(bottomText: "تسجيل الدخول", height: 270)),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: SizedBox(
                height: context.getHeight() * .6,
                child: BlocConsumer<SignInBloc, SignInState>(
                  listener: (context, state) {
                    if (state is SuccessSignInState) {
                      context.showSuccessSnackBar(context, state.msg);
                      context.pushAndRemove(const BottomBarScreen());
                    }
                    if (state is ErrorSignInState) {
                      context.showErrorSnackBar(context, state.massage);
                    }
                    if (state is SuccessResetState) {
                      context.showSuccessSnackBar(context, state.msg);
                    }
                  },
                  builder: (context, state) {
                    if (state is LoadingSignInState) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: green,
                        ),
                      );
                    } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextFieldWidget(
                          text: "الايميل",
                          controller: emailController,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFieldWidget(
                              text: "كلمة المرور",
                              controller: passController,
                              obscure: true,
                            ),
                            TextButton(
                                style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(0)),
                                onPressed: () {
                                  context.pushTo(view: VerifyEmailPage());
                                },
                                child: Text(
                                  "هل نسيت كلمة المرور؟",
                                  style: TextStyle(
                                      color: greenText,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ButtonWidget(
                              backgroundColor: darkGreen,
                              text: "تسجيل دخول",
                              onPressed: () {
                                bloc.add(AddSignInEvent(
                                    email: emailController.text,
                                    password: passController.text));
                              },
                              textColor: whiteColor,
                            ),
                            gapH15,
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "لا يوجد لديك حساب؟  ",
                                  style: TextStyle(
                                      color: blackColor,
                                      fontSize: 20,
                                      fontFamily:
                                          GoogleFonts.vazirmatn().fontFamily),
                                ),
                                TextSpan(
                                    text: "سجل الآن",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: greenText,
                                        fontFamily:
                                            GoogleFonts.vazirmatn().fontFamily),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context
                                            .pushAndRemove(const SignUpPage());
                                      })
                              ]),
                            ),
                          ],
                        ),
                      ],
                    );
                    }
                  },
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
