import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/helper/sized.dart';
import 'package:project_8_team3/pages/auth%20pages/sign%20up%20page/bloc/sign_up_bloc.dart';
import 'package:project_8_team3/pages/auth%20pages/signIn%20page/signin_page.dart';
import 'package:project_8_team3/widgets/button_widget.dart';
import 'package:project_8_team3/widgets/page_header.dart';
import 'package:project_8_team3/widgets/textfield_widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController passController = TextEditingController();
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<SignUpBloc>();
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(context.getWidth(), 280),
            child: const PageHeader(
              height: 280,
              bottomText: "تسجيل حساب",
            ),
          ),
          body: BlocConsumer<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state is SuccessSignUpState) {
                context.showSuccessSnackBar(context, state.msg);
                context.pushTo(view: const SigninPage());
              }
              if (state is ErrorSignUpState) {
                context.showErrorSnackBar(context, state.msg);
              }
            },
            builder: (context, state) {
              if (state is LoadingSignUpState){
                return Center(child: CircularProgressIndicator(
                  color: green,
                ),);
              }else{
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: context.getHeight() * .6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextFieldWidget(
                          text: "الاسم",
                          controller: nameController,
                        ),
                        TextFieldWidget(
                          text: "الايميل",
                          controller: emailController,
                        ),
                        TextFieldWidget(
                          text: "كلمة المرور",
                          controller: passController,
                          obscure: true,
                        ),
                        gapH10,
                        Column(
                          children: [
                            ButtonWidget(
                              backgroundColor: darkGreen,
                              text: "تسجيل الحساب",
                              onPressed: () {
                                bloc.add(CreateAccountEvent(
                                  email: emailController.text,
                                  password: passController.text,
                                  name: nameController.text,
                                ));
                              },
                              textColor: whiteColor,
                            ),
                            gapH5,
                            RichText(
                              text: TextSpan(
                              children: [
                                TextSpan(text: "يوجد لديك حساب؟  ", style: TextStyle(color: blackColor ,fontSize: 20, fontFamily: GoogleFonts.vazirmatn().fontFamily),),
                                TextSpan(text: "تسجيل الدخول", style: TextStyle(
                                        fontSize: 20, color: greenText, fontFamily: GoogleFonts.vazirmatn().fontFamily), recognizer: TapGestureRecognizer()..onTap =() {
                                          context.pushAndRemove(const SigninPage());
                                        })
                              ]
                            ),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
              }
            },
          ),
        );
      }),
    );
  }
}
