import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_8_team3/data/service/supabase_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInEvent>((event, emit) {});
    on<AddSignInEvent>(signIn);
    on<ResetPasswordEvent>(resetPassword);
  }

  FutureOr<void> signIn(AddSignInEvent event, Emitter<SignInState> emit) async {
    try {
      emit(LoadingSignInState());
      await DBService().SignIn(email: event.email, password: event.password);
      emit(SuccessSignInState());
      } on AuthException catch (error) {
        emit(ErrorSignInState(massage: error.message));
      }

  }

  FutureOr<void> resetPassword(ResetPasswordEvent event, Emitter<SignInState> emit) async{
        try {
      emit(LoadingSignInState());
      await DBService().resetPassword(email: event.email);
      emit(SignInInitial());
      } on AuthException catch (error) {
        emit(ErrorSignInState(massage: error.message));
      }
  }
}