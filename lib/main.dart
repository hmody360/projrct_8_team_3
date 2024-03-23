import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:project_8_team3/data/service/supabase_configration.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/pages/app%20pages/AddPage/add_medication_page.dart';
import 'package:project_8_team3/pages/app%20pages/MedPage/med_page.dart';
import 'package:project_8_team3/pages/app%20pages/NavBarPage/bootom_bar_bar.dart';
import 'package:project_8_team3/pages/app%20pages/bloc/data_bloc.dart';
import 'package:project_8_team3/pages/auth%20pages/sign%20up%20page/signup_page.dart';
import 'package:project_8_team3/pages/auth%20pages/signIn%20page/signin_page.dart';
import 'package:project_8_team3/pages/splach%20page/splach_page.dart';

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
    return BlocProvider(
      create: (context) => DataBloc(),
      child: MaterialApp(
        builder: (context, child) {
          return Directionality(
              textDirection: TextDirection.rtl, child: child!);
        },
        theme: ThemeData(
          fontFamily: GoogleFonts.vazirmatn().fontFamily,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
      ),
    );
  }
}
