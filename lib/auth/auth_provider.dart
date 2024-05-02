// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home_mobile/models.dart';

class AuthProvider extends ChangeNotifier {
  String weather = "";
  String wind = "";
  String humidity = "";
  String pressure = "";
  String temp = "";

  Widget signUpAction = const Text(
    "Sign Up",
    style: TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
  );
  Widget loginAction = const Text(
    "LogIn",
    style: TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
  );
  Future<String> onSignUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    signingUp();
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.post(
          Uri.parse('https://x-fmpv.onrender.com/api/v1/auth/register'),
          headers: headers,
          body: jsonEncode({
            "email": email,
            "password": password,
            "firstName": firstName,
            "lastName": lastName,
          }));

      http.Response response = await request;

      if (response.statusCode == 201) {
        print(response.body);
        signUpAction = const Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        );
        notifyListeners();
        return "Success";
      } else {
        print(response.body);
        signUpAction = const Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        );
        notifyListeners();
        return "Failed";
      }
    } catch (e) {
      print(e.toString());
      signUpAction = const Text(
        "Sign Up",
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      );
      return "Failed";
      // throw '';
    }
  }

  Future<bool> logIn(String email, String password) async {
    try {
      loggingIn();
      var headers = {'Content-Type': 'application/json'};

      http.Response response = await http.post(
          Uri.parse('https://x-fmpv.onrender.com/api/v1/auth/login'),
          headers: headers,
          body: json.encode({
            "email": email,
            "password": password,
          }));
      if (response.statusCode == 200) {
        loginAction = const Text(
          "Login",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        );
        notifyListeners();

        print(response.body);
        var responseData = jsonDecode(response.body);
        // User user = User.fromJson(responseData["data"]);
        User user = User(
          email: responseData["data"]["user"]["email"],
          firstName: responseData["data"]["user"]["firstName"],
          lastName: responseData["data"]["user"]["lastName"],
          token: responseData["data"]["token"],
        );
        // SecureStorage.writeUser(user.toJson().toString());
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            "keyUser",
            jsonEncode({
              "email": user.email,
              "firstName": user.firstName,
              "lastName": user.lastName,
              "token": user.token,
            }));
        return true;
      } else {
        loginAction = const Text(
          "Login",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        );
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e.toString());
      loginAction = const Text(
        "Login",
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      );
      notifyListeners();
      return false;
    }
  }

  void signingUp() {
    signUpAction = const CircularProgressIndicator(
      color: Colors.white,
    );
    notifyListeners();
  }

  void loggingIn() {
    loginAction = const CircularProgressIndicator(
      color: Colors.white,
    );
    notifyListeners();
  }

  Future<bool> signIn() async {
    final prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString("keyUser");

    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  void getWeatherData() async {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NjMxMGM5NjgyYTk3NmFlNjM5Mjg1NDUiLCJlbWFpbCI6Implc3VzQGdtYWlsLmNvbSIsImlhdCI6MTcxNDQ5MDUzNCwiZXhwIjoxNzE1MDk1MzM0fQ.RHZR9DRLoZC6MLPEnLzWgU96QFUnIPXkH_27Ffr1e94'
    };
    http.Response response = await http.get(
      Uri.parse('https://x-fmpv.onrender.com/api/v1/app/weather/lagos'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      var weatherData = jsonDecode(response.body);
      weather = weatherData["data"]["weather"][0]["main"];
      humidity = (weatherData["data"]["main"]["humidity"]).toString();
      pressure = (weatherData["data"]["main"]["pressure"]).toString();
      wind = (weatherData["data"]["wind"]["speed"]).toString();
      temp = (weatherData["data"]["main"]["temp_max"] - 273.15)
          .toString()
          .replaceRange(5, null, "");
    } else {}
  }
}
