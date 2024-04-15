import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/home_screen.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/confirmed_deal_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/deal_canceled_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/confirmation_window.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_banks.dart';
import 'package:vvault_redesign/features/shared/ui_kit/timer.dart';

class DealExtended extends StatefulWidget {
  final String dealNumber;
  final String sellerAmount;
  final String buyerAmount;
  final String sellerLogin;
  final String sellerCurrency;
  final String requisiteId;
  final String comment;

  const DealExtended({
    Key? key,
    required this.dealNumber,
    required this.sellerAmount,
    required this.buyerAmount,
    required this.sellerLogin,
    required this.sellerCurrency,
    required this.requisiteId,
    required this.comment,
  }) : super(key: key);

  @override
  _DealExtendedState createState() => _DealExtendedState();
}

class _DealExtendedState extends State<DealExtended> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
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
                        onTap: () {
                          Navigator.pop(context);
                        },
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Сделка успешно завершена',
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 18.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        Text(
                          'Продано 6 500 USDT',
                          style: TextStyle(
                            color: Color(0x7FEDF7FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    SvgPicture.asset("assets/check-circle.svg")
                  ],
                ),
                SizedBox(height: 20.h,),
                ExtendableBanksList(
                    banks: ["kmfkwekf"],
                    price: "${widget.sellerAmount}",
                    currency: "${widget.sellerCurrency}",
                    onPressed: (context) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                    },
                    bank_requis: "kmfkwekf",
                    comment: widget.comment
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
                          'Количество: ${formatLimit(widget.sellerAmount)} ${widget.sellerCurrency}',
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
                          'Продавец: ${widget.sellerLogin}',
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
                  widget.comment,
                  style: TextStyle(
                    color: Color(0x7FEDF7FF),
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }

  String formatLimit(String limit) {
    return limit.length > 10 ? limit.substring(0, 10) : limit;
  }

}
