import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/shared/ui_kit/home_page/notification_model.dart';
import '../data/notifications_service.dart';

class NotificationsProvider with ChangeNotifier {
  List<NotificationModel> _notifications = [];
  final NotificationsService _apiService = NotificationsService();

  List<NotificationModel> get notifications => _notifications;

  Future<void> loadNotifications({int offset = 0, int limit = 10}) async {
    try {
      _notifications = await _apiService.fetchNotifications(offset: offset, limit: limit);
      notifyListeners();
    } catch (e) {
      print(e);
      _notifications = [];
      notifyListeners();
      throw e;
    }
  }

  Future<void> deleteAllNotifications() async {
    try {
      await _apiService.deleteAllNotifications();
      _notifications.clear();
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> deleteNotification(String id) async {
    try {
      await _apiService.deleteNotification(id);
      _notifications.removeWhere((notification) => notification.id == id);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}