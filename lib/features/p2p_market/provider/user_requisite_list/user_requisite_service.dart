import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vvault_redesign/core/constants/urls.dart';

class UserRequisiteService {
  FlutterSecureStorage fss = FlutterSecureStorage();

  Future<List<dynamic>> fetchRequisites() async {
    final token = await fss.read(key: 'token');
    final response = await http.get(
      Uri.parse('${Urls.exchangeBaseUrl}/api/exchange/requisites'),
      headers: {'Cookie': token!},
    );

    if (response.statusCode == 200) {
      print(response.body);
      final List<dynamic> data = json.decode(response.body)['data'];
      return data;
    } else {
      print(response.body);
      throw Exception('Failed to fetch requisites: ${response.statusCode}');
    }
  }
}