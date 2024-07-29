import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vvault_redesign/features/settings_page/confidentiality_page/confirmation_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar_without_avatar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';

class NoApiKeys extends StatefulWidget {
  const NoApiKeys({super.key});

  @override
  State<NoApiKeys> createState() => _NoApiKeysState();
}

class _NoApiKeysState extends State<NoApiKeys> {
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
                SizedBox(height: 120.h,),
                Center(child: SvgPicture.asset("assets/coin_keys_image.svg", height: 191.38.h, width: 153.95.w,)),
                SizedBox(height: 30.h,),
                Center(
                  child: SizedBox(
                    width: 375.w,
                    child: Text(
                      'Вы не создали ни одного API-ключа',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFEDF7FF),
                        fontSize: 24.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ),
                SizedBox(height: 20.h,),
                Center(
                  child: SizedBox(
                    width: 345.83.w,
                    child: Text(
                      'API-ключи – это ключи шифрования для аутентификации пользователя в системе, по аналогии логина \nи пароля',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0x7FEDF7FF),
                        fontSize: 18.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ),
                SizedBox(height: 40.h,),
                CustomButton(text: "Создать ключ",
                    onPressed: (context) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmLogin()));
                    },
                    clr: Color(0xFF0066FF))
              ],
            ),
          )
      ),
    );
  }
}
