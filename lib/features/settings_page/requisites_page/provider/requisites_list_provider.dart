import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/settings_page/requisites_page/data/requisites_list_service.dart';

class RequisitesListProvider with ChangeNotifier {
  List<dynamic> _requisites = [];
  final RequisitesListService _apiService = RequisitesListService();

  List<dynamic> get requisites => _requisites;

  Future<void> loadRequisites() async {
    try {
      _requisites = await _apiService.fetchRequisites();
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}