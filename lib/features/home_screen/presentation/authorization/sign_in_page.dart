import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_textfield.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
              decoration: BoxDecoration(color: Color(0xFF141619)),
              child: Padding(
                padding: EdgeInsets.only(top: 120),
                child: Column(
                  children: [
                    Text(
                      'Вход',
                      style: TextStyle(
                        color: Color(0xFFEDF7FF),
                        fontSize: 36.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 70.h,),
                    CustomTextField(hintText: 'Логин (Никнейм, почта, номер)', isHidden: false),
                    SizedBox(height: 15.h,),
                    CustomTextField(hintText: 'Пароль*')
                  ],
                ),
              )
          ),

        ],
      ),
    );
  }
}
