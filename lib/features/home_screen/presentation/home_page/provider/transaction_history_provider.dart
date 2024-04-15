import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/data/transaction_historty_service.dart';

class TransactionHistoryProvider with ChangeNotifier {
  List<dynamic> _transactions = [];
  final TransactionHistoryService _transactionService = TransactionHistoryService();

  List<dynamic> get transactions => _transactions;

  Future<void> loadTransactions({bool ascending = false, String? filter, int offset = 0, int limit = 10}) async {
    try {
      _transactions = await _transactionService.fetchTransactions(
        ascending: ascending,
        filter: filter,
        offset: offset,
        limit: limit,
      );
      notifyListeners();
    } catch (e) {
      print('Error fetching transactions: $e');
      clearTransactions();
    }
  }

  void clearTransactions() {
    _transactions = [];
    notifyListeners();
  }

}