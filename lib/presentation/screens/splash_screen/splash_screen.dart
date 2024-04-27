import 'package:aura/presentation/functions/functions.dart';
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
    return const  Scaffold(
      body: Center(
        child: AppName(),
      ),
    );
  }

  splashScreendelay() async {
    await Future.delayed(const Duration(seconds: 2));
    checkLoggedIn(context);
  }
}
