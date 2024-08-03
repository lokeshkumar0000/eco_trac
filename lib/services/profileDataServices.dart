import 'dart:convert';
import 'package:electricity/models/profileDataModel.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  static const String apiUrl = 'https://your_api_endpoint_here';

  Future<ProfileData> fetchProfileData({bool useApi = true}) async {
    if (useApi) {
      try {
        final response = await http.get(Uri.parse(apiUrl));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          return ProfileData.fromJson(data);
        } else {
          throw Exception('Failed to fetch data');
        }
      } catch (e) {
        throw Exception('Failed to fetch data: $e');
      }
    } else {
      return _getDefaultProfileData(); // Use local dummy data
    }
  }

  ProfileData _getDefaultProfileData() {
    return ProfileData(
      username: 'Sanjeev',
      phoneNumber: '1234567890',
      address: "Saravanampatti, Coimbatore, TN",
      electricityConsumerNumber: '8745230198',
      waterConsumerNumber: '7612948350',
      numberOfPeopleInHouse: 3,
      electricityBoard: 'TNEB',
      waterBoard: 'TWAD',
      appliances: {
        'Refrigerator': 1,
        'Microwave': 2,
        'Television': 3,
        "laptop": 3
        // Add more appliances and their counts as needed
      },
    );
  }
}
