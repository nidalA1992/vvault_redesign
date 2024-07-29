import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:vvault_redesign/core/constants/urls.dart';

class SignInService {
  final String baseUrl = Urls.usersBaseUrl;

  FlutterSecureStorage fss = FlutterSecureStorage();

  Future<Map<String, dynamic>> signIn(Map<String, String> userData) async {
    final response = await http.post(
      Uri.https(baseUrl, '/api/users/sign/in'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(userData),
    );

    if (response.statusCode == 200) {
      final token = response.headers['set-cookie'];
      fss.write(key: 'token', value: token);json.decode(response.body)['data'];
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to sign in: ${json.decode(response.body)['error']['message']}');
    }
  }
}