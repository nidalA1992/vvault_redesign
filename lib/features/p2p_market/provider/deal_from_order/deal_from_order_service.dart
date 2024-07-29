import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vvault_redesign/core/constants/urls.dart';

class DealFromOrderService {
  final String baseUrl = Urls.exchangeBaseUrl;
  FlutterSecureStorage fss = FlutterSecureStorage();

  Future<Map<String, dynamic>> startDeal(String orderId, Map<String, dynamic> dealData) async {
    final token = await fss.read(key: 'token');
    print("testttt ${json.encode(dealData)}");
    final response = await http.post(
      Uri.https(baseUrl, '/api/exchange/orders/$orderId/startDeal'),
      headers: {
        'Cookie': '$token',
        'Content-Type': 'application/json',
      },
      body: json.encode(dealData),
    );

    final responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      print(response.body);
      return {
        'data': responseBody['data'],
        'error': null,
        'message': responseBody['message'],
      };
    } else {
      return {
        'data': null,
        'error': responseBody['error'],
        'message': responseBody['message'],
      };
    }
  }
}