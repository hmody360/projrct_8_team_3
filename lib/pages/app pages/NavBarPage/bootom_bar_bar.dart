import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/pages/app%20pages/AddPage/add_page.dart';
import 'package:project_8_team3/pages/app%20pages/NavBarPage/bloc/nav_bloc.dart';
import 'package:project_8_team3/pages/app%20pages/NavBarPage/widgets/floating_postion.dart';


class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<NavBloc>();
        return BlocBuilder<NavBloc, NavState>(
          builder: (context, state) {
            return Scaffold(
              body: PageStorage(
                bucket: bloc.bucket,
                child: bloc.currentScreen,
              ),
              floatingActionButton: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(56),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromRGBO(27, 209, 93, 0.2),
                        offset: Offset(0, 8),
                        spreadRadius: 0,
                        blurRadius: 24),
                  ],
                ),
                child: FloatingActionButton(
                  onPressed: () {
                    context.pushTo(view: const AddPage());
                  },
                  backgroundColor: teal,
                  child: Icon(Icons.add, color: whiteColor),
                ),
              ),
              floatingActionButtonLocation:
                  const CustomFloatingActionButtonLocation(
                FloatingActionButtonLocation.centerDocked,
                offsetY: 25.0, //  move the button downwards
              ),
              bottomNavigationBar: BottomAppBar(
                elevation: 0,
                color: whiteColor,
                notchMargin: 10,
                child: SizedBox(
                  height: kBottomNavigationBarHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MaterialButton(
                            minWidth: 40,
                            onPressed: () {
                              bloc.add(ChangePageEvent(num: 0));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                bloc.currentTap == 0
                                    ? Image.asset("assets/menu1.png")
                                    : Image.asset("assets/menu0.png"),
                                Text(
                                  'الرئيسية',
                                  style: TextStyle(
                                    color: bloc.currentTap == 0 ? teal : gray,
                                  ),
                                )
                              ],
                            ),
                          ),
                          MaterialButton(
                            minWidth: 40,
                            onPressed: () {
                              bloc.add(ChangePageEvent(num: 1));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                bloc.currentTap == 1
                                    ? Image.asset("assets/pall1.png")
                                    : Image.asset("assets/pall0.png"),
                                Text(
                                  'أدويتي',
                                  style: TextStyle(
                                    color: bloc.currentTap == 1 ? teal : gray,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      //Right Tap Bar
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MaterialButton(
                            minWidth: 40,
                            onPressed: () {
                              bloc.add(ChangePageEvent(num: 2));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                bloc.currentTap == 2
                                    ? Image.asset("assets/message1.png")
                                    : Image.asset("assets/message0.png"),
                                Text(
                                  'اسأل ساعد',
                                  style: TextStyle(
                                    color: bloc.currentTap == 2 ? teal : gray,
                                  ),
                                )
                              ],
                            ),
                          ),
                          MaterialButton(
                            minWidth: 40,
                            onPressed: () {
                              bloc.add(ChangePageEvent(num: 3));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                bloc.currentTap == 3
                                    ? Image.asset("assets/scan1.png")
                                    : Image.asset("assets/scan0.png"),
                                Text(
                                  'مسح دواء',
                                  style: TextStyle(
                                    color: bloc.currentTap == 3 ? teal : gray,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
