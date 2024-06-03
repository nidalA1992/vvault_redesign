import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vvault_redesign/features/home_screen/presentation/authorization/data/sign_up_service.dart';

class SignUpProvider with ChangeNotifier {
  String? _apiKey;
  String? _userId;

  String? get apiKey => _apiKey;
  String? get userId => _userId;
  FlutterSecureStorage fss = FlutterSecureStorage();

  final SignUpService _apiService = SignUpService();



  Future<void> signUp(String login, String password, String phone, String username) async {
    try {
      final data = await _apiService.signUp({
        'email': login,
        'password': password,
        'phone': phone,
        'username': username
      });
      _apiKey = data['api_key'];
      _userId = data['id'];
      // fss.write(key: 'token', value: _userId);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}