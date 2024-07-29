import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vvault_redesign/core/constants/urls.dart';


class NotifyDealService {

  final fss = FlutterSecureStorage();


  Future<Map<String, dynamic>> notifyTransfer(String id) async {
    final token = await fss.read(key: 'token');
    final response = await http.post(
      Uri.https(Urls.exchangeBaseUrl, '/api/exchange/deals/$id'), // Примерный путь, проверьте документацию API
      headers: {
        'Cookie': '$token',
        'Content-Type': 'application/json',
      },
      body: json.encode({}), // Если требуются дополнительные параметры, добавьте их здесь
    );

    if (response.statusCode == 200) {
      print(json.decode(response.body)['error']);
      print(json.decode(response.body));
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to notify transfer: ${response.body}');
    }
  }
}