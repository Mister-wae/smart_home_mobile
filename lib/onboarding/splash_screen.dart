// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_mobile/auth/auth_provider.dart';
import 'package:smart_home_mobile/auth/sign_up_screen.dart';
import 'package:smart_home_mobile/home/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Timer(const Duration(seconds: 3), () async {
          bool user =
              await Provider.of<AuthProvider>(context, listen: false).signIn();
          if (user == true) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUp(),
              ),
            );
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(40, 40, 41, 1),
      body: Center(
        child: Text(
          "Smart Home",
          style: TextStyle(
            fontSize: 35,
            color: Colors.white,
            fontFamily: "Roboto",
          ),
        ),
      ),
    );
  }
}
