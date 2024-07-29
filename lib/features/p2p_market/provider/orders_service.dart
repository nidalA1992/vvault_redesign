import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vvault_redesign/core/constants/urls.dart';

class OrdersService {
  final String baseUrl = Urls.exchangeBaseUrl;

  FlutterSecureStorage fss = FlutterSecureStorage();

  Future<List<dynamic>> fetchOrders(Map<String, dynamic> queryParams) async {

    final token = await fss.read(key: 'token');

    final uri = Uri.https(baseUrl, '/api/exchange/orders', queryParams);
    final response = await http.get(uri, headers: {
      'Cookie': '$token',
      'Content-Type': 'application/json',

    }
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      print(data);
      return data;
    } else {
      throw Exception('Failed to load orders: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> fetchUserStats(String? id) async {
    final token = await fss.read(key: 'token');
    final uri = Uri.https(Urls.usersBaseUrl, '/api/users/stat/$id');
    final response = await http.get(uri, headers: {
      'Cookie': '$token',
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return data;
    } else {
      throw Exception('Failed to load user stats: ${json.decode(response.body)['error']}');
    }
  }

}