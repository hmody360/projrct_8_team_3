import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_8_team3/data/service/supabase_configration.dart';
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: GoogleFonts.vazirmatn().fontFamily),
        home: const Directionality(
            textDirection: TextDirection.rtl, child: SplashPage()));
  }
}
