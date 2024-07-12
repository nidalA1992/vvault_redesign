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

  Map<String, dynamic> _userme = {};
  Map<String, dynamic> get userme => _userme;

  Future<void> loadUserMe() async {
    try {
      _userme = await _apiService.fetchUserMe();
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Map<String, dynamic> _accountInfo = {};
  Map<String, dynamic> get accountInfo => _accountInfo;

  Future<void> loadAccountInfo(String? id) async {
    try {
      _accountInfo = await _apiService.getAccountInfo(id);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}