import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/helper/sized.dart';
import 'package:project_8_team3/pages/app%20pages/NavBarPage/bootom_bar_bar.dart';
import 'package:project_8_team3/pages/auth%20pages/first_page.dart';
import 'package:project_8_team3/pages/splach%20page/bloc/splash_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    // Future.delayed(const Duration(seconds: 2), () {
    //   Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(builder: (context) => const FirstPage()));
    // }
    // );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<SplashBloc>();
        bloc.add(CheckSessionAvailabilityEvent());
        return BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is SessionAvailabilityStat) {
              if (state.isAvailable != null) {
                context.pushAndRemove(const BottomBarScreen());
              } else {
                context.pushAndRemove(const FirstPage());
              }
            }
          },
          child: Scaffold(
            body: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [greenText, moreDarkGreenColor, green],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                sizedBoxHeight250,
                Image.asset(
                  'assets/images/saedLogo.png',
                  width: 180,
                )
              ]),
            ),
          ),
        );
      }),
    );
  }
}
