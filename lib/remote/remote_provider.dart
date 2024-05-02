import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home_mobile/models.dart';
import 'package:http/http.dart' as http;

class RemoteProvider extends ChangeNotifier {
  List userDevices = [];
  List availableDevices = [];
  String? userName;

  void getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString("keyUser");
    final userDataMap = jsonDecode(userData!);
    final user = User.fromJson(userDataMap);
    userName = user.firstName;
  }

  Future<bool> getAvailableDevices() async {
    final prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString("keyUser");
    final userDataMap = jsonDecode(userData!);
    final user = User.fromJson(userDataMap);
    var headers = {
      'Authorization': 'Bearer ${user.token}',
    };

    http.Response response = await http.get(
      Uri.parse('https://x-fmpv.onrender.com/api/v1/devices/list'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      availableDevices = responseData["data"]["devices"];
      return true;
    } else {
      // print(response.body);
      return false;
    }

    // try {} catch (e) {}
  }

  Future<bool> addDevices(String name, String path) async {
    final prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString("keyUser");
    final userDataMap = jsonDecode(userData!);
    final user = User.fromJson(userDataMap);
    var headers = {
      'Authorization': 'Bearer ${user.token}',
      'Content-Type': 'application/json'
    };
    http.Response response = await http.post(
        Uri.parse('https://x-fmpv.onrender.com/api/v1/devices/user/add'),
        headers: headers,
        body: jsonEncode({
          "name": name,
          "type": "default",
          "location": "General",
          "path": path,
          "manufacturer": "undefined"
        }));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  void getUserDevices() async {
    final prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString("keyUser");
    final userDataMap = jsonDecode(userData!);
    final user = User.fromJson(userDataMap);
    var headers = {'Authorization': 'Bearer ${user.token}'};
    http.Response response = await http.get(
        Uri.parse('https://x-fmpv.onrender.com/api/v1/devices/user/all'),
        headers: headers);
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      userDevices = responseData["data"];
      notifyListeners();
    } else {}
  }

  Future<bool> commandDevice(String user, String command) async {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NjMxMGM5NjgyYTk3NmFlNjM5Mjg1NDUiLCJlbWFpbCI6Implc3VzQGdtYWlsLmNvbSIsImlhdCI6MTcxNDQ5MDUzNCwiZXhwIjoxNzE1MDk1MzM0fQ.RHZR9DRLoZC6MLPEnLzWgU96QFUnIPXkH_27Ffr1e94',
      'Content-Type': 'application/json'
    };
    http.Response response = await http.post(
        Uri.parse(
          'https://x-fmpv.onrender.com/api/v1/devices/command/$user',
        ),
        headers: headers,
        body: jsonEncode({
          "command": command,
        }));
    if (response.statusCode == 200) {
      // print(response.body);
      return true;
    } else {
      // print(response.body);
      return false;
    }
  }
}
