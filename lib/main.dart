import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:our_space/view_model/db_provider.dart';
import 'package:our_space/view_model/feedback_provider.dart';
import 'package:provider/provider.dart';
import 'view/home/screen/home_view.dart';
import 'view_model/astro_provider.dart';
import 'view_model/planet_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PlanetProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AstroProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DbProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FeedbackProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          duration: 2500,
          splash: "assets/images/icon.png",
          splashIconSize: 240,
          nextScreen: const HomeView(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.black,
          animationDuration: const Duration(seconds: 2),
        ),
      ),
    );
  }
}
