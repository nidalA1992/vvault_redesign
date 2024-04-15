import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/data/wallet_by_currency_service.dart';

class WalletByCurrencyProvider with ChangeNotifier {
  Map<String, dynamic> _wallet = {'currency': '', 'balance': '0'};
  final WalletByCurrencyService _walletService = WalletByCurrencyService();

  Map<String, dynamic> get wallet => _wallet;

  Future<void> fetchWallet(String currency) async {
    try {
      _wallet = await _walletService.fetchWallet(currency: currency);
      notifyListeners();
    } catch (e) {
      print('Error fetching wallet: $e');
    }
  }
}
