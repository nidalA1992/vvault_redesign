class NotificationModel {
  final String id;
  final String type;
  final String createdAt;
  final String userId;
  final Map<String, dynamic> message;

  NotificationModel({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.userId,
    required this.message,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      type: json['type'],
      createdAt: json['created_at'],
      userId: json['user_id'],
      message: json['message'],
    );
  }
}
