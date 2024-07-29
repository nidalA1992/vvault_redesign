import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/p2p_market/provider/notify_deal/notify_deal_service.dart';

class NotificationProvider with ChangeNotifier {
  final NotifyDealService _apiService = NotifyDealService();

  Future<void> notifyTransfer(String id) async {
    try {
      await _apiService.notifyTransfer(id);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}