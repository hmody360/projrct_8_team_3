import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:project_8_team3/data/service/supabase_services.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/helper/sized.dart';
import 'package:project_8_team3/pages/app%20pages/ProfilePage/bloc/profile_bloc.dart';
import 'package:project_8_team3/widgets/button_widget.dart';
import 'package:project_8_team3/widgets/page_header.dart';
import 'package:project_8_team3/widgets/textfield_widget.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isEditing = false;

  final locator = GetIt.I.get<DBService>();
  

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(GetUserInfoEvent()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
            preferredSize: Size(context.getWidth(), 140),
            child: const PageHeader(
              bottomText: "حسابك الشخصي",
              height: 140,
              showImage: false,
              canGoBack: true,
            )),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ActivatedEditModeState) {
                isEditing = true;
              }else if (state is DeactivatedEditModeState) {
                isEditing = false;
              } else if (state is ProfileErrorState) {
                context.showErrorSnackBar(context, state.msg);
              } else if (state is DisplayUserInfoState) {
                nameController.text = locator.name;
                emailController.text = locator.email;
                isEditing = false;
              }
            },
            builder: (context, state) {
              if (state is ProfileLoadingState) {
                return Center(
                  child: CircularProgressIndicator(
                    color: green,
                  ),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          "assets/images/blackuser.png",
                          width: 150,
                          height: 150,
                        ),
                        gapH15,
                        TextFieldWidget(
                          text: "الاسم",
                          controller: nameController,
                          isEditible: isEditing,
                        ),
                        gapH15,
                        TextFieldWidget(
                          text: "الإيميل",
                          controller: emailController,
                          isEditible: false,
                        ),
                      ],
                    ),
                    (isEditing)
                        ? Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: ButtonWidget(
                                    backgroundColor: green,
                                    text: "حفظ",
                                    textColor: whiteColor,
                                    onPressed: () {
                                      context.read<ProfileBloc>().add(
                                          UpdateUserInfoEvent(
                                              name: nameController.text));
                                    }),
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                              Expanded(
                                flex: 2,
                                child: ButtonWidget(
                                    backgroundColor: red,
                                    text: "إلغاء",
                                    textColor: whiteColor,
                                    onPressed: () {
                                      context
                                          .read<ProfileBloc>()
                                          .add(DeactivateEditModeEvent());
                                    }),
                              ),
                            ],
                          )
                        : ButtonWidget(
                            backgroundColor: green,
                            text: "تعديل",
                            textColor: whiteColor,
                            onPressed: () {
                              context
                                  .read<ProfileBloc>()
                                  .add(ActivateEditModeEvent());
                            }),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
