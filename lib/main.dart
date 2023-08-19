import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:instantweather/weatherreport.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: AnimatedSplashScreen(
        splash: Image.asset('assets/weather.png'),
          nextScreen: weather(),
          duration: 4,
          backgroundColor: Colors.lightBlue,
          splashIconSize: 350,
        ));
  }
}


