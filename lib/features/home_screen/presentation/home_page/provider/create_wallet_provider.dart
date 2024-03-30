import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/data/create_wallet_service.dart';

class WalletCreationProvider with ChangeNotifier {
  final WalletCreationService _walletCreationService = WalletCreationService();
  Map<String, dynamic> _walletCreationResponse = {};

  Map<String, dynamic> get walletCreationResponse => _walletCreationResponse;

  Future<void> createWallet(String currency) async {
    try {
      _walletCreationResponse = await _walletCreationService.createWallet(currency);
      notifyListeners();
    } catch (e) {
      print('Error creating wallet: $e');
    }
  }
}
