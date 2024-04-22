import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuySellField extends StatefulWidget {
  final String? text;
  final String imgPath;
  final String hint_txt;
  final bool isBuy;
  final Function(BuildContext)? onPressed;
  final String? fiat;
  final TextEditingController textController;
  final double? minLimit;
  final double? maxLimit;
  final String? errorText;

  const BuySellField({
    Key? key,
    this.text,
    this.onPressed,
    this.imgPath = 'assets/edit_icon.svg',
    required this.hint_txt,
    required this.isBuy,
    required this.fiat,
    required this.textController,
    this.minLimit,
    this.maxLimit,
    this.errorText,
  }) : super(key: key);

  @override
  _BuySellFieldState createState() => _BuySellFieldState();
}

class _BuySellFieldState extends State<BuySellField> {
  String? currentError;

  @override
  void initState() {
    super.initState();
    widget.textController.addListener(_validateInput);
  }

  @override
  void dispose() {
    widget.textController.removeListener(_validateInput);
    super.dispose();
  }

  void _validateInput() {
    final value = double.tryParse(widget.textController.text);
    if (value == null || value < widget.minLimit! || value > widget.maxLimit!) {
      setState(() => currentError = widget.errorText ?? "От ${widget.minLimit} До ${widget.maxLimit}");
    } else {
      setState(() => currentError = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.w,
      height: 51.h,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: ShapeDecoration(
        color: Color(0xFF272D35),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.textController.text.isEmpty
              ? Row(
            children: [
              SvgPicture.asset(widget.imgPath),
              SizedBox(width: 10.w,)
            ],
          )
              : SizedBox.shrink(),
          Expanded(
            child: TextField(
              controller: widget.textController,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              style: TextStyle(
                color: Color(0xFF8A929A),
                fontSize: 14.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hint_txt,
                hintStyle: TextStyle(
                  color: Color(0xFF8A929A),
                ),
                errorText: currentError,
              ),
            ),
          ),
          Spacer(),
          Text(
            '${widget.fiat}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            height: 20.h,
            width: 1.w,
            margin: EdgeInsets.symmetric(horizontal: 10),
            color: Color(0xFF8A929A),
          ),
          GestureDetector(
            onTap: () => widget.textController.text = widget.maxLimit.toString(),
            child: Text(
              'Все',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}

