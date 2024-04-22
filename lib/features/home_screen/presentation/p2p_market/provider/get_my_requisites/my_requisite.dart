class MyRequisite {
  final String bank;
  final String comment;
  final String id;
  final String requisite;
  final String userId;

  MyRequisite({required this.bank, required this.comment, required this.id, required this.requisite, required this.userId});

  factory MyRequisite.fromJson(Map<String, dynamic> json) {
    return MyRequisite(
      bank: json['bank'],
      comment: json['comment'],
      id: json['id'],
      requisite: json['requisite'],
      userId: json['user_id'],
    );
  }
}