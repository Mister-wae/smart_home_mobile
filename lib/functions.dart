import 'package:http/http.dart' as http;
import 'package:smart_home_mobile/models.dart';

class Functions {
  List<Map<String, dynamic>> userDevices = [];
  static Future<void> getUserDevices() async {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NjMxMGM5NjgyYTk3NmFlNjM5Mjg1NDUiLCJlbWFpbCI6Implc3VzQGdtYWlsLmNvbSIsImlhdCI6MTcxNDQ5MDUzNCwiZXhwIjoxNzE1MDk1MzM0fQ.RHZR9DRLoZC6MLPEnLzWgU96QFUnIPXkH_27Ffr1e94'
    };
    // var request = await http.Request('GET',
    //     Uri.parse('https://x-fmpv.onrender.com/api/v1/devices/user/all'));

    var response = await http.get(
        Uri.parse("https://x-fmpv.onrender.com/api/v1/devices/user/all"),
        headers: headers);

    var responseData = response.body;
    if (response.statusCode == 200) {
      print(responseData);
      var deviceList = welcomeFromJson(responseData);
      print(deviceList);
    } else {
      print(response.reasonPhrase);
    }
  }
}
