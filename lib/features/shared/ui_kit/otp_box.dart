import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;

  const OtpBox({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 43.52.w,
      height: 50.17.h,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 2.w,
            color: focusNode.hasFocus ? Color(0xFF5669FF) : Colors.grey,
          ),
        ),
        color: Colors.transparent,
      ),
      child: Center(
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          maxLength: 1,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFEDF7FF),
            fontSize: 25.sp,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
          ),
          decoration: InputDecoration(
            counterText: '',
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.transparent,
          ),
          onChanged: onChanged, // Use the passed callback here
        ),
      ),
    );
  }
}
