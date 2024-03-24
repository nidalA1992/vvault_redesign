import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/data/orders_list_service.dart';

class OrderProvider with ChangeNotifier {
  List<dynamic> _orders = [];
  List<dynamic> _logins = [];
  final OrdersService _apiService = OrdersService();
  List<dynamic> get orders => _orders;

  Future<void> loadOrders() async {
    try {
      final queryParams = {
        'sortby': 'created_at',
        'ascending': 'true',
      };

      _orders = await _apiService.fetchOrders(queryParams);
      _logins = await _apiService.fetchUserStats();

      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

   Future<String> fetchUserStats(String userId) async {
    try {
      final user_name =  await _apiService.fetchUserStats(userId);
      print("test2 ${user_name['user_name']}");
      return user_name['user_name'].toString();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

}