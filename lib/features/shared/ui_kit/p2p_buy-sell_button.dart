import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/extended_buy_extended.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/extended_sell_extended.dart';

import '../../home_screen/presentation/p2p_market/provider/deal_from_order/deal_from_order_provider.dart';

class BuySellButton extends StatelessWidget {
  final String txt;
  final bool isBuy;
  final String sellerCurrency;
  final String sellerLogin;
  final String amount;
  final String requisiteId;
  final String sellerBank;
  final String requisite;
  final String comment;
  final String orderId;
  const BuySellButton({Key? key, required this.txt, required this.isBuy, required this.sellerCurrency, required this.sellerLogin, required this.amount, required this.requisiteId, required this.sellerBank, required this.requisite, required this.comment, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dealProvider = Provider.of<DealProvider>(context, listen: false);
    final dealData = {
      "amount": amount,
      "requisite_id": requisiteId, // ID выбранного реквизита
    };
    return GestureDetector(
      onTap: () {
        isBuy ? {
        dealProvider.startDeal(orderId, dealData),
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BuyExtended2(
                  dealNumber: "174573",
                  onPressed: (context) {
                    Navigator.pop(context);
                  },
                  sellerAmount: "$amount",
                  sellerCurrency: "$sellerCurrency",
                  sellerLogin: "$sellerLogin",
                  requisiteId: '$requisiteId', sellerBank: '${sellerBank}',
                  requisite: '$requisite',
                  comment: '$comment',
                  orderId: '$orderId}',
                )
            )
        )
      } : Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SellExtended2(
                  dealNumber: "174573",
                  onPressed: (context) {
                    Navigator.pop(context);
                  },
                  sellerAmount: "6 500",
                  sellerCurrency: "USDT",
                  sellerLogin: "umpalumpa137",
                )
            )
        );
      },
      child: Container(
        width: 349.w,
        height: 44.h,
        decoration: ShapeDecoration(
          color: isBuy ? Color(0xFF14A769) : Color(0xFFCD2D30),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              txt,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
