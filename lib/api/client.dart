import 'dart:convert';
import 'package:http/http.dart' as http;

class APIClient {
  static const String BASE_URL = 'https://iot.wyvernp.id.vn/api/v1';

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('$BASE_URL/data'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body as String) as Map<String, dynamic>;
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
