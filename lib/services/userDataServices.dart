import 'dart:convert';
import 'package:electricity/models/userDataModel.dart';
import 'package:electricity/services/general%20services/helpers.dart';
import 'package:http/http.dart' as http;

class UserService {

  Future<UserData?> getUserData() async {
    try {
      final response = await http.get(Uri.parse('${DataConstants.baseUrl}/me'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        return UserData.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
