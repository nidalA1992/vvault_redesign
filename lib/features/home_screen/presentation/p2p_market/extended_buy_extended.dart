import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/home_screen.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_banks.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_converter.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_field.dart';
import 'package:vvault_redesign/features/shared/ui_kit/timer.dart';

class BuyExtended2 extends StatefulWidget {
  final String dealNumber;
  final Function(BuildContext)? onPressed;
  final String sellerAmount;
  final String sellerLogin;
  final String sellerCurrency;

  const BuyExtended2({
    Key? key,
    required this.dealNumber,
    required this.onPressed,
    required this.sellerAmount,
    required this.sellerLogin,
    required this.sellerCurrency
  }) : super(key: key);

  @override
  _BuyExtended2State createState() => _BuyExtended2State();
}

class _BuyExtended2State extends State<BuyExtended2> {
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
                  price: "363 928",
                  currency: "RUB",
                  onPressed: (context) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  bank_requis: "6529 0736 9087 1639",
                  comment: "Куча слов про сделку я не работаю со скамерами и прочими говнюками!"
              ),
              SizedBox(height: 20.h,),
              ExpansionTile(
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
                  Text(
                    'Количество: ${widget.sellerAmount} ${widget.sellerCurrency}',
                    style: TextStyle(
                      color: Color(0xFFEDF7FF),
                      fontSize: 14.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Продавец: ${widget.sellerLogin}',
                    style: TextStyle(
                      color: Color(0xFFEDF7FF),
                      fontSize: 14.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ],
          )
      ),
    );
  }
}
