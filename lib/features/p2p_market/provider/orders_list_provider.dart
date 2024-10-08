import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/p2p_market/data/orders_list_service.dart';

class OrderProvider with ChangeNotifier {
  List<dynamic> _orders = [];

  String? fiat = '';
  String? crypto = '';
  String? cost = '';
  List<dynamic> banks = [];
  String? comments = '';
  String? unitCost = '';
  String? orderId = '';
  String? login = '';
  String? makerId = '';
  String? upper = '';
  String? lower = '';
  String? requisite = '';
  final OrdersService _apiService = OrdersService();

  List<dynamic> get orders => _orders;

  Future<void> loadOrders({String? price, bool? isMyOrders}) async {
    bool effectiveIsMyOrders = isMyOrders ?? false;
    print("testing filter $price");

    try {
      final queryParams = {
        'sortby': 'created_at',
        'ascending': 'true',
      };

      if (price != null) {
        queryParams['price'] = price;
      }

      var response = await _apiService.fetchOrders(queryParams);
      if (response is List) {
        _orders = response;
      } else {
        _orders = [];
      }
      notifyListeners();
    } catch (e) {
      print(e);
      _orders = [];
      notifyListeners();
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchUserStats(String userId) async {
    try {
      final userStats = await _apiService.fetchUserStats(userId);
      return userStats;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void updateOrderActivity(String id, bool isActive) {
    for (var order in _orders) {
      if (order['order']['id'] == id) {
        order['order']['active'] = isActive;
        break;
      }
    }
    notifyListeners();
  }
}
