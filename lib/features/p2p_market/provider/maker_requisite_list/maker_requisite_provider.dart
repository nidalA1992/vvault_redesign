import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/p2p_market/provider/maker_requisite_list/maker_requisite_service.dart';

class RequisiteProvider with ChangeNotifier {
  final MakerRequisiteService _apiService = MakerRequisiteService();

  Map<String, dynamic> _requisiteInfo = {};

  Map<String, dynamic> get requisiteInfo => _requisiteInfo;

  Future<void> loadRequisiteInfo(String requisiteId) async {
    try {
      _requisiteInfo = await _apiService.fetchRequisiteInfo(requisiteId);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}