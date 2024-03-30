import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WalletService {
  final String baseUrl = 'wallet.api.dev.wault.pro';
  FlutterSecureStorage fss = FlutterSecureStorage();

  Future<List<dynamic>> fetchWallets() async {
    final token = await fss.read(key: 'token');
    final uri = Uri.https(baseUrl, '/api/wallets');
    final response = await http.get(uri, headers: {
      'Cookie': '$token',
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data;
    } else {
      throw Exception('Failed to load wallets: ${response.statusCode}');
    }
  }
}
