

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/home_screen.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/confirmed_deal_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/deal_canceled_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/deal_from_order/deal_from_order_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/order_info/order_info_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/transaction_complete_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_banks.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_converter.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_field.dart';
import 'package:vvault_redesign/features/shared/ui_kit/timer.dart';

import '../../../shared/ui_kit/confirmation_window.dart';
import 'provider/notify_deal/notify_deal_provider.dart';
import 'provider/orders_list_provider.dart';

class BuyExtended2 extends StatefulWidget {
  final String dealNumber;
  final Function(BuildContext)? onPressed;
  final String deal_id;
  const BuyExtended2({
    Key? key,
    required this.dealNumber,
    required this.onPressed,
    required this.deal_id
  }) : super(key: key);

  @override
  _BuyExtended2State createState() => _BuyExtended2State();
}

class _BuyExtended2State extends State<BuyExtended2> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context, listen: false);

    final orderInfoProvider = Provider.of<OrderInfoProvider>(context, listen: false);
    var orderProvider = Provider.of<OrderProvider>(context, listen: false);
    String? login = orderProvider.login;
    String? sellerAmount = orderInfoProvider.amount;
    String? sellerLogin = orderInfoProvider.sellerLogin;
    String? sellerCurrency = orderInfoProvider.sellerCurrency;
    String? requisiteId = orderInfoProvider.requisiteId;
    String? sellerBank = orderInfoProvider.sellerBank;
    String? requisite = orderInfoProvider.requisite;
    String? comment = orderInfoProvider.comment;
    String? orderId = orderInfoProvider.orderId;
    String? crypto = orderInfoProvider.makerCurrency;
    final dealProvider = Provider.of<DealProvider>(context, listen: false);


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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap: () => widget.onPressed!(context),
                        child: Icon(Icons.arrow_back_outlined, color: Color(0xFF8A929A),)
                    ),
                    Spacer(),
                    Text(
                      'Сделка #${widget.dealNumber}',
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
                Row(
                  children: [
                    SizedBox(
                      width: 185.15.w,
                      child: Text(
                        'Завершите оплату в течение ',
                        style: TextStyle(
                          color: Color(0xFFEDF7FF),
                          fontSize: 18.sp,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    CountdownTimer()
                  ],
                ),
                SizedBox(height: 20.h,),
                ExtendableBanksList(
                    banks: ["$sellerBank"],
                    price: sellerAmount!,
                    currency: "${sellerCurrency}",
                    onPressed: (context) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                    },
                    bank_requis: "${requisite}",
                    comment: comment!
                ),
                Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent, ),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    title: Text(
                      'Информация о сделке',
                      style: TextStyle(
                        color: Color(0x7FEDF7FF),
                        fontSize: 12.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Icon(
                      isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: Color(0x7FEDF7FF),
                    ),
                    onExpansionChanged: (bool expanding) => setState(() => isExpanded = expanding),
                    children: [
                      Align(
                        alignment:Alignment.centerLeft,
                        child: Text(
                          'Количество: ${sellerAmount} ${sellerCurrency}',
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Продавец: ${login}',
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
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
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h,),
                Text(
                 comment,
                  style: TextStyle(
                    color: Color(0x7FEDF7FF),
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 60.h,),
                CustomButton(text: "Платёж выполнен",
                    onPressed: (context) {
                      ConfirmationWindow(
                        content: 'Вы точно перевели деньги по указанным реквизитам?',
                        confirmButtonText: 'Подтвердить',
                        cancelButtonText: 'Отмена',
                        onConfirm: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionCompleteScreen(cost: sellerAmount, dealId: widget.deal_id!,)));
                          notificationProvider.notifyTransfer(dealProvider.dealId!);
                        },
                      ).showConfirmationDialog(context);
                    },
                    clr: Color(0xFF0066FF)),
                SizedBox(height: 20.h,),
                GestureDetector(
                  onTap: () {
                    ConfirmationWindow(
                      content: 'Вы точно хотите отменить сделку?',
                      confirmButtonText: 'Подтвердить',
                      cancelButtonText: 'Отмена',
                      onConfirm: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CanceledDealPage()));
                      },
                    ).showConfirmationDialog(context);
                  },
                  child: Center(
                    child: Text(
                      'Отменить',
                      style: TextStyle(
                        color: Color(0xFFEDF7FF),
                        fontSize: 14.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h,)
              ],
            ),
          )
      ),
    );
  }
}
