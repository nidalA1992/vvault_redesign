import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/update_order_activity_provider.dart';

class OrderInstance extends StatefulWidget {
  final String price;
  final String titleCurrency;
  final String priceCurrency;
  final List<dynamic> banks;
  final bool isActive;
  final bool isBuy;
  final String lowerLimit;
  final String upperLimit;
  final String? comment;
  final String? orderID;
  final Function(BuildContext)? onPressed;

  OrderInstance({
    Key? key,
    required this.price,
    required this.priceCurrency,
    required this.onPressed,
    required this.banks,
    required this.isActive,
    required this.titleCurrency,
    required this.isBuy,
    required this.lowerLimit,
    required this.upperLimit,
    this.comment,
    this.orderID
  }) : super(key: key);

  @override
  _OrderInstanceState createState() => _OrderInstanceState();
}

class _OrderInstanceState extends State<OrderInstance> {
  int selectedIndex = 0;
  late bool isActive;

  @override
  void initState() {
    super.initState();
    isActive = widget.isActive;
  }

  @override
  Widget build(BuildContext context) {
    final updateOrderActivityProvider = Provider.of<UpdateOrderActivityProvider>(context, listen: false);

    return Column(
      children: [
        SizedBox(height: 10.h,),
        Row(
          children: [
            Text(
              widget.isBuy ? 'Покупка ${widget.titleCurrency}' : 'Продажа ${widget.titleCurrency}',
              style: TextStyle(
                color: widget.isBuy ? Color(0xFF05CA77) : Color(0xFFCD2E30),
                fontSize: 18.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 5.w,),
            GestureDetector(
              onTap: () => widget.onPressed!(context),
                child: SvgPicture.asset("assets/edit_icon.svg")
            ),
            Spacer(),
            Container(
              width: 104.w,
              height: 34.h,
              decoration: ShapeDecoration(
                color: isActive ? Color(0x3305CA77) : Color(0xFF941B29),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    isActive ? 'Активно' : 'Неактивно',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isActive ? Color(0xFF05CA77) : Colors.white,
                      fontSize: 14.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 15.h,),
        Row(
          children: [
            Text(
              'Цена ордера',
              style: TextStyle(
                color: Color(0xFF8A929A),
                fontSize: 16.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Text(
              formatLimit(widget.price),
              style: TextStyle(
                color: Color(0xFFEDF7FF),
                fontSize: 16.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 5.w,),
            Text(
              widget.priceCurrency,
              style: TextStyle(
                color: Color(0xFF8A929A),
                fontSize: 14.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        SizedBox(height: 15.h,),
        Row(
          children: [
            Text(
              'Лимит',
              style: TextStyle(
                color: Color(0xFF8A929A),
                fontSize: 16.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Text(
              '${formatLimit(widget.lowerLimit)} ${widget.priceCurrency} — ${formatLimit(widget.upperLimit)} ${widget.priceCurrency}',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFFEDF7FF),
                fontSize: 14.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        SizedBox(height: 15.h,),
        Row(
          children: [
            Text(
              'Оплата',
              style: TextStyle(
                color: Color(0xFF8A929A),
                fontSize: 16.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Text(
              widget.banks.join(', '),
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFFEDF7FF),
                fontSize: 14.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          children: [
            Transform.scale(
              scale: 0.8,
              child: CupertinoSwitch(
                value: isActive!,
                onChanged: (bool value) {
                  setState(() {
                    isActive = value;
                    final orderData = {
                      "active": value
                    };
                    print("order id karap otrm ${widget.orderID.toString()}");
                    updateOrderActivityProvider.updateOrderActivity(orderData, widget.orderID.toString());
                  });
                },
                activeColor: Color(0xFF0066FF),
              ),
            ),
            Text(
             isActive ? 'Выключить' : "Включить",
              style: TextStyle(
                color: Color(0xFF8A929A),
                fontSize: 16.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Container(
          width: 350.w,
          height: 1.50.h,
          color: Color(0xFF1D2126),
        ),
      ],
    );
  }

  String formatLimit(String limit) {
    return limit.length > 10 ? limit.substring(0, 10) : limit;
  }

}