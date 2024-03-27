import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:project_8_team3/data/service/supabase_services.dart';
import 'package:project_8_team3/pages/app%20pages/NavBarPage/bootom_bar_bar.dart';
import 'package:project_8_team3/pages/auth%20pages/first_page/first_page.dart';

part 'redirect_event.dart';
part 'redirect_state.dart';

class RedirectBloc extends Bloc<RedirectEvent, RedirectState> {
  final dbLoactor = GetIt.I.get<DBService>();
  RedirectBloc() : super(RedirectInitial()) {
    
    on<RedirectToPageEvent>(redirectToPage);
  }

  FutureOr<void> redirectToPage(RedirectToPageEvent event, Emitter<RedirectState> emit) async{
      final session = await dbLoactor.getCurrentSession();
      Future.delayed(const Duration(seconds: 4));
      if (session != null){
        dbLoactor.name = await dbLoactor.getUserName();
        emit(RedirectedState(pageView: const BottomBarScreen()));
      }else {
        emit(RedirectedState(pageView: const FirstPage()));
      }
  }
}
