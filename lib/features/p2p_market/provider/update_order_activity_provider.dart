import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/p2p_market/data/update_order_activity_service.dart';

class UpdateOrderActivityProvider with ChangeNotifier {
  final UpdateOrderActivityService _apiService = UpdateOrderActivityService();

  Future<void> updateOrderActivity(Map<String, dynamic> orderData, String _id) async {
    try {
      final data = await _apiService.updateOrderActivity(orderData, _id);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}