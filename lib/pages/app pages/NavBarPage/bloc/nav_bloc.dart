import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:project_8_team3/pages/app%20pages/AddPage/add_page.dart';
import 'package:project_8_team3/pages/app%20pages/HomePage/home_page.dart';
import 'package:project_8_team3/pages/app%20pages/MedPage/med_page.dart';
import 'package:project_8_team3/pages/app%20pages/ScanPage/scan.dart';
import 'package:project_8_team3/pages/app%20pages/ai%20chat%20page/chat_screen.dart';


part 'nav_event.dart';
part 'nav_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  int currentTap = 0;

  @override
  final List<Widget> Screen = [
    const HomePage(),
    const MedPage(),
    const AddPage(),
    const ScanPage(),
    const ChatPage(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePage();

  NavBloc() : super(NavInitial()) {
    on<NavEvent>((event, emit) {});
    on<ChangePageEvent>((event, emit) {
      currentTap = event.num;
      currentScreen = Screen[currentTap];
    });
  }
}
