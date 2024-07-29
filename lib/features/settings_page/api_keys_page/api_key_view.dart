import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vvault_redesign/features/settings_page/confidentiality_page/confirmation_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar_without_avatar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';

class ApiKeyView extends StatefulWidget {
  const ApiKeyView({super.key});

  @override
  State<ApiKeyView> createState() => _ApiKeyViewState();
}

class _ApiKeyViewState extends State<ApiKeyView> {
  bool _isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          decoration: BoxDecoration(color: Color(0xFF141619)),
          child: Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBarWithoutAva(txt: "API-ключи"),
                SizedBox(height: 30.h,),
                Text(
                  'Название ключа',
                  style: TextStyle(
                    color: Color(0x7FEDF7FF),
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h,),
                Container(
                  width: 370.w,
                  height: 56.h,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.50.w, color: Color(0xFF262C35)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'old_key',
                        style: TextStyle(
                          color: Color(0xFFEDF7FF),
                          fontSize: 16.sp,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20.h,),
                Text(
                  'Статус ключа',
                  style: TextStyle(
                    color: Color(0x7FEDF7FF),
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h,),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isEnabled = true;
                        });
                      },
                      child: Container(
                        width: 170.w,
                        height: 46.h,
                        decoration: ShapeDecoration(
                          color: _isEnabled ? Color(0xFF0066FF) : Color(0xFF262C35),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Включен',
                              style: TextStyle(
                                color: _isEnabled ? Color(0xFFEDF7FF) : Color(0x7FEDF7FF),
                                fontSize: 16.sp,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isEnabled = false;
                        });
                      },
                      child: Container(
                        width: 170.w,
                        height: 46.h,
                        decoration: ShapeDecoration(
                          color: !_isEnabled ? Color(0xFF0066FF) : Color(0xFF262C35),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Выключен',
                              style: TextStyle(
                                color: !_isEnabled ? Color(0xFFEDF7FF) : Color(0x7FEDF7FF),
                                fontSize: 16.sp,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Spacer(),
                CustomButton(text: "Создать новый ключ",
                    onPressed: (context) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmLogin()));
                    },
                    clr: Color(0xFF0066FF)),
                SizedBox(height: 20.h,)
              ],
            ),
          )
      ),
    );
  }
}
