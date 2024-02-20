import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/settings_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_textfield.dart';

class OwnCompanyExtended extends StatefulWidget {
  const OwnCompanyExtended({super.key});

  @override
  State<OwnCompanyExtended> createState() => _OwnCompanyExtendedState();
}

class _OwnCompanyExtendedState extends State<OwnCompanyExtended> {
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
                            'Анкета',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        SizedBox(
                          width: 350.60.w,
                          child: Text(
                            'Мы предлагаем интеграцию с платежной системой SenPay, где пользователи могут быстро и безопасно проводить транзакции, включая использование кошелька Sentoke. Деньги за покупки автоматически зачисляются на счет Sentoke, обеспечивая удобство и простоту использования',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Text(
                          'Название компании',
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
                          height: 60.h,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1.50.w, color: Color(0xFF262C35)),
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextField(
                                  style: TextStyle(
                                    color: Color(0xFFEDF7FF),
                                    fontSize: 16.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "ИП diehie",
                                    hintStyle: TextStyle(
                                      color: Color(0xFFEDF7FF).withOpacity(0.5), // Lighter hint text color
                                      fontSize: 16.sp,
                                    ),
                                    border: InputBorder.none, // No border
                                    contentPadding: EdgeInsets.zero, // Default padding is fine
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Text(
                          'Почта',
                          style: TextStyle(
                            color: Color(0x7FEDF7FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        CustomTextField(hintText: "diehiehie@gmail.com", isHidden: true,),
                        SizedBox(height: 20.h,),
                        Text(
                          'Ваш телеграм',
                          style: TextStyle(
                            color: Color(0x7FEDF7FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        CustomTextField(hintText: "@diehie6", isHidden: true,),
                        SizedBox(height: 20.h,),
                        Text(
                          'Ваш сайт',
                          style: TextStyle(
                            color: Color(0x7FEDF7FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        CustomTextField(hintText: "https://www.bigl", isHidden: true,),
                        SizedBox(height: 30.h,),
                        CustomButton(text: "Отправить", clr: Color(0xFF0066FF),
                            onPressed: (context) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                            }
                        ),
                        SizedBox(height: 20.h,),
                        SizedBox(
                          width: 409.75.w,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Нажимая кнопку “Отправить” вы соглашаетесь\nс политикой обработки ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    height: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: 'конфиденциальных данных',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
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
