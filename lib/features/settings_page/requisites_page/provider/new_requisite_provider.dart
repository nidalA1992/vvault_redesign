import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/settings_page/requisites_page/data/new_requisite_service.dart';


class NewRequisiteProvider with ChangeNotifier {
  final NewRequisiteService _apiService = NewRequisiteService();

  Future<void> createRequisite(Map<String, dynamic> requisiteData) async {
    try {
      await _apiService.createRequisite(requisiteData);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}