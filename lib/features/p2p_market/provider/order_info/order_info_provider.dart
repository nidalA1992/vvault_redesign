import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/p2p_market/provider/order_info/order_info_service.dart';


class OrderInfoProvider with ChangeNotifier {


  String? sellerCurrency = '';
  String? sellerLogin = '';
  String? amount = '';
  String? requisiteId = '';
  String? sellerBank = '';
  String? requisite = '';
  String? comment = '';
  String? orderId = '';
  String? makerCurrency = '';


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