import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:project_8_team3/data/service/supabase_services.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final locator = GetIt.I.get<DBService>();
  SplashBloc() : super(SplashInitial()) {
    on<SplashEvent>((event, emit) {});
    on<CheckSessionAvailabilityEvent>(checkSession);
  }

  FutureOr<void> checkSession(
      CheckSessionAvailabilityEvent event, Emitter<SplashState> emit) async {
    try {
      Future.delayed(
        const Duration(seconds: 4),
      );
      final sessionData = await locator.getCurrentSession();
      emit(SessionAvailabilityStat(isAvailable: sessionData));
    } catch (_) {
      emit(SessionAvailabilityStat(isAvailable: null));
    }
  }
}
