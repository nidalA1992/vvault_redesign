import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/home_page/data/get_user_wallets_service.dart';

class WalletProvider with ChangeNotifier {
  List<dynamic> _wallets = [];
  final WalletService _walletService = WalletService();
  List<dynamic> get wallets => _wallets;

  Future<void> loadWallets() async {
    try {
      _wallets = await _walletService.fetchWallets();
      notifyListeners();
    } catch (e) {
      print('Error fetching wallets: $e');
    }
  }
}
