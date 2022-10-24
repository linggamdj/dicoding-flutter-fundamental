import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:restaurant_app/commons/style.dart';
import 'package:restaurant_app/pages/main_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: whiteColor,
      splash: Image.asset(
        'assets/images/logo.png',
      ),
      splashIconSize: 500.0,
      nextScreen: const MainPage(),
      splashTransition: SplashTransition.fadeTransition,
      duration: 2000,
    );
  }
}
