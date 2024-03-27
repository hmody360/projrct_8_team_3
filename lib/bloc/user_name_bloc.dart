import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:project_8_team3/data/service/supabase_services.dart';

part 'user_name_event.dart';
part 'user_name_state.dart';

class UserNameBloc extends Bloc<UserNameEvent, UserNameState> {
  final locator = GetIt.I.get<DBService>();

  UserNameBloc() : super(UserNameInitial()) {
    on<UserNameEvent>((event, emit) { });

    on<GetUserNameEvent>(GetUserNameMethod);
  }

  FutureOr<void> GetUserNameMethod(GetUserNameEvent event, Emitter<UserNameState> emit) async{
    locator.name = await locator.getUserName();
    emit(GetUserNameState());
  }
}
