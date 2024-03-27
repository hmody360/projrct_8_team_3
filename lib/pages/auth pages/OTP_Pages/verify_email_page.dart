import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/pages/auth%20pages/OTP_Pages/bloc/password_reset_bloc.dart';
import 'package:project_8_team3/pages/auth%20pages/OTP_Pages/verify_otp_page.dart';
import 'package:project_8_team3/widgets/button_widget.dart';
import 'package:project_8_team3/widgets/page_header.dart';
import 'package:project_8_team3/widgets/textfield_widget.dart';

// ignore: must_be_immutable
class VerifyEmailPage extends StatelessWidget {
  VerifyEmailPage({super.key});
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordResetBloc(),
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(context.getWidth(), 112),
            child: const PageHeader(
              canGoBack: true,
              bottomText: "تغيير كلمة المرور",
              height: 112,
              showImage: false,
            )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SingleChildScrollView(
            child: SizedBox(
              width: context.getWidth(),
              height: context.getHeight() * .8,
              child: BlocConsumer<PasswordResetBloc, PasswordResetState>(
                listener: (context, state) {
                  if (state is OtpErrorState) {
                    context.showErrorSnackBar(context, state.msg);
                  } else if (state is EmailVerifiedState) {
                    context.showSuccessSnackBar(context, state.msg);
                    context.pushTo(view: VerifyOtpPage(email: emailController.text,));
                  }
                },
                builder: (context, state) {
                  final prBloc = context.read<PasswordResetBloc>();
                  if (state is OtpLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: green,
                      ),
                    );
                  }else {
                    return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/images/forget_password.png"),
                      Text(
                        "هل نسيت كلمة المرور؟",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: context.getWidth() * .06,
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "يرجى إدخال الإيميل الخاص بك",
                            style: TextStyle(
                              color: blackColor,
                              fontSize: context.getWidth() * .05,
                            ),
                          )),
                      TextFieldWidget(
                          text: "الايميل", controller: emailController),
                      ButtonWidget(
                          backgroundColor: green,
                          text: "إرسال الرمز",
                          textColor: whiteColor,
                          onPressed: () {
                            prBloc
                                .add(SendOtpEvent(email: emailController.text));
                          })
                    ],
                  );
                  }
                  
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
