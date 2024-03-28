import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class UpdateOrderService {
  final String baseUrl = 'https://exchange.api.dev.wault.pro';
  FlutterSecureStorage fss = FlutterSecureStorage();


  Future<Map<String, dynamic>> updateOrder(Map<String, dynamic> orderData, String id) async {
    final token = await fss.read(key: 'token');
    final response = await http.post(
      Uri.parse('$baseUrl/api/exchange/orders/${id}'),
      headers: {
        'Cookie': '$token',
        'Content-Type': 'application/json',
      },
      body: json.encode(orderData),
    );

    if (response.statusCode == 200) {
      print(json.encode(orderData));
      final responseBody = json.decode(response.body);
      if (responseBody.containsKey('data') && responseBody['data'] != null) {
        return responseBody['data'];
      } else {
        throw Exception('Response does not contain data: ${response.body}');
      }
    } else {
      throw Exception('Failed to update an order: ${response.body}');
    }
  }

}