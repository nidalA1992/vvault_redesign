import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:vvault_redesign/core/constants/urls.dart';
import 'dart:convert';

class DealDetail {
  final String id;
  final String status;
  final String sellerAmount;
  final String buyerAmount;
  final String sellerLogin;
  final String sellerCurrency;
  final String requisiteId;
  final String comment;
  final String bank;

  DealDetail({
    required this.id,
    required this.status,
    required this.sellerAmount,
    required this.buyerAmount,
    required this.sellerLogin,
    required this.sellerCurrency,
    required this.requisiteId,
    required this.comment,
    required this.bank,
  });

  factory DealDetail.fromJson(Map<String, dynamic> json) {
    return DealDetail(
      id: json['id'] ?? '',
      status: json['status'] ?? '',
      sellerAmount: json['taker_give'] ?? '',
      buyerAmount: json['buyerAmount'] ?? '',
      sellerLogin: json['sellerLogin'] ?? '',
      sellerCurrency: json['sellerCurrency'] ?? '',
      requisiteId: json['card'] ?? '',
      comment: json['maker_comment'] ?? '',
      bank: json['bank'] ?? '',
    );
  }
}

class DealInfoProvider with ChangeNotifier {
  DealDetail? dealDetail;
  bool isLoading = false;
  String? errorMessage;
  FlutterSecureStorage fss = FlutterSecureStorage();
  String authToken = '';

  Future<void> fetchDealDetail(String id) async {
    isLoading = true;
    notifyListeners();
    final url = 'https://${Urls.exchangeBaseUrl}/api/exchange/deals/$id';
    authToken = (await fss.read(key: 'token'))!;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Cookie': authToken,
          'Content-Type': 'application/json',
        },
      );
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        if (jsonData.containsKey('data') && jsonData['data'].containsKey('deal')) {
          dealDetail = DealDetail.fromJson(jsonData['data']['deal']);
          print('Deal detail: ${dealDetail.toString()}');
          errorMessage = null;
        } else {
          errorMessage = 'Invalid response structure';
          print('Error: $errorMessage');
        }
      } else {
        errorMessage = 'Failed to load data: ${response.statusCode}';
        print('Error: $errorMessage');
      }
    } catch (e) {
      errorMessage = 'Error: $e';
      print('Exception: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> approveDeal(String id) async {
    final url =
        'https://${Urls.exchangeBaseUrl}/api/exchange/deals/$id/approve';
    authToken = (await fss.read(key: 'token'))!;
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Cookie': authToken, 'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print(jsonData);
        notifyListeners();
      } else {
        throw Exception(
            'Failed to approve deal: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error approving deal: $e');
    }
  }
}
