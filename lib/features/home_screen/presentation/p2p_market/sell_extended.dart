import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/extended_sell_extended.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/deal_from_order/deal_from_order_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/get_my_requisites/my_requisite.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/get_my_requisites/my_requisite_provider.dart';
import 'package:vvault_redesign/features/shared/ui_kit/my_orders/modal_bottom_sheet.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_converter.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_field.dart';

class SellExtended extends StatefulWidget {
  final String? fiat;
  final String? crypto;
  final String? cost;
  final List<dynamic> banks;
  final String? comments;
  final String? unitCost;
  final String? login;
  final String? lower;
  final String orderId;

  SellExtended({
    super.key,
    required this.fiat,
    required this.crypto,
    required this.banks,
    required this.comments,
    required this.unitCost,
    required this.cost,
    required this.login,
    required this.lower,
    required this.orderId,
  });

  @override
  State<SellExtended> createState() => _SellExtendedState();
}

class _SellExtendedState extends State<SellExtended> {
  TextEditingController makerController = TextEditingController();
  TextEditingController takerController = TextEditingController();
  double usdToRubRate = 93.50;
  bool isTakerActive = false;
  bool isMakerActive = false;
  String mySelectedRequisite = '';

  String selectedRequisiteId = '';
  String selectedPaymentMethod = "Выберите способ оплаты";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      takerController.addListener(_onTakerChanged);
      makerController.addListener(_onMakerChanged);
      Provider.of<RequisitesProvider>(context, listen: false).fetchRequisites();
    });
  }

  void _onTakerChanged() {
    if (isMakerActive) return;
    isTakerActive = true;
    double takerValue = double.tryParse(takerController.text) ?? 0.0;
    double makerValue = takerValue / usdToRubRate;
    makerController.text = makerValue.toStringAsFixed(2);
    isTakerActive = false;
  }

  void _onMakerChanged() {
    if (isTakerActive) return;
    isMakerActive = true;
    double makerValue = double.tryParse(makerController.text) ?? 0.0;
    double takerValue = makerValue * usdToRubRate;
    takerController.text = takerValue.toStringAsFixed(2);
    isMakerActive = false;
  }

  @override
  void dispose() {
    takerController.dispose();
    makerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fetch requisites from provider
    List<MyRequisite> requisites = Provider.of<RequisitesProvider>(context).requisites;

    // Debugging print
    print('Requisites in build: $requisites');

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
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
                  'Продажа ${widget.crypto}',
                  style: TextStyle(
                    color: Color(0xFFEDF7FF),
                    fontSize: 16.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            BuySellConverterField(
              isBuy: false,
              price: '${widget.cost}',
              fiat: widget.crypto,
              crypto: widget.fiat,
              unitCost: widget.unitCost,
            ),
            SizedBox(height: 10.h),
            GestureDetector(
              onTap: () async {
                final chosenBank = await showModalBottomSheet<String>(
                  context: context,
                  builder: (BuildContext context) {
                    return OrdersBottomSheet(
                      options: requisites.map((requisite) => requisite.bank).toList(),
                      title: 'Выберите банк',
                      searchText: "Поиск банка",
                      onSelected: (selectedBank) {
                        var selectedRequisite = requisites.firstWhere(
                              (requisite) => requisite.bank == selectedBank,
                          orElse: () => MyRequisite(bank: '', comment: '', id: '', requisite: '', userId: ''),
                        );
                        setState(() {
                          selectedPaymentMethod = selectedRequisite.bank;
                          selectedRequisiteId = selectedRequisite.id;
                          mySelectedRequisite = selectedRequisite.requisite;
                          print('Selected Requisite: $selectedRequisite'); // Debugging print
                        });
                        Navigator.pop(context, selectedBank);
                      },
                    );
                  },
                );
                if (chosenBank != null) {
                  setState(() {
                    selectedPaymentMethod = chosenBank;
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
                      selectedPaymentMethod,
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
              fiat: '${widget.fiat}',
              textController: makerController,
              minLimit: double.parse(widget.lower!) / usdToRubRate,
              maxLimit: double.parse(widget.unitCost!) / usdToRubRate,
            ),
            SizedBox(height: 10.h),
            BuySellField(
              isBuy: true,
              hint_txt: "Я получу",
              fiat: '${widget.crypto}',
              textController: takerController,
              minLimit: double.parse(widget.lower!),
              maxLimit: double.parse(widget.unitCost!),
            ),
            SizedBox(height: 10.h),
            BuySellButton(
              onTap: () async {
                print('Selected Requisite ID: $selectedRequisiteId'); // Debugging print

                final dealData = {
                  "amount": takerController.text,
                  "requisite_id": selectedRequisiteId,
                };
                final dealProvider = Provider.of<DealProvider>(context, listen: false);
                await dealProvider.startDeal(widget.orderId, dealData);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SellExtended2(
                      dealNumber: "174573",
                      onPressed: (context) {
                        Navigator.pop(context);
                      },
                      sellerAmount: makerController.text,
                      sellerCurrency: "USDT",
                      sellerLogin: widget.login!,
                      bank: selectedPaymentMethod,
                      requisite: mySelectedRequisite,
                      comment: widget.comments!,
                      makerAmount: takerController.text,
                      deal_id: dealProvider.dealDetails['deal_id'],
                    ),
                  ),
                );
              },
              txt: "Продать",
              isBuy: false,
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
              widget.banks.join(", "),
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
              widget.comments!,
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
