import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/extended_buy_extended.dart';

class BuySellButton extends StatelessWidget {
  final String txt;
  final bool isBuy;

  const BuySellButton({Key? key, required this.txt, required this.isBuy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BuyExtended2(
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
