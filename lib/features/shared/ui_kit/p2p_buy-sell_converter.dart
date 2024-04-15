import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuySellConverterField extends StatelessWidget {
  final String? text;
  final String img_path;
  final bool isBuy;
  final String? price;
  final String? fiat;
  final String? crypto;
  final String? unitCost;
  final Function(BuildContext)? onPressed;

  const BuySellConverterField({Key? key, this.text, this.onPressed, this.img_path = '', required this.isBuy, required this.price, this.fiat, this.crypto, this.unitCost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 349.w,
        height: 74.h,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: ShapeDecoration(
          color: Color(0xFF272D35),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  'Цена',
                  style: TextStyle(
                    color: Color(0xFF8A929A),
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                isBuy ?
                Text(
                  'Доступно к покупке',
                  style: TextStyle(
                    color: Color(0xFF8A929A),
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ) :
                Text(
                  'Доступно к продаже',
                  style: TextStyle(
                    color: Color(0xFF8A929A),
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            SizedBox(height: 5.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Opacity(
                  opacity: 0.90,
                  child: Text(
                    '${formatLimit(price.toString())}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isBuy ? Color(0xFF14A86A) : Color(0xFFCD2E30),
                      fontSize: 18.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: 5.w,),
                Text(
                  '$fiat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF8A929A),
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text(
                  '${formatLimit(unitCost.toString())}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF8A929A),
                    fontSize: 16.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 5.w,),
                Text(
                  '${crypto}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF8A929A),
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            )
          ],
        )
    );
  }

  String formatLimit(String limit) {
    return limit.length > 8 ? limit.substring(0, 8) : limit;
  }

}
