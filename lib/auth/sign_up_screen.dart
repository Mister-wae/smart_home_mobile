// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_mobile/auth/auth_provider.dart';
import 'package:smart_home_mobile/auth/log_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String error1 = "";
  String error2 = "";
  String error3 = "";
  String error4 = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 233, 233),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Consumer<AuthProvider>(
            builder:
                (BuildContext context, AuthProvider value, Widget? child) =>
                    SizedBox(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Create Account",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      customField(_firstNameController, "First Name",
                          "Enter first name", false),
                      Text(
                        error1,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customField(_lastNameController, "Last Name",
                          "Enter last name", false),
                      Text(
                        error2,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customField(_emailController, "Email Address",
                          "Enter email", false),
                      Text(
                        error3,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customField(_passwordController, "Password",
                          "Enter password", true),
                      Text(
                        error4,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
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
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9)))),
                        onPressed: () async {
                          if (_emailController.text.isNotEmpty &&
                              _firstNameController.text.isNotEmpty &&
                              _lastNameController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty) {
                            String response = await Provider.of<AuthProvider>(
                                    context,
                                    listen: false)
                                .onSignUp(
                              email: _emailController.text,
                              password: _passwordController.text,
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text,
                            );
                            if (response == "Success") {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LogIn(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Sign up failed"),
                                ),
                              );
                            }
                          } else {
                            setState(() {
                              if (_firstNameController.text.isEmpty) {
                                error1 = "Input field cannot be null";
                              }
                              if (_lastNameController.text.isEmpty) {
                                error2 = "Input field cannot be null";
                              }
                              if (_emailController.text.isEmpty) {
                                error3 = "Input field cannot be null";
                              }
                              if (_passwordController.text.isEmpty) {
                                error4 = "Input field cannot be null";
                              }
                            });
                          }
                        },
                        child: value.signUpAction,
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
                              "Already have an account?",
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
                                    builder: (context) => const LogIn(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Login",
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
            ),
          ),
        ),
      ),
    );
  }
}

Widget customField(TextEditingController controller, String text,
    String hintText, bool password) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      TextField(
        controller: controller,
        textAlignVertical: TextAlignVertical.top,
        cursorColor: Colors.black,
        obscureText: password,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
      )
    ],
  );
}

const bgColor = Color.fromARGB(255, 239, 233, 233);
