import 'dart:convert'; // If dealing with JSON
import 'package:electricity/models/usageData.dart';
import 'package:electricity/models/usageDataModel.dart';
import 'package:http/http.dart' as http;

class UsageDataService {
  static const String apiUrl = 'https://localhost:5000/data';

  Future<List<UsageData>> fetchUsageData({bool useApi = true}) async {
    if (useApi) {
      try {
        final response = await http.get(Uri.parse(apiUrl));

        if (response.statusCode == 200) {
          List<dynamic> data = json.decode(response.body);
          List<UsageData> usageDataList =
              data.map((item) => UsageData.fromJson(item)).toList();
          return usageDataList;
        } else {
          throw Exception('Failed to fetch data');
        }
      } catch (e) {
        throw Exception('Failed to fetch data: $e');
      }
    } else {
      // Use local JSON data (dummyUsageData)
      List<UsageData> usageDataList =
          dummyUsageData.reversed.map((item) => UsageData.fromJson(item)).toList();
      return usageDataList;
    }
  }
}
