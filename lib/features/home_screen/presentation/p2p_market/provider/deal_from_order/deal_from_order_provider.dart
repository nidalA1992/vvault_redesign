import 'package:flutter/material.dart';
import 'deal_from_order_service.dart';

class DealProvider with ChangeNotifier {

  String? dealId = '';

  final DealFromOrderService _apiService = DealFromOrderService();

  Map<String, dynamic> _dealDetails = {};

  Map<String, dynamic> get dealDetails => _dealDetails;

  Future<void> startDeal(String orderId, Map<String, dynamic> dealData) async {
    try {
      _dealDetails = await _apiService.startDeal(orderId, dealData);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
