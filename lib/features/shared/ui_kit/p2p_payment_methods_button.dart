import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMethodsButton extends StatelessWidget {
  final String txt;

  const PaymentMethodsButton({Key? key, required this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 167.54.w,
      height: 30.h,
      decoration: ShapeDecoration(
        color: Color(0xFF2D3237),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            txt,
            style: TextStyle(
              color: Color(0xFF959DA4),
              fontSize: 12.sp,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
