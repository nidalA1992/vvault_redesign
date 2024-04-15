class DealDetail {
  final String card;
  final String createdAt;
  final String id;
  final bool isAuto;
  final String maker;
  final String makerConditions;
  final String makerCurrency;
  final String makerCurrencyType;
  final String makerGet;
  final String makerGive;
  final bool makerRated;
  final String makerWalletId;
  final String orderId;
  final String payer;
  final String paymentId;
  final String price;
  final String requisiteId;
  final String status;
  final String taker;
  final String takerCurrency;
  final String takerCurrencyType;
  final String takerGet;
  final String takerGive;
  final bool takerRated;
  final String takerWalletId;
  final String updatedAt;

  DealDetail({
    required this.card,
    required this.createdAt,
    required this.id,
    required this.isAuto,
    required this.maker,
    required this.makerConditions,
    required this.makerCurrency,
    required this.makerCurrencyType,
    required this.makerGet,
    required this.makerGive,
    required this.makerRated,
    required this.makerWalletId,
    required this.orderId,
    required this.payer,
    required this.paymentId,
    required this.price,
    required this.requisiteId,
    required this.status,
    required this.taker,
    required this.takerCurrency,
    required this.takerCurrencyType,
    required this.takerGet,
    required this.takerGive,
    required this.takerRated,
    required this.takerWalletId,
    required this.updatedAt,
  });

  factory DealDetail.fromJson(Map<String, dynamic> json) {
    return DealDetail(
      card: json['card'],
      createdAt: json['created_at'],
      id: json['id'],
      isAuto: json['is_auto'],
      maker: json['maker'],
      makerConditions: json['maker_conditions'],
      makerCurrency: json['maker_currency'],
      makerCurrencyType: json['maker_currency_type'],
      makerGet: json['maker_get'],
      makerGive: json['maker_give'],
      makerRated: json['maker_rated'],
      makerWalletId: json['maker_wallet_id'],
      orderId: json['order_id'],
      payer: json['payer'],
      paymentId: json['payment_id'],
      price: json['price'],
      requisiteId: json['requisite_id'],
      status: json['status'],
      taker: json['taker'],
      takerCurrency: json['taker_currency'],
      takerCurrencyType: json['taker_currency_type'],
      takerGet: json['taker_get'],
      takerGive: json['taker_give'],
      takerRated: json['taker_rated'],
      takerWalletId: json['taker_wallet_id'],
      updatedAt: json['updated_at'],
    );
  }
}