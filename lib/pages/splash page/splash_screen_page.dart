import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/helper/sized.dart';
import 'package:project_8_team3/pages/splash%20page/bloc/redirect_bloc.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RedirectBloc, RedirectState>(
      listener: (context, state) {
        if (state is RedirectedState){
          context.pushAndRemove(state.pageView);
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
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            gapH250,
            Image.asset(
              'assets/images/splashscreenlogo.png',
              height: 210,
            )
          ]),
        ),
      ),
    );
  }
}
