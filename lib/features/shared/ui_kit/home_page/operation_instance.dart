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
      case 'incoming':
        return Color(0xFF05CA77);
      case 'outgoing':
        return Color(0xFFE93349);
      default:
        return Color(0xFF0066FF);
    }
  }

  String _getImagePath(String type) {
    switch (type) {
      case 'incoming':
        return "assets/arrow-right.svg";
      case 'outgoing':
        return "assets/arrow-left.svg";
      case 'buy':
        return "assets/download_icon.svg";
      case 'sell':
        return "assets/vyvesti_icon.svg";
      default:
        return "something is wrong";
    }
  }

  String _getTitle(String type) {
    switch (type) {
      case 'incoming':
        return "Входящий перевод";
      case 'outgoing':
        return "Исходящий перевод";
      case 'buy':
        return "Покупка криптовалюты";
      case 'sell':
        return "Продажа криптовалюты";
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
              width: 30.w,
              height: 30.h,
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
              quantity,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFFEDF7FF),
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
      ],
    );
  }
}
