import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vvault_redesign/features/shared/constants/urls.dart';

class CryptoCurrenciesListService {
  final String baseUrl = Urls.exchangeBaseUrl;

  FlutterSecureStorage fss = FlutterSecureStorage();

  Future<List<dynamic>> fetchCryptoCurrencies() async {

    final token = await fss.read(key: 'token');

    final uri = Uri.https(baseUrl, '/api/exchange/cryptocurrencies');
    final response = await http.get(uri, headers: {
      'Cookie': '$token',
      'Content-Type': 'application/json',

    }
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      return data;
    } else {
      throw Exception('Failed to load crypto currencies: ${response.statusCode}');
    }
  }

}