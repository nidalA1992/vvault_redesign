import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/data/update_order_service.dart';

class UpdateOrderProvider with ChangeNotifier {
  final UpdateOrderService _apiService = UpdateOrderService();

  Future<void> updateOrder(Map<String, dynamic> orderData, String _id) async {
    try {
      final data = await _apiService.updateOrder(orderData, _id);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}