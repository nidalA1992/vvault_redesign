import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/data/withdraw_service.dart';

class WithdrawProvider with ChangeNotifier {
  final WithdrawService _withdrawService = WithdrawService();
  String? _transactionId;

  String? get transactionId => _transactionId;

  Future<void> withdrawCurrency({
    required String address,
    required String amount,
    required String code,
    required String currency,
  }) async {
    try {
      final response = await _withdrawService.withdrawCurrency(
        address: address,
        amount: amount,
        code: code,
        currency: currency,
      );
      _transactionId = response['data']['transaction_id'];
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
