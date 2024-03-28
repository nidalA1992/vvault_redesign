import 'package:flutter/material.dart';
import 'deal_from_order_service.dart';

class DealProvider with ChangeNotifier {
  final DealFromOrderService _apiService = DealFromOrderService();

  Future<void> startDeal(String orderId, Map<String, dynamic> dealData) async {
    try {
      await _apiService.startDeal(orderId, dealData);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
