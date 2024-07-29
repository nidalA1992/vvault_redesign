import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vvault_redesign/features/settings_page/profile_page/own_company_extended_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';

class OwnCompany extends StatefulWidget {
  const OwnCompany({super.key});

  @override
  State<OwnCompany> createState() => _OwnCompanyState();
}

class _OwnCompanyState extends State<OwnCompany> {
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
                    CustomAppBar(img_path: "assets/avatar.png"),
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
                          'Профиль',
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
                        SizedBox(
                          width: 335.09.w,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Что такое ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: 'SenPay',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.sp,
                                    fontFamily: 'Azonix',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: '?',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 166.45.w,
                              height: 166.45.h,
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              decoration: ShapeDecoration(
                                color: Color(0xFF1D2126),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Column(
                                children: [
                                  SvgPicture.asset("assets/double_coin_image.svg"),
                                  SizedBox(height: 10.h,),
                                  Text(
                                    'Возмжность получать и совершать оплату во всех сторонних сервисах',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 166.45.w,
                              height: 166.45.h,
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              decoration: ShapeDecoration(
                                color: Color(0xFF1D2126),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Column(
                                children: [
                                  SvgPicture.asset("assets/falling_coin_image.svg"),
                                  SizedBox(height: 10.h,),
                                  Text(
                                    'Выбор любой желаемой валюты в качестве оплаты',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 166.45.w,
                              height: 166.45.h,
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              decoration: ShapeDecoration(
                                color: Color(0xFF1D2126),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Column(
                                children: [
                                  SvgPicture.asset("assets/lock_coin_image.svg"),
                                  SizedBox(height: 10.h,),
                                  Text(
                                    'Высокий уровень безопасности и защита персональных данных',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 166.45.w,
                              height: 166.45.h,
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              decoration: ShapeDecoration(
                                color: Color(0xFF1D2126),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Column(
                                children: [
                                  SvgPicture.asset("assets/coin_keys_image.svg"),
                                  SizedBox(height: 10.h,),
                                  Text(
                                    "Легкая интеграция с веб-сайтами и приложениями продавцов",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h,),
                        Text(
                          'У вас своя компания?',
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 24.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        SizedBox(
                          width: 357.76.w,
                          child: Text(
                            'Переключайтесь на Бизнес аккаунт и используйте возможности по максимуму!',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 14.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Text(
                          'Политика конфиденциальности',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF62A1FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 30.h,),
                        CustomButton(text: "Подтвердить", clr: Color(0xFF0066FF),
                            onPressed: (context) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OwnCompanyExtended()));
                            }),
                        SizedBox(height: 30.h,),
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
