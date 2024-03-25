import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/data/create_buy_order_service.dart';

class BuyOrderProvider with ChangeNotifier {
  final BuyOrderService _apiService = BuyOrderService();

  Future<void> createBuyOrder(Map<String, dynamic> orderData) async {
    try {
      final data = await _apiService.createBuyOrder(orderData);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}