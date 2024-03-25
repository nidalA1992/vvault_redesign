import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart'; // Make sure you have this import for SVG icons

class OrdersBottomSheet extends StatefulWidget {
  final List<String> options;
  final String title;
  final String searchText;

  const OrdersBottomSheet({
    Key? key,
    required this.options,
    required this.searchText,
    this.title = 'Выберите опцию',
  }) : super(key: key);

  @override
  State<OrdersBottomSheet> createState() => _OrdersBottomSheetState();
}

class _OrdersBottomSheetState extends State<OrdersBottomSheet> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 1.2,
      child: Container(
        padding: EdgeInsets.only(
          top: 20.h,
          left: 20.w,
          right: 20.w,
          bottom: 30.h,
        ),
        decoration: ShapeDecoration(
          color: Color(0xFF1D2126),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                color: Color(0x7FEDF7FF),
                fontSize: 16.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              width: 349.68.w,
              height: 33.17.h,
              decoration: ShapeDecoration(
                color: Color(0xFF3E4349),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
              ),
              child: Row(
                children: [
                  SvgPicture.asset("assets/search_icon.svg"), // Ensure this path is correct
                  SizedBox(width: 10.w),
                  Text(
                    widget.searchText,
                    style: TextStyle(
                      color: Color(0x7FEDF7FF),
                      fontSize: 14.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView.builder(
                itemCount: widget.options.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                          Navigator.pop(context, widget.options[index]);
                        },
                        child: Container(
                          width: 350.w,
                          height: 50.h,
                          padding: EdgeInsets.symmetric(horizontal: 20.h),
                          decoration: ShapeDecoration(
                            color: selectedIndex == index ? Color(0xFF1A283C) : Color(0xFF21262D),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          ),
                          child: Row(
                            children: [
                              Text(
                                widget.options[index],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              if (selectedIndex == index) ...[
                                Icon(Icons.check, color: Colors.white,)
                              ]
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h,)
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}