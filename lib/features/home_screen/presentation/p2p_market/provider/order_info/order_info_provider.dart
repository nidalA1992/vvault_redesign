import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/order_info/order_info_service.dart';

class OrderInfoProvider with ChangeNotifier {
  final OrderInfoService _apiService = OrderInfoService();

  Map<String, dynamic> _orderDetails = {};

  Map<String, dynamic> get orderDetails => _orderDetails;

  Future<void> loadOrderDetails(String orderId) async {
    try {
      _orderDetails = await _apiService.fetchOrderDetails(orderId);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}