import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/home_page/data/get_crypto_currencies_service.dart';


class CryptoCurrenciesListProvider with ChangeNotifier {
  List<String> _cryptoCurrencies = [];
  List<dynamic> dynamicList = [];
  final CryptoCurrenciesListService _apiService = CryptoCurrenciesListService();
  List<String> get cryptoCurrencies => _cryptoCurrencies;

  Future<void> loadCryptoCurrencies() async {
    try {
      dynamicList = await _apiService.fetchCryptoCurrencies();
      _cryptoCurrencies = dynamicList.map((dynamic item) => item.toString()).toList();
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

}