import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/home_screen.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/confidentiality_page/change_login/change_login_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/confidentiality_page/change_mail/change_mail_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/confidentiality_page/change_password/change_password_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_textfield.dart';

import '../../../../../main.dart';

class ConfidentialityPage extends StatefulWidget {
  const ConfidentialityPage({super.key});

  @override
  State<ConfidentialityPage> createState() => _ConfidentialityPageState();
}

class _ConfidentialityPageState extends State<ConfidentialityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
              width: double.infinity,
              height: 0.3.sh,
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(color: Color(0xFF1D2126)),
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    CustomAppBar(img_path: "assets/avatar.png", username: "diehie"),
                    SizedBox(height: 20.h,),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back_outlined, color: Color(0x7FEDF7FF))
                        ),
                        SizedBox(width: 10.w,),
                        Text(
                          'Безопасность',
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 20.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
          ),
          Positioned(
              top: 160,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: Color(0xFF141619),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Основные',
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 24.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Text(
                          'Логин',
                          style: TextStyle(
                            color: Color(0x7FEDF7FF),
                            fontSize: 16.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        CustomTextField(hintText: "diehie", isEditable: true,
                          onPressed: (context) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeLogin())).then((_) {
                            Get.find<NavBarVisibilityController>().show();
                          });
                          },),
                        SizedBox(height: 10.h,),
                        Text(
                          'Пароль',
                          style: TextStyle(
                            color: Color(0x7FEDF7FF),
                            fontSize: 16.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        CustomTextField(hintText: "*******", isEditable: true,
                          onPressed: (context) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword())).then((_) {
                              Get.find<NavBarVisibilityController>().show();
                            });;
                          },),
                        SizedBox(height: 10.h,),
                        Text(
                          'Почта',
                          style: TextStyle(
                            color: Color(0x7FEDF7FF),
                            fontSize: 16.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        CustomTextField(hintText: "diehiehie@gmail.com", isEditable: true,
                          onPressed: (context) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeMail())).then((_) {
                              Get.find<NavBarVisibilityController>().show();
                            });;
                          },),
                        SizedBox(height: 20.h,),
                        Text(
                          'Повышенная защита',
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 24.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Container(
                          width: 370.w,
                          height: 60.h,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1.50.w, color: Color(0xFF262C35)),
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Google-аутентификатор',
                                style: TextStyle(
                                  color: Color(0xFFEDF7FF),
                                  fontSize: 16.sp,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        SizedBox(
                          width: 349.96.w,
                          child: Text(
                            'Подключите двойную аутентификацию, чтобы обезопасить свой аккаунт',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 14.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        CustomButton(text: "Подключено", clr: Color(0xFF02603E),
                            onPressed: (context) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                            }),
                        SizedBox(height: 10.h,),
                        CustomButton(text: "Отключить", clr: Color(0xFF262C35),
                            onPressed: (context) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                            }),
                        SizedBox(height: 20.h,),
                      ],
                    ),
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}
