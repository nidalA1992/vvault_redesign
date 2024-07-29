import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vvault_redesign/core/constants/urls.dart';

class DealsService {
  final String baseUrl = Urls.exchangeBaseUrl;

  FlutterSecureStorage fss = FlutterSecureStorage();

  Future<List<dynamic>> fetchDeals(Map<String, String> queryParams) async {
    final token = await fss.read(key: 'token');
    final uri = Uri.https(baseUrl, '/api/exchange/deals', queryParams);

    final response = await http.get(
      uri,
      headers: {
        'Cookie': '$token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final data = List.from(responseBody['data'] ?? []);
      return data;
    } else {
      final errorResponse = json.decode(response.body);
      throw Exception('Failed to load deals: ${errorResponse['error']?['message']}');
    }
  }

}
