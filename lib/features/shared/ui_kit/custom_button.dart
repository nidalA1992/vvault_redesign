import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final String img_path;
  final Function(BuildContext) onPressed;

  const CustomButton({Key? key, required this.text, required this.onPressed, this.img_path = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(context),
      child: Container(
        width: 350.w,
        height: 60.h,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        decoration: ShapeDecoration(
          color: Color(0xFF0066FF),
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
                Image.asset(img_path),
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
      ),
    );
  }
}

/*
usage:
CustomButton(
  text: 'Button Text',
  img_path: 'assets/icons/plus.png',
  color: Colors.blue,
  onPressed: (context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewAnnouncementPage(argumentHere),
      ),
    );
  },
)
*/
