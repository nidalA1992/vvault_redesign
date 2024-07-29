import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vvault_redesign/features/settings_page/confidentiality_page/confirmation_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar_without_avatar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';


class HaveCompany extends StatefulWidget {
  const HaveCompany({super.key});

  @override
  State<HaveCompany> createState() => _HaveCompanyState();
}

class _HaveCompanyState extends State<HaveCompany> {
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
            padding: EdgeInsets.only(top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBarWithoutAva(txt: "API-ключи"),
                SizedBox(height: 120.h,),
                Center(child: SvgPicture.asset("assets/stack_coins.svg")),
                SizedBox(height: 30.h,),
                Center(
                  child: Text(
                    'У вас своя компания?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                Center(
                  child: SizedBox(
                    width: 345.83.w,
                    child: Text(
                      'Переключайтесь на Бизнес аккаунт и используйте возможности по максимуму!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 18.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.h,),
                CustomButton(text: "Узнать больше",
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
