import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBarWithoutAva extends StatelessWidget {
  final String txt;
  final Function(BuildContext)? onPressedNotifications;

  const CustomAppBarWithoutAva({Key? key, required this.txt, this.onPressedNotifications}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_outlined, color: Color(0x7FEDF7FF))
        ),
        SizedBox(width: 10.w,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              txt,
              style: TextStyle(
                color: Color(0xFFEDF7FF),
                fontSize: 20.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Spacer(),
        /*
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateRequisitePage()),
              );
            },
            child: Image.asset("assets/icons/file.png")
        ), */
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
