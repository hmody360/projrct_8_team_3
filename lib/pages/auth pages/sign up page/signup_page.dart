import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/helper/sized.dart';
import 'package:project_8_team3/pages/auth%20pages/sign%20up%20page/bloc/sign_up_bloc.dart';
import 'package:project_8_team3/pages/auth%20pages/signIn%20page/signin_page.dart';
import 'package:project_8_team3/widgets/button_widget.dart';
import 'package:project_8_team3/widgets/textfield_widget.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

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
          body: BlocConsumer<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state is LoadingSignUpState) {
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
              if (state is SuccessSignUpState) {
                Navigator.pop(context);
                context.pushTo(view: const SigninPage());
              }
              if (state is ErrorSignUpState) {
                Navigator.pop(context);
                context.showErrorSnackBar(context, state.msg);
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.33,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                            colors: [greenText, darkGreen],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            sizedBoxh60,
                            Image.asset(
                              'assets/images/saedLogo.png',
                              width: 100,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "  تسجيل حساب",
                                    style: TextStyle(
                                        color: whiteColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          ]),
                    ),
                  ),
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
                  ),
                  sizedBoxh30,
                  ButtonWidget(
                    backgroundColor: darkGreen,
                    text: "تسجيل الحساب",
                    onPressed: () {
                      if (emailController.text.isNotEmpty &&
                          passController.text.isNotEmpty &&
                          nameController.text.isNotEmpty) {
                        bloc.add(CreateAccountEvent(
                          email: emailController.text,
                          password: passController.text,
                          name: nameController.text,
                        ));
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
                      TextButton(
                        onPressed: () {
                          context.pushAndRemove(const SigninPage());
                        },
                        child: Text(
                          "تسجيل الدخول",
                          style: TextStyle(fontSize: 20, color: greenText),
                        ),
                      ),
                      const Text(
                        " يوجد لديك حساب؟",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  )
                ],
              );
            },
          ),
        );
      }),
    );
  }
}
