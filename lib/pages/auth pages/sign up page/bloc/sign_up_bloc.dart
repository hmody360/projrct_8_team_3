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
    try {
      emit(LoadingSignUpState());
      await DBService().SignUp(
          email: event.email, password: event.password, userName: event.name);
      emit(SuccessSignUpState());
    } catch (error) {
      emit(ErrorSignUpState());
    }
  }
}
