import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequisiteInstance extends StatelessWidget {
  final String bankName;
  final List<String> requisites;
  final Function(BuildContext) onPressed;

  const RequisiteInstance({Key? key, required this.bankName, required this.onPressed, required this.requisites}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          bankName,
          style: TextStyle(
            color: Color(0xFFEDF7FF),
            fontSize: 18.sp,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 20.h),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: requisites.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () => onPressed(context),
                  child: Container(
                    width: 350.w,
                    height: 54.h,
                    padding: EdgeInsets.all(17.r),
                    decoration: ShapeDecoration(
                      color: Color(0xFF1D2126),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)), // Use ScreenUtil for borderRadius if needed
                    ),
                    child: Row(
                      children: [
                        Text(
                          requisites[index],
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 16.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_right_alt_outlined, color: Color(0x7FEDF7FF),)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h,)
              ],
            );
          },
        ),
        SizedBox(height: 20.h,)
      ],
    );
  }
}
