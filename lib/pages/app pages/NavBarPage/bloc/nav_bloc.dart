
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_8_team3/pages/aichat/first_chat_page.dart';
import 'package:project_8_team3/pages/app%20pages/HomePage/home_page.dart';
import 'package:project_8_team3/pages/app%20pages/MedPage/med_page.dart';
import 'package:project_8_team3/pages/app%20pages/ScanPage/scan%20copy.dart';

part 'nav_event.dart';
part 'nav_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  int currentTap = 0;

  final List<Widget> screen = [
    HomePage(),
    const MedPage(),
    Container(),
    const ChatPage(),
    const ScanPage(),
  ];

  Widget currentScreen = HomePage();
  // final PageStorageBucket bucket = PageStorageBucket();

  NavBloc() : super(NavInitial()) {
    on<NavEvent>((event, emit) {});
    on<ChangePageEvent>((event, emit) {
      currentTap = event.num;
      currentScreen = screen[event.num];
      emit(ChangePageState());
    });
  }
}
