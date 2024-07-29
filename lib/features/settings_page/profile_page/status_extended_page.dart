import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vvault_redesign/features/settings_page/profile_page/verification_identity_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';

class StatusExntended extends StatefulWidget {
  const StatusExntended({super.key});

  @override
  State<StatusExntended> createState() => _StatusExntendedState();
}

class _StatusExntendedState extends State<StatusExntended> {
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
                        Text(
                          'Статус аккаунта',
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 24.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        SizedBox(
                          width: 324.51.w,
                          child: Text(
                            'У вас минимальный статус аккаунта. Некоторые функции могут быть ограничены',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 16.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        CustomButton(text: "Повысить статус", clr: Color(0xFF0066FF),
                            onPressed: (context) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationIdentity()));
                            }),
                        SizedBox(height: 30.h,),
                        statusInfo("Минимальный"),
                        SizedBox(height: 20.h,),
                        statusInfo("Стандартный"),
                        SizedBox(height: 20.h,)
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

  Widget statusInfo(String statusName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset("assets/sentoke_logo.svg"),
            SizedBox(width: 10.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statusName,
                  style: TextStyle(
                    color: Color(0xFFEDF7FF),
                    fontSize: 24.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5.h,),
                Text(
                  'ВАШ СТАТУС',
                  style: TextStyle(
                    color: Color(0xFF0066FF),
                    fontSize: 12.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        SizedBox(
          width: 323.27.w,
          child: Text(
            'Оплачивать покупки в интернете через SenPay',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 14.sp,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 10.h,),
        SizedBox(
          width: 323.27.w,
          child: Text(
            'Переводить другим пользователям',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 14.sp,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 10.h,),
        SizedBox(
          width: 323.27.w,
          child: Text(
            'Выводить средства через BlockChain',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 14.sp,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 10.h,),
        SizedBox(
          width: 323.27.w,
          child: Text(
            'Пополнять баланс через P2P',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 14.sp,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        if (statusName == "Стандартный") ... [
          SizedBox(height: 10.h,),
          SizedBox(
            width: 323.27.w,
            child: Text(
              '+ Пополнять баланс через BlockChain',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 10.h,),
          SizedBox(
            width: 323.27.w,
            child: Text(
              '+ Создавать свои объявления на P2P',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 10.h,),
          SizedBox(
            width: 323.27.w,
            child: Text(
              '+ Выставлять счета другим пользователям на оплату',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ]
      ],
    );
  }
}
