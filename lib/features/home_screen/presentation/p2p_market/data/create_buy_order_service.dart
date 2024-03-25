import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class BuyOrderService {
  final String baseUrl = 'https://exchange.api.dev.wault.pro';
  FlutterSecureStorage fss = FlutterSecureStorage();


  Future<Map<String, dynamic>> createBuyOrder(Map<String, dynamic> orderData) async {
    final token = await fss.read(key: 'token');
    print(token);
    final response = await http.post(
      Uri.parse('$baseUrl/api/exchange/orders/create/buy'),
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
      throw Exception('Failed to create buy order: ${response.body}');
    }
  }
}