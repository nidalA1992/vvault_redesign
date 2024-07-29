import 'dart:convert';

class Transaction {
  final String comment;
  final String createdAt;
  final String currency;
  final Map<String, String> data;
  final String from;
  final String fromType;
  final String giveAmount;
  final String id;
  final String status;
  final String takeAmount;
  final String to;
  final String toType;
  final String type;
  final String updatedAt;

  Transaction({
    required this.comment,
    required this.createdAt,
    required this.currency,
    required this.data,
    required this.from,
    required this.fromType,
    required this.giveAmount,
    required this.id,
    required this.status,
    required this.takeAmount,
    required this.to,
    required this.toType,
    required this.type,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      comment: json['comment'],
      createdAt: json['createdAt'],
      currency: json['currency'],
      data: Map<String, String>.from(json['data']),
      from: json['from'],
      fromType: json['fromType'],
      giveAmount: json['giveAmount'],
      id: json['id'],
      status: json['status'],
      takeAmount: json['takeAmount'],
      to: json['to'],
      toType: json['toType'],
      type: json['type'],
      updatedAt: json['updatedAt'],
    );
  }
}

class TransactionResponse {
  final List<Transaction> data;
  final String? message;
  final String? errorMessage;

  TransactionResponse({
    required this.data,
    this.message,
    this.errorMessage,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    var dataList = (json['data'] as List).map((item) => Transaction.fromJson(item)).toList();
    String? errMsg;
    if (json.containsKey('error')) {
      errMsg = json['error']['message'];
    }
    return TransactionResponse(
      data: dataList,
      message: json['message'],
      errorMessage: errMsg,
    );
  }
}
