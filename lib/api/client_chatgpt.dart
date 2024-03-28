import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class APIClientChatGPT {
  static const String BASE_URL = 'https://api.openai.com/v1';

  Future<Map<String, dynamic>> fetchData(String request) async {
    final token = dotenv.env['GPT_API_KEY'];
    // request ="bạn muốn chơi cùng tôi và mở cửa lên nào";
    print(request);

    final response = await http.post(Uri.parse('$BASE_URL/chat/completions'), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: json.encode({
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "system",
          "content": "Tôi muốn bạn đóng vai trò là ngôi nhà thông minh, người dùng sẽ tương tác với ngôi nhà thông qua bạn. Công việc của bạn là trả lời với đúng 1 chữ theo danh sách các trường hợp sau: on# nếu người dùng yêu cầu bật đèn, off# nếu người dùng yêu cầu tắt đèn, close# nếu người dùng yêu cầu đóng cửa, open# nếu người dùng yêu cầu mở cửa, nếu không thì trả lời tùy yêu cầu người dùng mà bạn nhận được với thái độ vui vẻ"
        },
        {
          "role": "user",
          "content": "$request"
        }
      ]
    })
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      print(data);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}

