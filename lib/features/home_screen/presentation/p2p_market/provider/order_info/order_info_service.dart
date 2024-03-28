import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderInfoService {
  final String baseUrl = 'https://exchange.api.dev.wault.pro';
  FlutterSecureStorage fss = FlutterSecureStorage();

  Future<Map<String, dynamic>> fetchOrderDetails(String orderId) async {
    final token = await fss.read(key: 'token');
    final response = await http.get(
      Uri.parse('$baseUrl/api/exchange/orders/$orderId'),
      headers: {'Cookie': token!},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to fetch order details: ${response.body}');
    }
  }
}