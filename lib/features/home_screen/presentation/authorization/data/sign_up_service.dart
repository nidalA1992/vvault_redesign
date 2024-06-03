import 'dart:convert';
import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class SignUpService {
  final String baseUrl = 'https://users.api.tdev.wault.pro';

  FlutterSecureStorage fss = FlutterSecureStorage();

  Future<Map<String, dynamic>> signUp(Map<String, String> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/users/sign/up'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(userData),
    );

    if (response.statusCode == 200) {
      final token = response.headers['set-cookie'];
      fss.write(key: 'token', value: token);
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to sign up: ${json.decode(response.body)['error']['message']}');
    }
  }
}