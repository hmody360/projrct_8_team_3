import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:project_8_team3/data/service/supabase_services.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/helper/sized.dart';
import 'package:project_8_team3/pages/app%20pages/bloc/data_bloc.dart';
import 'package:project_8_team3/widgets/card_widget.dart';

class MedPage extends StatelessWidget {
  const MedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<DBService>();
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
          child: Column(
            children: [
              gapH40,
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "أدويتي",
                  style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 33,
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
                    context.showErrorSnackBar(context, "هناك مشكلة بالبيانات");
                  }
                },
                builder: (context, state) {
                  if (state is SuccessHomeState) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.medications.length,
                        itemBuilder: (context, index) {
                          final med = state.medications[index];

                            return Column(
                              children: [
                                gapH15,
                                CardWidget(
                                  nameMed: med.medicationName,
                                  time: med.time,
                                  done: med.isCompleted,
                                  medIcons: true,
                                  med: med,
                                ),
                              ],
                            );

                        });
                  } else {
                    return sizedBoxEmpty;
                  }
                },
              ),
              // ListView(
              //   shrinkWrap: true,
              //   children: const [
              //     CardWidget(
              //       nameMed: "الزنك",
              //       time: "5:30 ص",
              //       medIcons: true,
              //       done: true,

              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
