import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TransactionHistoryService {
  final String baseUrl = 'wallet.api.dev.wault.pro';
  final FlutterSecureStorage fss = FlutterSecureStorage();

  Future<List<dynamic>> fetchTransactions({bool ascending = true, String? filter, int offset = 0, int limit = 10}) async {
    final token = await fss.read(key: 'token');
    final queryParams = {
      'ascending': ascending.toString(),
      if (filter != null) 'filter': filter,
      'offset': offset.toString(),
      'limit': limit.toString(),
    };
    final uri = Uri.https(baseUrl, '/api/transactions', queryParams);
    final response = await http.get(
        uri,
        headers: {
          'Cookie': '$token',
          'Content-Type': 'application/json',
        }
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data;
    } else {
      throw Exception('Failed to load transactions: ${response.statusCode}');
    }
  }
}