import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TransferCurrencyService {
  final String baseUrl = 'wallet.api.dev.wault.pro';
  FlutterSecureStorage fss = FlutterSecureStorage();

  Future<Map<String, dynamic>> submitTransaction({
    required String amount,
    required String comment,
    required String currency,
    required String user,
  }) async {
    final String? token = await fss.read(key: 'token');
    final uri = Uri.https(baseUrl, '/api/wallets/transfer');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Cookie': '$token',
      },
      body: json.encode({
        'amount': amount,
        'comment': comment,
        'currency': currency,
        'user': user,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Failed to submit transaction: ${response.statusCode}');
      print('Error: ${response.body}');
      throw Exception('Failed to submit transaction: ${response.statusCode}');
    }
  }
}
