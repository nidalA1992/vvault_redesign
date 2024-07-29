import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vvault_redesign/core/constants/urls.dart';

class PaymentService {
  final String baseUrl = Urls.exchangeBaseUrl;

  FlutterSecureStorage fss = FlutterSecureStorage();

  Future<Map<String, dynamic>> createPayment({
    required String comment,
    required String cryptoCurrency,
    required String notifyUrl,
    required String redirectUrl,
    required String targetAmount,
    required String targetCurrency,
  }) async {
    final token = await fss.read(key: 'token');

    final uri = Uri.https(baseUrl, '/api/payments/create');
    final response = await http.post(uri, headers: {
      'Cookie': '$token',
      'Content-Type': 'application/json',
    }, body: json.encode({
      'comment': comment,
      'crypto_currency': cryptoCurrency,
      'notify_url': notifyUrl,
      'redirect_url': redirectUrl,
      'target_amount': targetAmount,
      'target_currency': targetCurrency,
    }));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to create payment: ${response.statusCode}, ${response.body}');
    }
  }
}
