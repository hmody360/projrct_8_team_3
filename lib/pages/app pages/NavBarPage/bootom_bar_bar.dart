import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/pages/app%20pages/AddPage/add_medication_page.dart';
import 'package:project_8_team3/pages/app%20pages/NavBarPage/bloc/nav_bloc.dart';

class BottomBarScreen extends StatelessWidget {
  const BottomBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<NavBloc>();
        return BlocBuilder<NavBloc, NavState>(
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: bloc.screen[bloc.currentTap],
              floatingActionButton: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(56),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(27, 209, 93, 0.2),
                      offset: Offset(0, 8),
                      spreadRadius: 0,
                      blurRadius: 24,
                    ),
                  ],
                ),
                child: FloatingActionButton(
                  onPressed: () {
                    context.pushTo(view: AddMedicationPage());
                  },
                  backgroundColor: teal,
                  child: Icon(Icons.add, size: 30, color: whiteColor),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: greenText),
                unselectedLabelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: blackColor),
                unselectedFontSize: 12,
                selectedFontSize: 12,
                showUnselectedLabels: true,
                currentIndex: bloc.currentTap,
                selectedItemColor: greenText,
                unselectedItemColor: darkGreyColor,
                onTap: (index) {
                  if (index != 2) {
                    bloc.add(ChangePageEvent(num: index));
                  }
                },
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/images/home.svg",
                      color: bloc.currentTap == 0 ? greenText : darkGreyColor,
                    ),
                    label: ("الرئيسية"),
                  ),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        "assets/images/medication.svg",
                        color: bloc.currentTap == 1 ? greenText : darkGreyColor,
                      ),
                      label: 'أدويتي'),
                  const BottomNavigationBarItem(icon: SizedBox(), label: ''),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        "assets/images/message.svg",
                        color: bloc.currentTap == 3 ? greenText : darkGreyColor,
                      ),
                      label: "اسأل ساعد"),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        "assets/images/qr-scan.svg",
                        color: bloc.currentTap == 4 ? greenText : darkGreyColor,
                      ),
                      label: 'مسح دواء'),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
