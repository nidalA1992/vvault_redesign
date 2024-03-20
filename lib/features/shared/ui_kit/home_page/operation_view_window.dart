import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OperationViewWindow {
  final String content;
  final String confirmButtonText;
  final String cancelButtonText;
  final void Function() onConfirm;

  OperationViewWindow({
    required this.content,
    required this.confirmButtonText,
    required this.cancelButtonText,
    required this.onConfirm,
  });

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF1D2126),
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          content: SizedBox(
            height: 200.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFEDF7FF),
                    fontSize: 16.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 24.h),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    onConfirm();
                  },
                  child: Container(
                    width: 248.68.w,
                    height: 45.h,
                    decoration: ShapeDecoration(
                      color: Color(0xFF0066FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.88.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          confirmButtonText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 16.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h,),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 248.68.w,
                    height: 45.h,
                    decoration: ShapeDecoration(
                      color: Color(0x330066FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.88.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          cancelButtonText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 16.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
