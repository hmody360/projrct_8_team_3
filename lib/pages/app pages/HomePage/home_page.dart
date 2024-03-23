import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:project_8_team3/data/service/supabase_services.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/helper/sized.dart';
import 'package:project_8_team3/pages/app%20pages/bloc/data_bloc.dart';
import 'package:project_8_team3/widgets/card_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<DBService>();
    final bloc = context.read<DataBloc>();
    bloc.add(GetMedicationEvent());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: Size(context.getWidth(), context.getHeight() / 5),
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
              right: 20,
              top: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "مرحبا",
                    style: TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    "سارة",
                    style: TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              left: 32,
              top: 40,
              child: Text(
                "E",
                style: TextStyle(color: whiteColor, fontSize: 15),
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
                    SvgPicture.asset("assets/images/saed.svg"),
                    Text(
                      "ساعد",
                      style: TextStyle(
                        color: teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              gapH40,
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "أدويتي",
                  style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              BlocConsumer<DataBloc, DataState>(
                listener: (context, state) {
                  if (state is LoadingHomeState) {
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
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.medications.length,
                        itemBuilder: (context, index) {
                          final med = state.medications[index];
                          
                          if (med.todayPills) {
                            return Column(
                              children: [
                                gapH15,
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
                                ),
                              ],
                            );
                          }
                          return null;
                        });
                  } else {
                    return sizedBoxEmpty;
                  }
                },
              ),
              gapH40,
            ],
          ),
        ),
      ),
    );
  }
}
