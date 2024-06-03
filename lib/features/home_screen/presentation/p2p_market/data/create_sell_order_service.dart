import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vvault_redesign/features/shared/constants/urls.dart';


class SellOrderService {
  final String baseUrl = Urls.exchangeBaseUrl;
  FlutterSecureStorage fss = FlutterSecureStorage();


  Future<Map<String, dynamic>> createSellOrder(Map<String, dynamic> orderData) async {
    final token = await fss.read(key: 'token');
    print(token);
    final response = await http.post(
      Uri.https(baseUrl, '/api/exchange/orders/create/sell'),
      headers: {
        'Cookie': '$token',
        'Content-Type': 'application/json',
      },
      body: json.encode(orderData),
    );

    if (response.statusCode == 200) {
      print(json.encode(orderData),);
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to create sell'
          'order: ${response.body}');
    }
  }
}