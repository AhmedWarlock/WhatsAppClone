import 'dart:async';

import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Presentation/pages/phone_verification.dart';
import 'package:whatsapp_clone/Presentation/screens/home_screen.dart';
import 'package:whatsapp_clone/Presentation/screens/registeration.dart';
import 'package:whatsapp_clone/Presentation/screens/welcome.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 1), () {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => WelcomeScreen()), (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'WhatsApp Clone',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
