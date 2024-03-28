import 'dart:convert';
import 'dart:ffi';
import 'package:SmartMicro.Mobile/data/account.dart';
import 'package:SmartMicro.Mobile/data/device.dart';
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

  //* Create Account
  Future<Account> createAccount(Map<String, dynamic> account) async {
    final response = await http.post(
      Uri.parse('$BASE_URL/account'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(account),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body as String) as Map<String, dynamic>;
      print(data);
      return data['data'] as Account;
    } else {
      throw Exception('Failed to create account');
    }
  }

  //* Login with email and password
  Future<Map<String, dynamic>?> login(Account account) async {
    final response = await http.post(
      Uri.parse('$BASE_URL/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': account.email ?? '',
        'password': account.password ?? '',
      }),
    );
    if (response.statusCode == 200) {
      print(response.body);
      final data = json.decode(response.body as String) as Map<String, dynamic>;
      return data['data'] as Map<String, dynamic>;
    } else {
      return null;
    }
  }

  //* SignUp with email and password
  Future<bool> signUp(Account account) async {
    final response = await http.post(
      Uri.parse('$BASE_URL/account'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        //         "username": "nmhung1@gmail.com",
        // "password": "123123",
        // "email": "nmhung1@gmail.com",
        // "firstName": "string",
        // "lastName": "string",
        // "birthDate": "2024-03-28",
        // "parentAccountId": 0,
        // "role": "string"

        'username': account.email ?? '',
        'email': account.email ?? '',
        'password': account.password ?? '',
        'firstName': 'first',
        'lastName': 'last',
        'birthDate': '2024-01-01',
        'parentAccountId': '0',
        'role': 'user',
      }),
    );
    if (response.statusCode == 200) {
      print(response.body);
      return true;
    } else {
      return false;
    }
  }

  //* Get all devices
  Future<List<Device>> getDevices() async {
    final response = await http.get(
      Uri.parse('$BASE_URL/device'),
      // headers: <String, String>{
      //   'Authorization': 'Bearer'
      //   '$token',
      // },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body as String) as Map<String, dynamic>;
      List<Device> list = (data['data'] as List<dynamic>).map((val) => Device.fromJson(val as Map<String, dynamic>)).toList();
      return list;
    } else {
      throw Exception('Failed to load devices');
    }
  }

  //* Get device by ownerId
  Future<List<Device>> getDevicesByOwnerId(int userId) async {
    final response = await http.get(
      Uri.parse('$BASE_URL/device/owner/$userId'),
      // headers: <String, String>{
      //   'Authorization': 'Bearer'
      //   '$token',
      // },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body as String) as Map<String, dynamic>;
      List<Device> list = (data['data'] as List<dynamic>).map((val) => Device.fromJson(val as Map<String, dynamic>)).toList();
      return list;
    } else {
      throw Exception('Failed to load devices');
    }
  }

  //* create device
  Future<bool> createDevice(Device device) async {
    final response = await http.post(
      Uri.parse('$BASE_URL/device'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(device.toJson()),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //* delete device
  Future<bool> deleteDevice(int deviceId) async {
    final response = await http.delete(
      Uri.parse('$BASE_URL/device/$deviceId'),
      // headers: <String, String>{
      //   'Authorization': 'Bearer'
      //   '$token',
      // },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
