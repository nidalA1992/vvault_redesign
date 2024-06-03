import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vvault_redesign/features/shared/constants/urls.dart';

class AllMoneyService {
  final String baseUrl = Urls.walletsBaseUrl;

  FlutterSecureStorage fss = FlutterSecureStorage();

  Future<Map<String, dynamic>> fetchAllMoney({String? currency}) async {
    final token = await fss.read(key: 'token');

    final uri = Uri.https(baseUrl, '/api/wallets/allmoney', currency != null ? {'currency': currency} : null);
    final response = await http.get(uri, headers: {
      'Cookie': '$token',
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load allmoney: ${response.statusCode}');
    }
  }

}
