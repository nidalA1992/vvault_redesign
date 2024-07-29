import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/p2p_market/data/create_sell_order_service.dart';

class SellOrderProvider with ChangeNotifier {
  final SellOrderService _apiService = SellOrderService();

  Future<void> createSellOrder(Map<String, dynamic> orderData) async {
    try {
      final data = await _apiService.createSellOrder(orderData);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}