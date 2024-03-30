import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewRequisiteService {
  final String baseUrl = 'https://exchange.api.dev.wault.pro';
  FlutterSecureStorage fss = FlutterSecureStorage();

  Future<Map<String, dynamic>> createRequisite(Map<String, dynamic> requisiteData) async {
    final token = await fss.read(key: 'token');
    final response = await http.post(
      Uri.parse('$baseUrl/api/exchange/requisites'),
      headers: {
        'Cookie': '$token',
        'Content-Type': 'application/json',
      },
      body: json.encode(requisiteData),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to create requisite: ${response.body}');
    }
  }
}