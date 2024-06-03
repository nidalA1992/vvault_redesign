import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/data/create_payment_service.dart';

class PaymentProvider with ChangeNotifier {
  final PaymentService _paymentService = PaymentService();
  String? _paymentId;

  String? get paymentId => _paymentId;

  Future<void> createPayment({
    required String comment,
    required String cryptoCurrency,
    String? notifyUrl,
    String? redirectUrl,
    required String targetAmount,
    required String targetCurrency,
  }) async {
    try {
      final response = await _paymentService.createPayment(
        comment: comment,
        cryptoCurrency: cryptoCurrency,
        notifyUrl: notifyUrl ?? '',
        redirectUrl: redirectUrl ?? '',
        targetAmount: targetAmount,
        targetCurrency: targetCurrency,
      );
      _paymentId = response['data']['payment_id'];
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
