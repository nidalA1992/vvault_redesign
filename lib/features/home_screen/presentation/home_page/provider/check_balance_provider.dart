import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/data/check_balance_service.dart';

class CheckBalanceProvider with ChangeNotifier {
  final CheckBalanceService _checkBalanceService = CheckBalanceService();
  Map<String, dynamic> _checkBalanceResponse = {};

  Map<String, dynamic> get checkBalanceResponse => _checkBalanceResponse;

  Future<void> checkBalance(String currency) async {
    try {
      _checkBalanceResponse = await _checkBalanceService.checkBalance(currency);
      notifyListeners();
    } catch (e) {
      print('Error checking balance $e');
    }
  }
}