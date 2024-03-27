import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_8_team3/data/service/supabase_services.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<CreateAccountEvent>(createAccount);
  }

  FutureOr<void> createAccount(
      CreateAccountEvent event, Emitter<SignUpState> emit) async {
        emit (LoadingSignUpState());
        
    if (event.name.trim().isNotEmpty &&
        event.email.trim().isNotEmpty &&
        event.password.trim().isNotEmpty) {
      try {
        emit(LoadingSignUpState());
        await DBService().signUp(
            email: event.email, password: event.password, userName: event.name);
        await DBService().addUserName(name: event.name, id: await DBService().getCurrentUser());
        emit(SuccessSignUpState(msg: "تم إنشاء الحساب بنجاح"));
        await DBService().signOut();
      } catch (error) {
        emit(ErrorSignUpState(msg: "هناك خطأ في إنشاء الحساب"));
      }
    }else {
      emit(ErrorSignUpState(msg: "الرجاء إدخال جميع القيم"));
    }
  }
}
