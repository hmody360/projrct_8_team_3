import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:project_8_team3/bloc/user_name_bloc.dart';
import 'package:project_8_team3/data/service/supabase_services.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/helper/sized.dart';
import 'package:project_8_team3/pages/app%20pages/ProfilePage/profile_page.dart';
import 'package:project_8_team3/pages/app%20pages/bloc/data_bloc.dart';
import 'package:project_8_team3/widgets/card_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final locator = GetIt.I.get<DBService>();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DataBloc>();
    bloc.add(GetMedicationEvent());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: Size(context.getWidth(), context.getHeight() / 5),
        child: SizedBox(
          width: context.getWidth(),
          height: context.getHeight() * 0.29,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 172,
                decoration: BoxDecoration(
                  color: teal,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
              ),
              Positioned(
                right: context.getWidth() * 0.04,
                bottom: context.getHeight() * 0.06,
                child: Text(
                  "مرحباً ",
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Positioned(
                right: context.getWidth() * 0.08,
                bottom: context.getHeight() * 0.01,
                child: BlocBuilder<UserNameBloc, UserNameState>(
                  builder: (context, state) {
                    if (state is GetUserNameState) {
                      return Text(
                        locator.name.split(" ")[0],
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: 32,
                            fontWeight: FontWeight.w700),
                      );
                    }
                    return Text(
                      "بك",
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: 32,
                          fontWeight: FontWeight.w700),
                    );
                  },
                ),
            ),
                Positioned(
                left: 330,
                top: 35,
                child: IconButton(onPressed: (){
                  context.pushTo(view: ProfilePage());
                }, icon: Icon(Icons.person, color: whiteColor,))
              ),
              Positioned(
                left: 32,
                top: 40,
                child: Container(
                  padding: const EdgeInsets.only(top: 3, left: 4, right: 4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: yellow, width: 1)),
                  child: Text(
                    "E",
                    style: TextStyle(color: whiteColor, fontSize: 15),
                  ),
                ),
              ),
              Positioned(
                top: 85,
                left: 32,
                child: Container(
                  width: 110,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Column(
                    children: [
                      gapH10,
                      Image.asset("assets/images/saed_image.png"),
                      Text(
                        "ساعد",
                        style: TextStyle(
                          color: teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.only(
              right: 24.0, left: 24, bottom: 8, top: 45),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "أدويتي",
                  style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              gapH10,
              BlocConsumer<DataBloc, DataState>(
                listener: (context, state) {
                  if (state is LoadingHomeState) {
                    showDialog(
                        barrierDismissible: false,
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            content: SizedBox(
                              height: 80,
                              width: 80,
                              child: Center(
                                child: CircularProgressIndicator(color: green,),
                              ),
                            ),
                          );
                        });
                  }
    
                  if (state is SuccessHomeState) {
                    Navigator.pop(context);
                  }
                  if (state is ErrorHomeState) {
                    Navigator.pop(context);
                    context.showErrorSnackBar(context, state.msg);
                  }
                },
                builder: (context, state) {
                  if (state is SuccessHomeState) {
                    if (state.medications.isNotEmpty) {
                      return SizedBox(
                        height: context.getHeight() * 0.56,
                        width: context.getWidth(),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.medications.length,
                          itemBuilder: (context, index) {
                            final med = state.medications[index];
                            if (med.todayPills) {
                              return
                                  // Column(
                                  //   children: [
                                  //     gapH15,
                                  CardWidget(
                                nameMed: med.medicationName,
                                time: med.time,
                                condition: med.isUpdate
                                    ? "تم اعادة الجدولة"
                                    : med.isCompleted
                                        ? "تم اخذ الدواء"
                                        : "تم التخطي",
                                conditionColor: med.isUpdate
                                    ? yellow
                                    : med.isCompleted
                                        ? teal
                                        : red,
                                medIcons: false,
                                done: false,
                                med: med,
                              );
                            }
                            return sizedBoxEmpty;
                          },
                        ),
                      );
                    } else {
                      return SizedBox(
                        width: context.getWidth(),
                        height: context.getHeight() * .4,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("لا توجد لديك ادوية !",)
                            ],
                        ),
                      );
                    }
                  } else {
                    return sizedBoxEmpty;
                  }
                },
              ),
              // gapH40,
            ],
          ),
        ),
      ),
    );
  }
}
