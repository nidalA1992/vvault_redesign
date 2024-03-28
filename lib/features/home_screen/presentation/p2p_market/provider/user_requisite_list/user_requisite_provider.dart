import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/user_requisite_list/user_requisite_service.dart';

class UserRequisiteProvider with ChangeNotifier {
  List<dynamic> _requisites = [];
  final UserRequisiteService _apiService = UserRequisiteService();

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
