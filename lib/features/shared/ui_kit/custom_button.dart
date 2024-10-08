import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final String img_path;
  final Color clr;
  final int hgt;
  final Function(BuildContext)? onPressed;

  const CustomButton({Key? key, required this.text, this.onPressed, this.img_path = '', required this.clr, this.hgt = 60}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buttonContent = Container(
      width: 350.w,
      height: hgt.h,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: ShapeDecoration(
        color: clr,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          img_path != ''
              ? Row(
            children: [
              SvgPicture.asset(img_path, color: Colors.white, width: 24.w, height: 24.h,),
              SizedBox(width: 10.w),
            ],
          ) : Container(),
          Text(
            text,
            style: TextStyle(
              color: Color(0xFFEDF7FF),
              fontSize: 16.sp,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    if (onPressed != null) {
      return GestureDetector(
        onTap: () => onPressed!(context),
        child: buttonContent,
      );
    } else {
      return buttonContent;
    }
  }
}
