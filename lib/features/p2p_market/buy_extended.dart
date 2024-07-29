import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/p2p_market/provider/order_info/order_info_provider.dart';
import 'package:vvault_redesign/features/shared/ui_kit/my_orders/modal_bottom_sheet.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_converter.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_field.dart';
import 'extended_buy_extended.dart';
import 'provider/deal_from_order/deal_from_order_provider.dart';
import 'provider/orders_list_provider.dart';

class BuyExtended extends StatefulWidget {
  final String? orderId;

  BuyExtended({super.key, required this.orderId});

  @override
  State<BuyExtended> createState() => _BuyExtendedState();
}

class _BuyExtendedState extends State<BuyExtended> {
  TextEditingController takerController = TextEditingController();
  TextEditingController _makerController = TextEditingController();
  double usdToRubRate = 93.50;
  bool isTakerActive = false;
  bool isMakerActive = false;
  List<String> _requisites = [];
  List<String> _requisitesId = [];
  String requisite = '';
  String comment = '';
  int? selectedIndex = 0;

  @override
  void initState() {
    _loadData();
    _requisites.clear();

    takerController.addListener(() {
      isTakerActive = true;
      _onTakerChanged();
      isTakerActive = false;
    });
    _makerController.addListener(() {
      isMakerActive = true;
      _onMakerChanged();
      isMakerActive = false;
    });
    super.initState();
  }

  void _loadData() async {
    await Provider.of<OrderInfoProvider>(context, listen: false)
        .loadOrderDetails(widget.orderId!);

    final orderDetails = Provider.of<OrderInfoProvider>(context, listen: false).orderDetails;

    if (orderDetails != null && orderDetails.containsKey('requisites') && orderDetails['requisites'].isNotEmpty) {
      for (var req in orderDetails['requisites']) {
        _requisites.add('${req['bank']}: ${req['requisite']}');
        _requisitesId.add(req['id']);
      }
      setState(() {
        requisite = _requisites.first;
        comment = orderDetails['requisites'].first['comment'];
      });
    }
  }

  void _onTakerChanged() {
    if (isMakerActive) return;

    double takerValue = double.tryParse(takerController.text) ?? 0.0;
    double makerValue = takerValue / usdToRubRate;
    _makerController.text = makerValue.toStringAsFixed(2);
  }

  void _onMakerChanged() {
    if (isTakerActive) return;

    double makerValue = double.tryParse(_makerController.text) ?? 0.0;
    double takerValue = makerValue * usdToRubRate;
    takerController.text = takerValue.toStringAsFixed(2);
  }

