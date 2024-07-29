import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vvault_redesign/core/constants/urls.dart';
import 'my_requisite.dart';

class RequisitesProvider with ChangeNotifier {
  List<MyRequisite> _requisites = [];
  List<MyRequisite> get requisites => _requisites;
  FlutterSecureStorage fss = FlutterSecureStorage();

  Future<void> fetchRequisites() async {
    var token = await fss.read(key: 'token');
    final response = await http.get(
      Uri.parse('https://${Urls.exchangeBaseUrl}/api/exchange/requisites'),
      headers: {'Cookie': '$token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> requisitesJson = jsonDecode(response.body)['data'];
      _requisites = requisitesJson.map((json) => MyRequisite.fromJson(json)).toList();
      print('Fetched Requisites: $_requisites');
      notifyListeners();
    } else {
      throw Exception('Failed to load requisites');
    }
  }
}
