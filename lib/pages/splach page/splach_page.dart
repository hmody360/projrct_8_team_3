import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:project_8_team3/data/service/supabase_services.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/sized.dart';
import 'package:project_8_team3/pages/app%20pages/NavBarPage/bootom_bar_bar.dart';
import 'package:project_8_team3/pages/auth%20pages/first_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var sessionData;
  final locator = GetIt.I.get<DBService>();

  void getSession() async {
    try {
      sessionData = await locator.getCurrentSession();
    } catch (_) {
      sessionData = null;
    }
  }



  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 4), () {
    getSession();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              sessionData != null ? const FirstPage() : const BottomBarScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [greenText, moreDarkGreenColor, green],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          sizedBoxHeight250,
          Image.asset(
            'assets/images/newIcon.png',
            height: 210,
          )
        ]),
      ),
    );
  }
}
