import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:project_8_team3/data/service/supabase_services.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final locator = GetIt.I.get<DBService>();
  ProfileBloc() : super(ProfileInitial()) {
    on<ActivateEditModeEvent>(activateEditMode);
    on<DeactivateEditModeEvent>(deactivateEditMode);
    on<GetUserInfoEvent>(getUserInfo);
    on<UpdateUserInfoEvent>(updateUserInfo);
  }

  FutureOr<void> activateEditMode(ActivateEditModeEvent event, Emitter<ProfileState> emit) {
    emit(ActivatedEditModeState());
  }

  FutureOr<void> deactivateEditMode(DeactivateEditModeEvent event, Emitter<ProfileState> emit) async{
    emit(DeactivatedEditModeState());
    await getUserInfo(GetUserInfoEvent(), emit);
  }


  FutureOr<void> getUserInfo(GetUserInfoEvent event, Emitter<ProfileState> emit) async{
    emit(ProfileLoadingState());
    try {
      locator.email = locator.supabase.auth.currentUser!.email!;
      locator.name = await locator.getUserName();
      emit(DisplayUserInfoState(email: locator.email, name: locator.name,));
    } catch (e) {
      emit(ProfileErrorState(msg: "حدث خطأ عند تحميل بياناتك يرجى المحاولة لاحقاً"));
    }
  }

  FutureOr<void> updateUserInfo(UpdateUserInfoEvent event, Emitter<ProfileState> emit) async{
    emit(ProfileLoadingState());
    if (event.name.trim().isNotEmpty){
      try {
      await locator.updateUserName(newName: event.name);
      await getUserInfo(GetUserInfoEvent(), emit);
    } catch (e) {
      emit(ProfileErrorState(msg: "هناك خطأ في عملية تحديث بياناتك"));
    }
    }else {
      emit(ProfileErrorState(msg: "يرجى عدم ترك حقل الاسم فارغاً"));
    }
    
  }
}
