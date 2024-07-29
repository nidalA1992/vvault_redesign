import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vvault_redesign/features/settings_page/confidentiality_page/confirmation_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar_without_avatar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';


class EmptyRequisites extends StatefulWidget {
  const EmptyRequisites({super.key});

  @override
  State<EmptyRequisites> createState() => _EmptyRequisitesState();
}

class _EmptyRequisitesState extends State<EmptyRequisites> {
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
                CustomAppBarWithoutAva(txt: "Реквизиты"),
                SizedBox(height: 120.h,),
                Center(child: SvgPicture.asset("assets/coin_scales.svg", height: 191.38.h, width: 153.95.w,)),
                SizedBox(height: 30.h,),
                Center(
                    child: SizedBox(
                      width: 375.w,
                      child: Text(
                        'Вы не добавили реквизиты',
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
                        'После добавления реквизитов Вы можете Купить/Продать свою криптовалюту',
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
