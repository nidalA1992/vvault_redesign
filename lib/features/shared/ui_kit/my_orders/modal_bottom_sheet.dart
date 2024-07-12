import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrdersBottomSheet extends StatefulWidget {
  final List<String>? options;
  final List<String>? requisites;
  final String title;
  final String searchText;
  final ValueChanged<String>? onSelected;

  OrdersBottomSheet({
    Key? key,
    this.requisites,
    this.options,
    required this.searchText,
    this.onSelected,
    this.title = 'Выберите опцию',
  }) : super(key: key);

  @override
  State<OrdersBottomSheet> createState() => _OrdersBottomSheetState();
}

class _OrdersBottomSheetState extends State<OrdersBottomSheet> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final items = widget.requisites != null && widget.requisites!.isNotEmpty
        ? widget.requisites
        : widget.options;

    final isUsingRequisites = items == widget.requisites;

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
                  SvgPicture.asset("assets/search_icon.svg"),
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
              child: items != null && items.isNotEmpty
                  ? ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final option = items[index];

                  String bank = option;
                  String requisite = "";

                  if (isUsingRequisites) {
                    final parts = option.split(':').map((e) => e.trim()).toList();
                    if (parts.length >= 2) {
                      bank = parts[0];
                      requisite = parts[1];
                    }
                  }

                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                          if (widget.onSelected != null) {
                            widget.onSelected!(option);
                          }
                        },
                        child: Container(
                          width: 350.w,
                          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
                          decoration: ShapeDecoration(
                            color: selectedIndex == index ? Color(0xFF1A283C) : Color(0xFF21262D),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bank,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (requisite.isNotEmpty)
                                Text(
                                  requisite,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h)
                    ],
                  );
                },
              )
                  : Center(
                child: Text(
                  'No options available',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
