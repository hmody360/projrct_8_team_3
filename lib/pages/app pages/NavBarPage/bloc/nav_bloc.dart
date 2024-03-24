import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
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
    HomePage(),
    const ScanPage(),
  ];
  Widget currentScreen = HomePage();
  final PageStorageBucket bucket = PageStorageBucket();

  NavBloc() : super(NavInitial()) {
    on<NavEvent>((event, emit) {});
    on<ChangePageEvent>((event, emit) {
      currentTap = event.num;
      currentScreen = screen[event.num];
      emit(ChangePageState());
    });
  }
}
