import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/order_info/order_info_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/user_requisite_list/user_requisite_provider.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/my_orders/modal_bottom_sheet.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_converter.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_field.dart';

import 'extended_buy_extended.dart';
import 'provider/deal_from_order/deal_from_order_provider.dart';
import 'provider/orders_list_provider.dart';

class BuyExtended extends StatefulWidget {

  String? orderId;

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

  void _loadData(){
    Provider.of<OrderInfoProvider>(context, listen: false).loadOrderDetails(widget.orderId!);
  }

  void _onTakerChanged() {
    if (isMakerActive) return; // Если активен maker, ничего не делаем

    double takerValue = double.tryParse(takerController.text) ?? 0.0;
    double makerValue = takerValue / usdToRubRate;
    _makerController.text = makerValue.toString();
  }

  void _onMakerChanged() {
    if (isTakerActive) return; // Если активен taker, ничего не делаем

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


  List<String> _requisites = [];
  List<String> _requisitesId = [];
  String requisite = '';
  String comment = '';
  int? selectedIndex = 0;


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

    final orderDetails = Provider.of<OrderInfoProvider>(context).orderDetails;
    _requisites.add(orderDetails['requisites'][0]['bank']);
    _requisitesId.add(orderDetails['requisites'][0]['id']);
    requisite = orderDetails['requisites'][0]['requisite'];
    comment = orderDetails['requisites'][0]['comment'];


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
                      child: Icon(Icons.arrow_back_outlined, color: Color(0xFF8A929A),)
                  ),
                  Spacer(),
                  Text(
                    'Покупка ${crypto}',
                    style: TextStyle(
                      color: Color(0xFFEDF7FF),
                      fontSize: 16.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.h,),
              BuySellConverterField(isBuy: true, unitCost: unitCost, price: cost, fiat: fiat, crypto: crypto,),
              SizedBox(height: 10.h,),
              GestureDetector(
                onTap: () async {
                  selectedIndex = await showModalBottomSheet<int>(
                    context: context,
                    builder: (BuildContext context) {
                      return OrdersBottomSheet(
                        options: _requisites,
                        title: 'Выберите Реквизиты',
                        searchText: "Поиск монет",
                        // здесь не передаем onSelected, так как используем результат showModalBottomSheet
                      );
                    },
                  );

                  if (selectedIndex != null) {
                    // Теперь у вас есть выбранный индекс, который можно использовать
                    // Например, для обновления состояния или выполнения действия на основе выбранного индекса
                    print("Выбранный индекс: $selectedIndex");
                    // Здесь вы можете использовать selectedIndex для получения информации о реквизите и его id
                    setState(() {

                      _requisites.add(orderDetails['requisites'][selectedIndex]['bank']);
                      _requisitesId.add(orderDetails['requisites'][selectedIndex]['id']);
                      requisite = orderDetails['requisites'][selectedIndex]['requisite'];
                      comment = orderDetails['requisites'][selectedIndex]['comment'];
                      // Делайте что нужно с выбранным реквизитом и его id
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
                        _requisites[selectedIndex!],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF8A929A),
                          fontSize: 14.sp,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down_outlined, color: Color(0xFF8A929A),)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h,),
              BuySellField(isBuy: true, hint_txt: "Я заплачу",fiat: fiat, textController: takerController,),
              SizedBox(height: 10.h,),
              BuySellField(isBuy: true, hint_txt: "Я получу", fiat: crypto, textController: _makerController,),
              SizedBox(height: 10.h,),
              BuySellButton(
                txt: "Купить",
                isBuy: true,
                onTap: (){
                  final orderInfoProvider = Provider.of<OrderInfoProvider>(context, listen: false);
                  orderInfoProvider.amount = takerController.text.toString();
                  orderInfoProvider.requisiteId = _requisitesId[selectedIndex!];
                  orderInfoProvider.sellerBank = _requisites[selectedIndex!];
                  orderInfoProvider.requisite = requisite;
                  orderInfoProvider.orderId = widget.orderId;
                  orderInfoProvider.sellerCurrency = fiat;
                  print(orderInfoProvider.amount);
                  orderInfoProvider.comment = comments;
                  orderInfoProvider.makerCurrency = crypto;
                  final dealData = {
                    "amount": _makerController.text,
                    "requisite_id": orderInfoProvider.requisiteId, // ID выбранного реквизита
                  };
                  final dealProvider = Provider.of<DealProvider>(context, listen: false);
                  dealProvider.startDeal(widget.orderId!, dealData);
                  dealProvider.dealId = dealProvider.dealDetails['deal_id'];
                  print(dealProvider.dealDetails['data']);
                  print('tapped');
                  print(orderInfoProvider.amount);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BuyExtended2(dealNumber: '11123', onPressed:(context){

                    }, deal_id: dealProvider.dealDetails['deal_id'],))
                  );
                },
              ),
              SizedBox(height: 20.h,),
              Text(
                'Способ оплаты',
                style: TextStyle(
                  color: Color(0xFFEDF7FF),
                  fontSize: 18.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.h,),
              Text(
                banks.join(', '),
                style: TextStyle(
                  color: Color(0xFF8A929A),
                  fontSize: 14.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20.h,),
              Container(
                width: 350.w,
                height: 1.50.h,
                color: Color(0xFF1D2126),
              ),
              SizedBox(height: 20.h,),
              Text(
                'Условия сделки',
                style: TextStyle(
                  color: Color(0xFFEDF7FF),
                  fontSize: 18.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.h,),
              Text(
                '${comments}',
                style: TextStyle(
                  color: Color(0x7FEDF7FF),
                  fontSize: 14.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          )
      ),
    );
  }
}
