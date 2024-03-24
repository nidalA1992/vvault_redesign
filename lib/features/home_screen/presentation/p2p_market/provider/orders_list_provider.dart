import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/data/orders_list_service.dart';

class OrderProvider with ChangeNotifier {
  List<dynamic> _orders = [];
  final OrdersService _apiService = OrdersService();
  List<dynamic> get orders => _orders;

  Future<void> loadOrders() async {
    try {
      final queryParams = {
        'sortby': 'created_at',
        'ascending': 'true',
      };
      _orders = await _apiService.fetchOrders(queryParams);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}