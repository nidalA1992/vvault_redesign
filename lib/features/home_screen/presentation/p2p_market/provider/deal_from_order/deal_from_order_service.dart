import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DealFromOrderService {
  final String baseUrl = 'https://exchange.api.dev.wault.pro';
  FlutterSecureStorage fss = FlutterSecureStorage();

  Future<Map<String, dynamic>> startDeal(String orderId, Map<String, dynamic> dealData) async {
    final token = await fss.read(key: 'token');
    print("testttt ${json.encode(dealData)}");
    final response = await http.post(
      Uri.parse('$baseUrl/api/exchange/orders/$orderId/startDeal'),
      headers: {
        'Cookie': '$token',
        'Content-Type': 'application/json',
      },
      body: json.encode(dealData),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to start deal: ${json.decode(response.body)['error']}');
    }
  }
}
