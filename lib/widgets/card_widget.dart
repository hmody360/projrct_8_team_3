
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:project_8_team3/data/model/medicattion_model.dart';
import 'package:project_8_team3/data/service/supabase_services.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/helper/sized.dart';
import 'package:project_8_team3/pages/app%20pages/MedPage/edit_midication.dart';
import 'package:project_8_team3/pages/app%20pages/bloc/data_bloc.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.nameMed,
    required this.time,
    this.condition,
    this.conditionColor,
    this.medIcons = false,
    this.done = true,
    required this.med,
  });
  //Home Page Requirds:
  final nameMed;
  final time;
  final condition;
  final conditionColor;
  //Med Page Requirds:
  final bool medIcons;
  final bool done;
  final MedicationModel med;

  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<DBService>();
    final bloc = context.read<DataBloc>();
    void edit() async {
      await locator.editNotUpdate(medication: med);
    }

    // final DateTime date = DateTime.parse(med.updateTimeDate);
    // if (date != DateTime.now()) {
    //   edit();
    // }
    // final date2 = med.createdAt.add(Duration(days: med.days));
    // if (DateTime.now().isAfter(date2)) {
    //   bloc.add(DeleteMedicationEvent(medID: med.medicationId));
    // }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12) , // all(24),
      height: context.getWidth() * 0.25,
      width: context.getWidth() * 0.9,
      // 97,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: lightGray,
        borderRadius: BorderRadius.circular(24),
      ),
      child:
      //  Padding(
      //   padding: const EdgeInsetsDirectional.only(
      //       start: 8, end: 30, top: 8, bottom: 8),
      //   child:
         Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            gapWe10,
            SvgPicture.asset("assets/images/medication.svg"),
            gapWe20,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gapH5,
                  Text(
                    nameMed, //Name Med
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  gapH5,
                  
                    Row(
                      children: [
                        Text(
                          time, //Time Med
                          style: const TextStyle(fontSize: 13),
                        ),
                        (medIcons)
                            ?
                            //حالة اخذ الدواء
                            (done)
                                ? const Text(
                                    ". تم", //Done or not Med
                                    style: TextStyle(fontSize: 13),
                                  )
                                : const Text(
                                    ". لم تتم", //Done or not Med
                                    style: TextStyle(fontSize: 13),
                                  )
                            : const SizedBox(),
                      ],
                    ),
                  // ),
                ],
              ),
            ),

            gapWe5,
            // gapWe20,
            //حالة اخذ الدواء

            (medIcons)
                ? Expanded(
                    child: Row(
                      children: [
                        const Spacer(),
                        gapH10,
                        InkWell(
                            onTap: () {
                              context.pushTo(
                                  view: EditMedicationPage(
                                medication: med,
                              ));
                            },
                            child: Image.asset("assets/images/edit.png")),
                        gapH10,
                        InkWell(
                            onTap: () {
                             context.moreBottomSheet(context, med);
                            },
                            child:
                                const Icon(Icons.keyboard_arrow_down_rounded))
                      ],
                    ),
                  )
                : Column(
                    children: [
                      gapH10,
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color: conditionColor, //Color Med
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          gapWe5,
                          Text(
                            condition, //Condition Med
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      if (condition == "تم اعادة الجدولة")
                        Text(
                          med.updateTime,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                    ],
                  ),
          ],
        )
      );
  }

}




// /=============================================================



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get_it/get_it.dart';
// import 'package:project_8_team3/data/model/medicattion_model.dart';
// import 'package:project_8_team3/data/service/supabase_services.dart';
// import 'package:project_8_team3/helper/colors.dart';
// import 'package:project_8_team3/helper/extintion.dart';
// import 'package:project_8_team3/helper/sized.dart';
// import 'package:project_8_team3/pages/app%20pages/MedPage/edit_midication.dart';
// import 'package:project_8_team3/pages/app%20pages/bloc/data_bloc.dart';

