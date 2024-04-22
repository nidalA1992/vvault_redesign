import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'deal_info_model.dart';

class DealInfoProvider with ChangeNotifier {
  DealDetail? dealDetail;
  bool isLoading = false;
  String? errorMessage;
  FlutterSecureStorage fss = FlutterSecureStorage();
  String authToken = '';


  Future<void> fetchDealDetail(String id) async {
    isLoading = true;
    notifyListeners();
    final url = 'https://exchange.api.dev.wault.pro/api/exchange/deals/$id';
    authToken = (await fss.read(key: 'token'))!;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Cookie': authToken},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        dealDetail = DealDetail.fromJson(jsonData['data']['deal']);
        errorMessage = null;
        notifyListeners();
      } else {
        errorMessage = 'Failed to load data: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage = 'Error: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> approveDeal(String id) async {
    final url = 'https://exchange.api.dev.wault.pro/api/exchange/deals/$id/approve';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Cookie': authToken,
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print(jsonData);
        notifyListeners();
      } else {
        throw Exception('Failed to approve deal: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error approving deal: $e');
    }
  }

}
