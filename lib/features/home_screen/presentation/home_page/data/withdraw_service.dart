import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vvault_redesign/features/shared/constants/urls.dart';

class WithdrawService {
  final String baseUrl = Urls.notificationsBaseUrl;

  FlutterSecureStorage fss = FlutterSecureStorage();

  Future<Map<String, dynamic>> withdrawCurrency({
    required String address,
    required String amount,
    required String code,
    required String currency,
  }) async {
    final token = await fss.read(key: 'token');

    final uri = Uri.https(baseUrl, '/api/wallets/withdraw');
    final response = await http.post(uri, headers: {
      'Cookie': '$token',
      'Content-Type': 'application/json',
    }, body: json.encode({
      'address': address,
      'amount': amount,
      'code': code,
      'currency': currency,
    }));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to withdraw currency: ${response.statusCode}, ${response.body}');
    }
  }
}
