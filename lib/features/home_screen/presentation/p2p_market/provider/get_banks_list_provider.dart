import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/data/get_banks_list_service.dart';

class BanksListProvider with ChangeNotifier {
  List<String> _banks = [];
  List<dynamic> dynamicList = [];
  final BanksListService _apiService = BanksListService();
  List<String> get banks => _banks;

  Future<void> loadBanks() async {
    try {
      dynamicList = await _apiService.fetchBanks();
      _banks = dynamicList.map((dynamic item) => item.toString()).toList();
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

}