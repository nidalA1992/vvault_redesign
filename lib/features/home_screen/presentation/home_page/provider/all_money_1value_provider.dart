import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/data/all_money_in_1value_service.dart';

class AllMoneyProvider with ChangeNotifier {
  String? _allMoney;
  final AllMoneyService _apiService = AllMoneyService();

  String? get allMoney => _allMoney;

  Future<void> fetchAllMoney(String? currency) async {
    try {
      final Map<String, dynamic> response = await _apiService.fetchAllMoney(currency: currency);
      _allMoney = response['data']['value'] as String;
      notifyListeners();
    } catch (e) {
      print(e);
      rethrow;
    }
  }


}