// class CardWidget extends StatelessWidget {
//   const CardWidget({
//     super.key,
//     // required this.nameMed,
//     // required this.time,
//     // this.condition,
//     // this.conditionColor,
//     this.medIcons = false,
//     this.done = true,
//     // required this.med,
//   });
//   // //Home Page Requirds:
//   // final nameMed;
//   // final time;
//   // final condition;
//   // final conditionColor;
//   // //Med Page Requirds:
//   final bool medIcons;
//   final bool done;
//   // final MedicationModel med;

//   @override
//   Widget build(BuildContext context) {
//     final locator = GetIt.I.get<DBService>();
//     final bloc = context.read<DataBloc>();
//     // void edit() async {
//     //   await locator.editNotUpdate(medication: med);
//     // }

//     // final DateTime date = DateTime.parse(med.updateTimeDate);
//     // if (date != DateTime.now()) {
//     //   edit();
//     // }
//     // final date2 = med.createdAt.add(Duration(days: med.days));
//     // if (DateTime.now().isAfter(date2)) {
//     //   bloc.add(DeleteMedicationEvent(medID: med.medicationId));
//     // }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12) , // all(24),
//       height: context.getWidth() * 0.25,
//       width: context.getWidth() * 0.9,
//       // 97,
//       margin: const EdgeInsets.only(bottom: 6),
//       decoration: BoxDecoration(
//         color: lightGray,
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child:
//       //  Padding(
//       //   padding: const EdgeInsetsDirectional.only(
//       //       start: 8, end: 30, top: 8, bottom: 8),
//       //   child:
//          Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             gapWe10,
//             SvgPicture.asset("assets/images/medication.svg"),
//             gapWe20,
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   gapH5,
//                   Text(
//                     "فيتامين د",
//                     // nameMed, //Name Med
//                     style: TextStyle(
//                       color: blackColor,
//                       fontSize: 13,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   gapH5,
                  
//                     Row(
//                       children: [
//                         const Text(
//                           "9: 30 ص",
//                           // time, //Time Med
//                           style: TextStyle(fontSize: 13),
//                         ),
//                         (medIcons)
//                             ?
//                             //حالة اخذ الدواء
//                             (done)
//                                 ? const Text(
//                                     ". تم", //Done or not Med
//                                     style: TextStyle(fontSize: 13),
//                                   )
//                                 : const Text(
//                                     ". لم تتم", //Done or not Med
//                                     style: TextStyle(fontSize: 13),
//                                   )
//                             : const SizedBox(),
//                       ],
//                     ),
//                   // ),
//                 ],
//               ),
//             ),

//             gapWe5,
//             // gapWe20,
//             //حالة اخذ الدواء

//             (medIcons)
//                 ? Expanded(
//                     child: Row(
//                       children: [
//                         const Spacer(),
//                         gapH10,
//                         InkWell(
//                             onTap: () {
//                               // context.pushTo(
//                               //     view: EditMedicationPage(
//                               //   medication: med,
//                               // ));
//                             },
//                             child: Image.asset("assets/images/edit.png")),
//                         gapH10,
//                         InkWell(
//                             onTap: () {
//                              context.moreBottomSheet(context, med);
//                             },
//                             child:
//                                 const Icon(Icons.keyboard_arrow_down_rounded))
//                       ],
//                     ),
//                   )
//                 : 
//                 Column(
//                     children: [
//                       gapH10,
//                       Row(
//                         children: [
//                           Container(
//                             height: 10,
//                             width: 10,
//                             decoration: BoxDecoration(
//                                 // color: conditionColor, //Color Med
//                                 borderRadius: BorderRadius.circular(10)),
//                           ),
//                           gapWe5,
//                           Text( 'test',
//                             // condition, //Condition Med
//                             style: TextStyle(
//                               color: blackColor,
//                               fontSize: 13,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ],
//                       ),
//                       // if (condition == "تم اعادة الجدولة")
//                       //   Text(
//                       //     med.updateTime,
//                       //     style: TextStyle(
//                       //       color: blackColor,
//                       //       fontSize: 13,
//                       //       fontWeight: FontWeight.w400,
//                       //     ),
//                       //   ),
//                     ],
//                   ),
        
//           ],
//         )
//       );
//   }

// }
