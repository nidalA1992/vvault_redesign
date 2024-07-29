class DealDetail {
  final String id;
  final String createdAt;
  final String updatedAt;
  final String orderId;
  final String? paymentId;
  final String? payer;
  final String taker;
  final String maker;
  final String takerCurrency;
  final String makerCurrency;
  final String takerCurrencyType;
  final String makerCurrencyType;
  final double makerGive;
  final double makerGet;
  final double takerGive;
  final double takerGet;
  final double price;
  final String takerComment;
  final String makerComment;
  final String requisiteId;
  final String bank;
  final String card;
  final String status;
  final bool takerRated;
  final bool makerRated;
  final bool isAuto;

  DealDetail({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.orderId,
    this.paymentId,
    this.payer,
    required this.taker,
    required this.maker,
    required this.takerCurrency,
    required this.makerCurrency,
    required this.takerCurrencyType,
    required this.makerCurrencyType,
    required this.makerGive,
    required this.makerGet,
    required this.takerGive,
    required this.takerGet,
    required this.price,
    required this.takerComment,
    required this.makerComment,
    required this.requisiteId,
    required this.bank,
    required this.card,
    required this.status,
    required this.takerRated,
    required this.makerRated,
    required this.isAuto,
  });

  factory DealDetail.fromJson(Map<String, dynamic> json) {
    return DealDetail(
      id: json['id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      orderId: json['order_id'],
      paymentId: json['payment_id'],
      payer: json['payer'],
      taker: json['taker'],
      maker: json['maker'],
      takerCurrency: json['taker_currency'],
      makerCurrency: json['maker_currency'],
      takerCurrencyType: json['taker_currency_type'],
      makerCurrencyType: json['maker_currency_type'],
      makerGive: double.parse(json['maker_give'].toString()),
      makerGet: double.parse(json['maker_get'].toString()),
      takerGive: double.parse(json['taker_give'].toString()),
      takerGet: double.parse(json['taker_get'].toString()),
      price: double.parse(json['price'].toString()),
      takerComment: json['taker_comment'] ?? '',
      makerComment: json['maker_comment'] ?? '',
      requisiteId: json['requisite_id'],
      bank: json['bank'],
      card: json['card'],
      status: json['status'],
      takerRated: json['taker_rated'],
      makerRated: json['maker_rated'],
      isAuto: json['is_auto'],
    );
  }
}