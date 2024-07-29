import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vvault_redesign/core/constants/urls.dart';

class UpdateOrderActivityService {
  final String baseUrl = Urls.exchangeBaseUrl;
  FlutterSecureStorage fss = FlutterSecureStorage();

  Future<Map<String, dynamic>> updateOrderActivity(Map<String, dynamic> orderData, String id) async {
    final token = await fss.read(key: 'token');
    final response = await http.post(
      Uri.https(baseUrl, '/api/exchange/orders/activity'),
      headers: {
        'Cookie': '$token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'id': id,
        'active': orderData['active']
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody.containsKey('data') && responseBody['data'] != null) {
        return responseBody['data'];
      } else {
        throw Exception('Response does not contain data: ${response.body}');
      }
    } else {
      throw Exception('Failed to update an order\'s activity: ${response.body}');
    }
  }
}
