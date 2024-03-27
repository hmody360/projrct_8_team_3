import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/pages/auth%20pages/OTP_Pages/bloc/password_reset_bloc.dart';
import 'package:project_8_team3/widgets/button_widget.dart';
import 'package:project_8_team3/widgets/page_header.dart';

// ignore: must_be_immutable
class VerifyOtpPage extends StatelessWidget {
  VerifyOtpPage({super.key, required this.email});
  TextEditingController otpController = TextEditingController();
  final String email
;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordResetBloc(),
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(context.getWidth(), 112),
            child: const PageHeader(
              canGoBack: true,
              bottomText: "التحقق من الرمز",
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
                  } else if (state is OtpVerifiedState) {
                    context.showSuccessSnackBar(context, state.msg);
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
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("assets/images/otp.png"),
                        Text(
                          "تم إرسال الرمز إلى بريدك الإلكتروني.",
                          style: TextStyle(
                            color: blackColor,
                            fontSize: context.getWidth() * .06,
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "يرجى إدخال الرمز للتحقق",
                              style: TextStyle(
                                color: blackColor,
                                fontSize: context.getWidth() * .05,
                              ),
                            )),
                        OtpTextField(
                          alignment: Alignment.centerLeft,
                          showFieldAsBox: true,
                          borderRadius: BorderRadius.circular(10),
                          fieldWidth: context.getWidth() * .12,
                          fieldHeight: context.getHeight() * .09,
                          borderColor: gray,
                          numberOfFields: 6,
                          obscureText: true,
                          onSubmit: (value) {
                            prBloc.add(
                                VerifyOtpEvent(otpToken: value, email: email));
                          },
                        ),
                        ButtonWidget(
                            backgroundColor: green,
                            text: "التحقق",
                            textColor: whiteColor,
                            onPressed: () {
                              prBloc.add(
                                  VerifyOtpEvent(otpToken: otpController.text, email: email));
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
