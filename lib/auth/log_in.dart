// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_mobile/auth/auth_provider.dart';
import 'package:smart_home_mobile/auth/sign_up_screen.dart';
import 'package:smart_home_mobile/home/home.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String error1 = "";
  String error2 = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Consumer<AuthProvider>(
          builder: (BuildContext context, AuthProvider value, Widget? child) =>
              Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              customField(
                  _emailController, "Email Address", "Enter email", false),
              Text(
                error1,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
              const SizedBox(
                height: 10,
              ),
              customField(
                  _passwordController, "Password", "Enter password", true),
              Text(
                error2,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.black),
                    fixedSize: MaterialStatePropertyAll(
                        Size(MediaQuery.sizeOf(context).width, 50)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9)))),
                onPressed: () async {
                  if (_emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty) {
                    bool response = await Provider.of<AuthProvider>(context,
                            listen: false)
                        .logIn(_emailController.text, _passwordController.text);

                    if (response == true) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                          (route) => false);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Sign up failed"),
                        ),
                      );
                    }
                  } else {
                    setState(() {
                      if (_emailController.text.isEmpty) {
                        error1 = "Input field cannot be null";
                      }
                      if (_passwordController.text.isEmpty) {
                        error2 = "Input field cannot be null";
                      }
                    });
                  }
                },
                child: value.loginAction,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUp(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
