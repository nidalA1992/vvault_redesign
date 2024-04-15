import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WalletByCurrencyService {
  final String baseUrl = 'wallet.api.dev.wault.pro';
  FlutterSecureStorage fss = FlutterSecureStorage();

  Future<Map<String, dynamic>> fetchWallet({String? currency}) async {
    final String? token = await fss.read(key: 'token');
    final uri = Uri.https(baseUrl, '/api/wallets/bycurrency', currency != null ? {'currency': currency} : {});

    final response = await http.get(uri, headers: {
      'Cookie': '$token',
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body)['data'];
    } else {
      print('Failed to load wallet with status code: ${response.statusCode}');
      print('Error: ${response.body}');
      throw Exception('Failed to load wallet: ${response.statusCode}');
    }
  }
}