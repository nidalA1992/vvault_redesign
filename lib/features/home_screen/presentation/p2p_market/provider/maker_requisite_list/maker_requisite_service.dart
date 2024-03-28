import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MakerRequisiteService {
  final String baseUrl = 'https://exchange.api.dev.wault.pro';
  FlutterSecureStorage fss = FlutterSecureStorage();
  Future<Map<String, dynamic>> fetchRequisiteInfo(String requisiteId) async {

    final token = await fss.read(key: 'token');

    final response = await http.get(
      Uri.parse('$baseUrl/api/exchange/requisites/$requisiteId'),
      headers: {'Authorization': token!},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to fetch requisite info: ${response.body}');
    }
  }
}