import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/data/orders_list_service.dart';

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
  final OrdersService _apiService = OrdersService();
  List<dynamic> get orders => _orders;

  Future<void> loadOrders({String? price, bool? isMyOrders}) async {
    bool effectiveIsMyOrders = isMyOrders ?? false;

    print("testing filter ${price}");
    try {
      final queryParams = {
        'sortby': 'created_at',
        'ascending': 'true',
      };

      if (price != null) {
        queryParams['price'] = price;
      }

      _orders = await _apiService.fetchOrders(queryParams);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }


  Future<String> fetchUserStats(String userId) async {
    try {
      final user_name =  await _apiService.fetchUserStats(userId);
      return user_name['user_name'];
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}