  @override
  void dispose() {
    takerController.dispose();
    _makerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var orderProvider = Provider.of<OrderProvider>(context, listen: false);
    String? fiat = orderProvider.fiat;
    String? crypto = orderProvider.crypto;
    String? cost = orderProvider.cost;
    List<dynamic> banks = orderProvider.banks;
    String? comments = orderProvider.comments;
    String? unitCost = orderProvider.unitCost;
    String? login = orderProvider.login;
    String? lower = orderProvider.lower;
    String? upper = orderProvider.upper;

    _requisites.clear();
    _requisitesId.clear();

    final orderDetails = Provider.of<OrderInfoProvider>(context).orderDetails;

    if (orderDetails != null && orderDetails.containsKey('requisites') && orderDetails['requisites'].isNotEmpty) {
      for (var req in orderDetails['requisites']) {
        _requisites.add('${req['bank']}: ${req['requisite']}');
        _requisitesId.add(req['id']);
      }
      requisite = _requisites.first;
      comment = orderDetails['requisites'].first['comment'];
    }

    if (orderDetails.isEmpty || !orderDetails.containsKey('requisites')) {
      return Scaffold(
        backgroundColor: Color(0xFF141619),
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.only(
            top: 80,
            left: 20,
            right: 20,
          ),
          decoration: BoxDecoration(color: Color(0xFF141619)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_outlined, color: Color(0xFF8A929A)),
                  ),
                  Spacer(),
                  Text(
                    'Покупка $crypto',
                    style: TextStyle(
                      color: Color(0xFFEDF7FF),
                      fontSize: 16.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.h),
              BuySellConverterField(
                isBuy: true,
                unitCost: unitCost,
                price: cost,
                fiat: fiat,
                crypto: crypto,
              ),
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: () async {
                  int? newIndex = await showModalBottomSheet<int>(
                    context: context,
                    builder: (BuildContext context) {
                      return OrdersBottomSheet(
                        requisites: _requisites,
                        title: 'Выберите Реквизиты',
                        searchText: "Поиск монет",
                      );
                    },
                  );
                  print('provkerka $_requisites');

                  if (newIndex != null && newIndex < _requisites.length) {
                    setState(() {
                      selectedIndex = newIndex;
                      requisite = _requisites[selectedIndex!];
                      comment = orderDetails['requisites'][selectedIndex!]['comment'];
                    });
                  }
                },
                child: Container(
                  width: 350.w,
                  height: 56.h,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: ShapeDecoration(
                    color: Color(0xFF272D35),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _requisites[selectedIndex ?? 0],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF8A929A),
                          fontSize: 14.sp,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down_outlined, color: Color(0xFF8A929A)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              BuySellField(
                isBuy: true,
                hint_txt: "Я заплачу",
                fiat: fiat,
                textController: takerController,
                maxLimit: double.parse(upper!),
                minLimit: double.parse(lower!),
              ),
              SizedBox(height: 10.h),
              BuySellField(
                isBuy: true,
                hint_txt: "Я получу",
                fiat: crypto,
                textController: _makerController,
                maxLimit: double.parse(upper) / usdToRubRate,
                minLimit: double.parse(lower) / usdToRubRate,
              ),
              SizedBox(height: 10.h),
              BuySellButton(
                txt: "Купить",
                isBuy: true,
                onTap: () async {
                  try {
                    final orderInfoProvider = Provider.of<OrderInfoProvider>(context, listen: false);
                    orderInfoProvider.amount = takerController.text.toString();
                    orderInfoProvider.requisiteId = _requisitesId[selectedIndex!];
                    orderInfoProvider.sellerBank = _requisites[selectedIndex!];
                    orderInfoProvider.requisite = requisite;
                    orderInfoProvider.orderId = widget.orderId;
                    orderInfoProvider.sellerCurrency = fiat;
                    orderInfoProvider.comment = comments;
                    orderInfoProvider.makerCurrency = crypto;

                    final dealData = {
                      "amount": _makerController.text,
                      "requisite_id": orderInfoProvider.requisiteId,
                    };

                    print(orderInfoProvider.requisiteId);

                    final dealProvider = Provider.of<DealProvider>(context, listen: false);
                    final response = await dealProvider.startDeal(widget.orderId!, dealData);

                    if (response['data'] != null && response['data']['deal_id'] != null) {
                      String dealId = response['data']['deal_id'];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BuyExtended2(
                            dealNumber: '11123',
                            onPressed: (context) {},
                            deal_id: dealId,
                          ),
                        ),
                      );
                    } else {
                      // Handle error case, for example show a snackbar with the error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(response['error']['message'] ?? 'Error creating deal')),
                      );
                    }
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        backgroundColor: Color(0xFF272D35),
                        surfaceTintColor: Colors.transparent,
                        title: Text("Error"),
                        content: Text("Failed to start deal: ${e.toString()}", style: TextStyle(color: Color(0xFF8A929A))),
                        actions: [
                          TextButton(
                            child: Text("OK", style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 20.h),
              Text(
                'Способ оплаты',
                style: TextStyle(
                  color: Color(0xFFEDF7FF),
                  fontSize: 18.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                banks.join(', '),
                style: TextStyle(
                  color: Color(0xFF8A929A),
                  fontSize: 14.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                width: 350.w,
                height: 1.50.h,
                color: Color(0xFF1D2126),
              ),
              SizedBox(height: 20.h),
              Text(
                'Условия сделки',
                style: TextStyle(
                  color: Color(0xFFEDF7FF),
                  fontSize: 18.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                comments ?? '',
                style: TextStyle(
                  color: Color(0x7FEDF7FF),
                  fontSize: 14.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  String formatLimit(String limit) {
    return limit.length > 10 ? limit.substring(0, 10) : limit;
  }
}