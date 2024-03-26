import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_8_team3/data/service/supabase_configration.dart';
import 'package:project_8_team3/pages/app%20pages/bloc/data_bloc.dart';
import 'package:project_8_team3/pages/splash%20page/bloc/redirect_bloc.dart';
import 'package:project_8_team3/pages/splash%20page/splash_screen_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await databaseConfig();
  await setup();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DataBloc(),
        ),
        BlocProvider(
          create: (context) => RedirectBloc()..add(RedirectToPageEvent()),
        ),
      ],
      child: MaterialApp(
        builder: (context, child) {
          return Directionality(
              textDirection: TextDirection.rtl, child: child!);
        },
        theme: ThemeData(
          fontFamily: GoogleFonts.vazirmatn().fontFamily,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreenPage(),
      ),
    );
  }
}
