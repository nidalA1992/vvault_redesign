import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuySellButton extends StatelessWidget {
  final String txt;
  final bool isBuy;
  final Function()? onTap;
  const BuySellButton({Key? key, required this.txt, required this.isBuy, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isBuy ? onTap : onTap,
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
