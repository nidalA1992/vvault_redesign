import 'dart:convert';
import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class SignInService {
  final String baseUrl = 'https://users.api.dev.wault.pro';

  FlutterSecureStorage fss = FlutterSecureStorage();

  Future<Map<String, dynamic>> signIn(Map<String, String> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/users/sign/in'),
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
      throw Exception('Failed to sign in: ${json.decode(response.body)['error']['message']}');
    }
  }
}