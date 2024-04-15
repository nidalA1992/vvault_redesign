import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/data/tranfer_currency_service.dart';

class TransferCurrencyProvider with ChangeNotifier {
  bool _isSubmitting = false;
  Map<String, dynamic> _transactionResponse = {};
  final TransferCurrencyService _transactionService = TransferCurrencyService();

  bool get isSubmitting => _isSubmitting;
  Map<String, dynamic> get transactionResponse => _transactionResponse;

  Future<void> submitTransaction({
    required String amount,
    required String comment,
    required String currency,
    required String user,
  }) async {
    _isSubmitting = true;
    notifyListeners();

    try {
      _transactionResponse = await _transactionService.submitTransaction(
        amount: amount,
        comment: comment,
        currency: currency,
        user: user,
      );
      _isSubmitting = false;
      notifyListeners();
    } catch (e) {
      _isSubmitting = false;
      print('Error submitting transaction: $e');
      notifyListeners();
      throw Exception('Error submitting transaction: $e');
    }
  }
}
