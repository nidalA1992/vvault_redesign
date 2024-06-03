import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vvault_redesign/features/shared/constants/urls.dart';

class BanksListService {
  final String baseUrl = Urls.exchangeBaseUrl;

  FlutterSecureStorage fss = FlutterSecureStorage();

  Future<List<dynamic>> fetchBanks( ) async {

    final token = await fss.read(key: 'token');

    final uri = Uri.https(baseUrl, '/api/exchange/banks');
    final response = await http.get(uri, headers: {
      'Cookie': '$token',
      'Content-Type': 'application/json',

    }
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      return data;
    } else {
      throw Exception('Failed to load orders: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> fetchUserMe() async {
    final token = await fss.read(key: 'token');

    final uri = Uri.https(Urls.usersBaseUrl, '/api/users/me');
    final response = await http.get(uri, headers: {
      'Cookie': '$token',
      'Content-Type': 'application/json',
    }
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return data;
    } else {
      throw Exception('Failed to load orders 1: ${response.statusCode}');
    }
  }

}