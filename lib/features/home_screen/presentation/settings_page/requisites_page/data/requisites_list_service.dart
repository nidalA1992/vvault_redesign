import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RequisitesListService {
  final String baseUrl = 'https://exchange.api.dev.wault.pro';
  FlutterSecureStorage fss = FlutterSecureStorage();

  Future<List<dynamic>> fetchRequisites() async {
    final token = await fss.read(key: 'token');
    final response = await http.get(
      Uri.parse('$baseUrl/api/exchange/requisites'),
      headers: {'Cookie': token!},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data;
    } else {
      print(response.body);
      throw Exception('Failed to fetch requisites: ${response.statusCode}');
    }
  }
}