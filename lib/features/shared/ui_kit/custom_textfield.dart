import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/home_screen.dart';

import '../../../main.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final bool isHidden;
  final bool isEditable;
  final TextEditingController? controller;
  final Function(BuildContext)? onPressed;
  
  const CustomTextField({Key? key,
    required this.hintText,
    this.isHidden = true,
    this.isEditable = false,
    this.onPressed,
    this.controller,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isHidden;
  late bool _isEditable;
  late bool _isHiddenForBuild;

  @override
  void initState() {
    super.initState();
    _isHidden = widget.isHidden;
    _isEditable = widget.isEditable;
    _isHiddenForBuild = widget.isHidden;
  }

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370.w,
      height: 60.h,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.50.w, color: Color(0xFF262C35)),
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              obscureText: _isHidden,
              style: TextStyle(
                color: Color(0xFFEDF7FF),
                fontSize: 16.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: Color(0xFFEDF7FF).withOpacity(0.5), // Lighter hint text color
                  fontSize: 16.sp,
                ),
                border: InputBorder.none, // No border
                contentPadding: EdgeInsets.zero, // Default padding is fine
              ),
            ),
          ),
          if (_isEditable) ... [
            IconButton(
              icon: SvgPicture.asset("assets/edit.svg"),
              onPressed: () {
                Get.find<NavBarVisibilityController>().hide();
                widget.onPressed!(context);
              }
            ),
          ] else if (_isHiddenForBuild)
          IconButton(
            icon: Icon(
              _isHidden ? Icons.visibility_off : Icons.visibility,
              color: Color(0x7FEDF7FF), // Icon color
            ),
            onPressed: _toggleVisibility,
          ),
        ],
      ),
    );
  }
}

