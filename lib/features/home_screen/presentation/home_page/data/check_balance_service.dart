import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CheckBalanceService {
  final String baseUrl = 'wallet.api.dev.wault.pro';
  FlutterSecureStorage fss = FlutterSecureStorage();

  Future<Map<String, dynamic>> checkBalance(String currency) async {
    final token = await fss.read(key: 'token');
    final uri = Uri.https(baseUrl, 'api/wallets/checkBalance');
    final response = await http.post(
      uri,
      headers: {
        'Cookie': '$token',
        'Content-Type': 'application/json'
      },
      body: json.encode({'currency': currency})
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.body);
      throw Exception('Failed to check balance: ${response.statusCode}');
    }
  }
}