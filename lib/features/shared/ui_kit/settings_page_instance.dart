import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsPageInstance extends StatelessWidget {
  final String icon_path;
  final String txt;
  final Function(BuildContext) onPressed;

  const SettingsPageInstance({Key? key, required this.icon_path, required this.onPressed,  required this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(context),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(icon_path),
              SizedBox(width: 10.w,),
              Text(
                txt,
                style: TextStyle(
                  color: txt == "Выход" ? Color(0xFFE93349) : Color(0xFF8A929A),
                  fontSize: 18.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          SizedBox(height: 20.h,),
          Container(
            width: 350.w,
            height: 1.50.h,
            color: Color(0xFF1D2126),
          ),
        ],
      ),
    );
  }
}
