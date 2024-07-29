import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:vvault_redesign/features/shared/ui_kit/home_page/notification_model.dart';
import 'dart:convert';
import 'package:vvault_redesign/core/constants/urls.dart';

class NotificationsService {
  final String baseUrl = Urls.notificationsBaseUrl;
  final FlutterSecureStorage fss = FlutterSecureStorage();

  Future<List<NotificationModel>> fetchNotifications({int offset = 0, int limit = 10}) async {
    final token = await fss.read(key: 'token');
    final uri = Uri.https(baseUrl, '/api/communication/history', {
      'offset': offset.toString(),
      'limit': limit.toString(),
    });

    final response = await http.get(uri, headers: {
      'Cookie': '$token',
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print("check $data");
      if (data['data'] != null && data['data'] is List) {
        return (data['data'] as List).map((json) => NotificationModel.fromJson(json)).toList();
      } else {
        throw Exception('No notifications found or invalid format');
      }
    } else {
      throw Exception('Failed to load notifications: ${response.statusCode}, ${response.body}');
    }
  }

  Future<void> deleteAllNotifications() async {
    final token = await fss.read(key: 'token');
    final uri = Uri.https(baseUrl, '/api/communication/history');

    final response = await http.delete(uri, headers: {
      'Cookie': '$token',
      'Content-Type': 'application/json',
    });

    if (response.statusCode != 200) {
      throw Exception('Failed to delete notifications: ${response.statusCode}');
    }
  }

  Future<void> deleteNotification(String id) async {
    final token = await fss.read(key: 'token');
    final uri = Uri.https(baseUrl, '/api/communication/history/$id');

    final response = await http.delete(uri, headers: {
      'Cookie': '$token',
      'Content-Type': 'application/json',
    });

    if (response.statusCode != 200) {
      throw Exception('Failed to delete notification: ${response.statusCode}');
    }
  }
}
