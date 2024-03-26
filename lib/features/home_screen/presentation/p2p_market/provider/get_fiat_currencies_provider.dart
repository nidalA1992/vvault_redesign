import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/data/get_fiat_currencies_service.dart';

class FiatCurrenciesListProvider with ChangeNotifier {
  List<String> _fiatCurrencies = [];
  List<dynamic> dynamicList = [];
  final FiatCurrenciesListService _apiService = FiatCurrenciesListService();
  List<String> get fiatCurrencies => _fiatCurrencies;

  Future<void> loadFiatCurrencies() async {
    try {
      dynamicList = await _apiService.fetchFiatCurrencies();
      _fiatCurrencies = dynamicList.map((dynamic item) => item.toString()).toList();
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

}