import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vvault_redesign/features/authorization/data/sign_in_service.dart';

class SignInProvider with ChangeNotifier {
  String? _apiKey;
  String? _userId;

  String? get apiKey => _apiKey;
  String? get userId => _userId;
  FlutterSecureStorage fss = FlutterSecureStorage();

  final SignInService _apiService = SignInService();



  Future<void> signIn(String login, String password) async {
    try {
      final data = await _apiService.signIn({
        'login': login,
        'password': password,
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