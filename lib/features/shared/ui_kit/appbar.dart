import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget {
  final String img_path;
  final String username;
  final String? id_user;
  final bool isP2P;
  final Function(BuildContext)? onPressedNotifications;
  final Function(BuildContext)? onPressedOrders;

  const CustomAppBar({Key? key, this.isP2P = false, required this.img_path, required this.username, this.id_user, this.onPressedNotifications, this.onPressedOrders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.h,
          decoration: ShapeDecoration(
            image: DecorationImage(
              image: AssetImage("assets/avatar.png"),
              fit: BoxFit.cover,
            ),
            shape: OvalBorder(),
          ),
        ),
        SizedBox(width: 15.w,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              username,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFEDF7FF),
                fontSize: 14.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
            if (id_user != null) ... [
              SizedBox(height: 5.h,),
              Text(
                'ID ${id_user}',
                style: TextStyle(
                  color: Color(0xFF80868C),
                  fontSize: 11.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              )
            ]
          ],
        ),
        Spacer(),
        if (isP2P) ... [
          GestureDetector(
              onTap: () => onPressedOrders!(context),
              child: SvgPicture.asset("assets/requisites_icon.svg")
          ),
        ],
        SizedBox(width: 15.w,),
        GestureDetector(
            onTap: () => onPressedNotifications!(context),
            child: SvgPicture.asset("assets/bell_icon.svg"),
        ),
        SizedBox(width: 15.w,),
      ],
    );
  }
}
