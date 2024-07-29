import 'package:flutter/material.dart';
import 'package:vvault_redesign/features/p2p_market/my_deals/data/my_deals_list_service.dart';

class DealListProvider with ChangeNotifier {
  List<dynamic> _deals = [];
  final DealsService _apiService = DealsService();
  List<dynamic> get deals => _deals;

  Future<void> loadDeals({
    bool? ascending,
    bool? onlyPaymentDeals,
    String? status,
    String? taker,
    String? maker,
    String? beginTime,
    String? endTime,
    int? offset,
    int? limit,
  }) async {
    try {
      final queryParams = <String, String>{
        'ascending': ascending?.toString() ?? 'true',
        'only_payment_deals': onlyPaymentDeals?.toString() ?? 'false',
      };

      if (offset != null) queryParams['offset'] = offset.toString();
      if (limit != null) queryParams['limit'] = limit.toString();
      if (status != null) queryParams['status'] = status;
      if (taker != null) queryParams['taker'] = taker;
      if (maker != null) queryParams['maker'] = maker;
      if (beginTime != null) queryParams['begin_time'] = beginTime;
      if (endTime != null) queryParams['end_time'] = endTime;

      _deals = await _apiService.fetchDeals(queryParams);
      notifyListeners();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
