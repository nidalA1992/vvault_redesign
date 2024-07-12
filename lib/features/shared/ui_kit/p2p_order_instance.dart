import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class P2Pinstance extends StatelessWidget {
  final String login;
  final String like_percentage;
  final String order_quantity;
  final String success_percentage;
  final String price;
  final String currency;
  final String lower_limit;
  final String upper_limit;
  final List<dynamic> banks;
  final bool buyOrder;
  final Function(BuildContext) onPressed;

  const P2Pinstance({
    Key? key,
    required this.login,
    required this.like_percentage,
    required this.order_quantity,
    required this.success_percentage,
    required this.price,
    required this.currency,
    required this.lower_limit,
    required this.upper_limit,
    required this.banks,
    required this.buyOrder,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedText = formatBankNames(banks);

    return Column(
      children: [
        SizedBox(height: 20.h,),
        Container(
          width: 350.w,
          height: 1.50.h,
          color: Color(0xFF1D2126),
        ),
        SizedBox(height: 20.h,),
        Row(
          children: [
            Text(
              login,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 5.w,),
            SvgPicture.asset("assets/thumbs-up.svg"),
            Text(
              like_percentage,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF05CA77),
                fontSize: 10.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Text(
              '${order_quantity} ордера | ${formatLimit(success_percentage)}% успешно',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF8A929A),
                fontSize: 10.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          children: [
            Text(
              price,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 5.w,),
            Text(
              currency,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF8A929A),
                fontSize: 12.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          children: [
            Text(
              'Лимит',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF8A929A),
                fontSize: 10.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 20.w,),
            Text(
              '${lower_limit.length > 6 ? lower_limit.substring(0, 6) : lower_limit} ${currency} - ${upper_limit.length > 6 ? upper_limit.substring(0, 6) : upper_limit} ${currency}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFEDF7FF),
                fontSize: 10.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Оплата',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF8A929A),
                    fontSize: 10.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 18.w,),
                SizedBox(
                  width: 176.w,
                  child: Text(
                    formattedText,
                    style: TextStyle(
                      color: Color(0xFFEDF7FF),
                      fontSize: 10.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
                onTap: () => onPressed(context),
                child: Container(
                  width: 101.w,
                  height: 24.h,
                  decoration: ShapeDecoration(
                    color: buyOrder ? Color(0xFF02603E) : Color(0xFF941B29),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        buyOrder ? "Купить" : "Продать",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
            ),
          ],
        ),
      ],
    );
  }

  String formatLimit(String limit) {
    if (limit == null || limit.isEmpty) return '0.00';
    try {
      double value = double.parse(limit);
      return value.toStringAsFixed(2);
    } catch (e) {
      return '0.00';
    }
  }

  String formatBankNames(List<dynamic> names) {
    final StringBuffer buffer = StringBuffer();
    for (int i = 0; i < names.length; i++) {
      if (i > 0) {
        buffer.write(', ');
        if (i % 3 == 0) {
          buffer.write('\n');
        }
      }
      buffer.write(names[i]);
    }
    return buffer.toString();
  }

}

/*
usage:
CustomButton(
  text: 'Button Text',
  img_path: 'assets/icons/plus.png',
  color: Colors.blue,
  onPressed: (context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewAnnouncementPage(argumentHere),
      ),
    );
  },
)

GestureDetector(
      onTap: () => onPressed(context),
      child: Container(
        width: 101.w,
        height: 24.h,
        decoration: ShapeDecoration(
          color: Color(0xFF02603E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      )
    )
*/
