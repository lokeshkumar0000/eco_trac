import 'dart:convert';
import 'package:electricity/services/general%20services/helpers.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<Map<String, dynamic>?> loginUser(
      String phoneNo, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${DataConstants.baseUrl}/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phone_no': phoneNo,
          'password': password,
        }),
      );
      Map<String, dynamic> data = json.decode(response.body);

      print(response);
if (response.statusCode == 200) {
  bool success = json.decode(response.body)["success"];
  await SharedPref().setBoolFromSharedPreferences(success);
  print(response.body);

  // Retrieve the value from SharedPreferences and use it within an async function
  bool? isLogged = await SharedPref().getBoolFromSharedPreferences();
  print("Is logged: $isLogged");

  return data;
} else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> registerUser(String phoneNo, String password,
      String firstName, String lastName) async {
    try {
      final response = await http.post(
        Uri.parse('${DataConstants.baseUrl}/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "phone_no": phoneNo,
          "password": password,
          "firstname": firstName,
          "lastname": lastName,
        }),
      );
      Map<String, dynamic> data = json.decode(response.body);

      print(response);
      if (response.statusCode == 200) {
        return data;
      } else {
        print(response.statusCode);
        return null;
      }
    } catch (e) {
      print("error $e");
    }
  }
}
