import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OperationInstance extends StatelessWidget {
  final String type;
  final String username;
  final String quantity;
  final String currency;

  const OperationInstance({
    Key? key,
    required this.type,
    required this.username,
    required this.quantity,
    required this.currency,
  }) : super(key: key);

  Color _getColorFromType(String type) {
    switch (type) {
      case 'deal':
        return Color(0xFFE93349);
      case 'payment':
        return Color(0xFFE93349);
      case 'exchange':
        return Color(0xFF14A769);
      case 'withdraw':
        return Color(0xFF0066FF);
      case 'deposit':
        return Color(0xFF0066FF);
      case 'transfer':
        return Color(0xFFE93349);
      case 'freezing':
        return Color(0xFFE93349);
      case 'payment_deal':
        return Color(0xFFE93349);
      default:
        return Color(0xFF0066FF);
    }
  }

  String _getImagePath(String type) {
    switch (type) {
      case 'deal':
        return "assets/users.svg";
      case 'payment':
        return "assets/download_icon.svg";
      case 'exchange':
        return "assets/vyvesti_icon.svg";
      case 'withdraw':
        return "assets/ver2_upload.svg";
      case 'deposit':
        return "assets/download_icon.svg";
      case 'transfer':
        return "assets/arrow-right.svg";
      case 'freezing':
        return "assets/vyvesti_icon.svg";
      case 'payment_deal':
        return "assets/download_icon.svg";
      default:
        return "something is wrong";
    }
  }

  String _getTitle(String type) {
    switch (type) {
      case 'deal':
        return "Покупка криптовалюты Р2Р";
      case 'payment':
        return "Оплата через Senpay";
      case 'exchange':
        return "assets/vyvesti_icon.svg";
      case 'withdraw':
        return "Вывод средств через Blockchain";
      case 'deposit':
        return "Поступление через Blokchain";
      case 'transfer':
        return "Исходящий перевод";
      case 'freezing':
        return "assets/vyvesti_icon.svg";
      case 'payment_deal':
        return "Платеж через SenPay";
      default:
        return "something is wrong";
    }
  }

  @override
  Widget build(BuildContext context) {
    Color clr = _getColorFromType(type);
    String img_path = _getImagePath(type);
    String title = _getTitle(type);

    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 35.w,
              height: 35.h,
              decoration: ShapeDecoration(
                color: clr,
                shape: CircleBorder(),
              ),
              child: Center(
                child: SvgPicture.asset(img_path),
              ),
            ),
            SizedBox(width: 10.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Color(0x7FEDF7FF),
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (type == 'incoming' || type == 'outgoing') ... [
                  Text(
                    username,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFEDF7FF),
                      fontSize: 14.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ]
              ],
            ),
            Spacer(),
            Text(
              formatLimit(quantity),
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFFEDF7FF),
                fontSize: 16.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 3.w,),
            Text(
              currency,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0x7FEDF7FF),
                fontSize: 12.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
        SizedBox(height: 10.h,),
        Container(
          width: 350.w,
          height: 1.50.h,
          color: Color(0xFF1D2126),
        ),
        SizedBox(height: 10.h,)
      ],
    );
  }

  String formatLimit(String limit) {
    return limit.length > 10 ? limit.substring(0, 5) : limit;
  }

}
