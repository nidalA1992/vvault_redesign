import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vvault_redesign/features/shared/constants/urls.dart';

class OrderInfoService {
  FlutterSecureStorage fss = FlutterSecureStorage();

  Future<Map<String, dynamic>> fetchOrderDetails(String orderId) async {
    final token = await fss.read(key: 'token');
    final response = await http.get(
      Uri.https(Urls.exchangeBaseUrl, '/api/exchange/orders/$orderId'),
      headers: {'Cookie': "$token"},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to fetch order details: ${response.body}');
    }
  }
}