import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final bool isHidden;
  final bool isEditable;
  final bool isRequisite;
  final TextEditingController? controller;
  final Function(BuildContext)? onPressed;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.isHidden = true,
    this.isEditable = false,
    this.isRequisite = false,
    this.onPressed,
    this.controller,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isHidden;

  @override
  void initState() {
    super.initState();
    _isHidden = widget.isHidden;
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
      height: widget.isRequisite ? 54.h : 60.h,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.50.w, color: const Color(0xFF262C35)),
            borderRadius: BorderRadius.circular(5.r),
          ),
          color: widget.isRequisite ? const Color(0xFF1D2126) : Colors.transparent
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              obscureText: _isHidden,
              style: TextStyle(
                color: const Color(0xFFEDF7FF),
                fontSize: 16.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: const Color(0xFFEDF7FF).withOpacity(0.5),
                  fontSize: 16.sp,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (widget.isEditable) ...[
            IconButton(
              icon: SvgPicture.asset("assets/edit.svg"),
              onPressed: () {
                if (widget.onPressed != null) {
                  widget.onPressed!(context);
                }
              },
            ),
          ] else if (widget.isHidden) ...[
            IconButton(
              icon: Icon(
                _isHidden ? Icons.visibility_off : Icons.visibility,
                color: const Color(0x7FEDF7FF),
              ),
              onPressed: _toggleVisibility,
            ),
          ],
        ],
      ),
    );
  }
}
