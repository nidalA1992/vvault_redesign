import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vvault_redesign/features/settings_page/profile_page/verification_identity_extended_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';

class VerificationIdentity extends StatefulWidget {
  const VerificationIdentity({super.key});

  @override
  State<VerificationIdentity> createState() => _VerificationIdentityState();
}

class _VerificationIdentityState extends State<VerificationIdentity> {
  bool passportSelected = true;

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
                          child: Text(
                            'Подтвердите свою личность',
                            style: TextStyle(
                              color: Color(0xFFEDF7FF),
                              fontSize: 24.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Text(
                          'Страна/регион выдачи',
                          style: TextStyle(
                            color: Color(0x7FEDF7FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Container(
                          width: 350.09.w,
                          height: 50.h,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: ShapeDecoration(
                            color: Color(0xFF272D35),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/russia_flag.svg"),
                              SizedBox(width: 10.w,),
                              Text(
                                'Russia',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'Местоположение',
                                style: TextStyle(
                                  color: Color(0x7FEDF7FF),
                                  fontSize: 14.sp,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 5.w,),
                              Icon(Icons.keyboard_arrow_down_outlined, color: Color(0x7FEDF7FF),)
                            ],
                          ),
                        ),
                        SizedBox(height: 30.h,),
                        Text(
                          'Тип документа',
                          style: TextStyle(
                            color: Color(0x7FEDF7FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              passportSelected = !passportSelected;
                            });
                          },
                          child: Container(
                            width: 350.09.w,
                            height: 50.h,
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            decoration: ShapeDecoration(
                              color: Color(0xFF272D35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: passportSelected ? Color(0xFF0066FF) : Color(0xFF272D35),
                                  width: 2.0,
                                ),
                              ),
                            ),
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/passport_icon.svg"),
                                  SizedBox(width: 10.w,),
                                  Text(
                                    'Паспорт',
                                    style: TextStyle(
                                      color: Color(0xFFEDF7FF),
                                      fontSize: 14.sp,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  if (passportSelected) ... [
                                    Spacer(),
                                    Icon(Icons.check, color: Color(0xFF0066FF),)
                                  ]
                                ],
                              )
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              passportSelected = !passportSelected;
                            });
                          },
                          child: Container(
                              width: 350.09.w,
                              height: 50.h,
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              decoration: ShapeDecoration(
                                color: Color(0xFF272D35),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: !passportSelected ? Color(0xFF0066FF) : Color(0xFF272D35),
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/driverlicense_icon.svg"),
                                  SizedBox(width: 10.w,),
                                  Text(
                                    'Водительские права',
                                    style: TextStyle(
                                      color: Color(0xFFEDF7FF),
                                      fontSize: 14.sp,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  if (!passportSelected) ... [
                                    Spacer(),
                                    Icon(Icons.check, color: Color(0xFF0066FF),)
                                  ]
                                ],
                              )
                          ),
                        ),
                        SizedBox(height: 30.h,),
                        Text(
                          'Требования',
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 16.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        Text(
                          'ПАСПОРТ',
                          style: TextStyle(
                            color: Color(0xFF0066FF),
                            fontSize: 12.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        SizedBox(
                          width: 350.w,
                          child: Text(
                            '1. Используйте действующий удостоверяющий личность документ, выданный государстом',
                            style: TextStyle(
                              color: Color(0x7FEDF7FF),
                              fontSize: 14.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        SizedBox(
                          width: 350.w,
                          child: Text(
                            '2. Если вы уже прошли верификацию в другом аккаунте senkoke, не используйте тот же тип документа',
                            style: TextStyle(
                              color: Color(0x7FEDF7FF),
                              fontSize: 14.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        SizedBox(
                          width: 350.w,
                          child: Text(
                            '3. Убедитесь, что загружаемый документ оригинальный. Фотокопии не принимаются',
                            style: TextStyle(
                              color: Color(0x7FEDF7FF),
                              fontSize: 14.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        CustomButton(text: "Подтвердить", clr: Color(0xFF0066FF),
                            onPressed: (context) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationIdentityExtended()));
                            }),
                        SizedBox(height: 10.h,),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Center(
                            child: Text(
                              'Отменить',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
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
