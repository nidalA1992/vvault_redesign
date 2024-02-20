import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ApiKeyInstance extends StatelessWidget {
  final String name;
  final bool isEnabled;
  final bool createdNow;
  final Function(BuildContext)? onPressed;

  const ApiKeyInstance({Key? key, required this.name, this.onPressed, required this.isEnabled, this.createdNow = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380.w,
      height: 60.h,
      padding: const EdgeInsets.all(20),
      decoration: ShapeDecoration(
        color: const Color(0xFF1D2126),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/apikey_icon.svg"),
                SizedBox(width: 15.w),
                Text(
                  name,
                  style: TextStyle(
                    color: Color(0x7FEDF7FF),
                    fontSize: 16.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          if (createdNow) ... [
            Text(
              'Новый ключ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF05CA77),
                fontSize: 12.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
          ] else
          Text(
            isEnabled ? 'Включен' : 'Отключен',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isEnabled ? const Color(0xFF05CA77) : Color(0xFFE93349),
              fontSize: 12.sp,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
