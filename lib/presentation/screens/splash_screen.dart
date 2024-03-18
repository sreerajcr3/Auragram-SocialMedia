import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/home.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    splashScreendelay();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
       // decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.white70,Colors.red],begin: Alignment.bottomLeft)),
        child: Center(
          child: AppName(),
        ),
      ),
    );
  }

  splashScreendelay() async {
    await Future.delayed(Duration(seconds: 2));
    checkLoggedIn(context);
  }
}
