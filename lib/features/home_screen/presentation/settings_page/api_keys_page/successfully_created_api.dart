import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/home_screen.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/confidentiality_page/confirmation_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/api_key_instance.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar_without_avatar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_textfield.dart';
import '../../../../../../main.dart';

class SuccessfullyCreatedApi extends StatefulWidget {
  const SuccessfullyCreatedApi({super.key});

  @override
  State<SuccessfullyCreatedApi> createState() => _SuccessfullyCreatedApiState();
}

class _SuccessfullyCreatedApiState extends State<SuccessfullyCreatedApi> {
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
                CustomAppBarWithoutAva(txt: "Создание ключа"),
                SizedBox(height: 120.h,),
                Center(child: SvgPicture.asset("assets/confirm_graph.svg")),
                SizedBox(height: 30.h,),
                Center(
                    child: Text(
                      'Сохрани, спаси и никому его не показывай!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFEDF7FF),
                        fontSize: 24.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    )
                ),
                SizedBox(height: 20.h,),
                ApiKeyInstance(name: "new_key", isEnabled: true, createdNow: true,),
                Spacer(),
                CustomButton(text: "На главную",
                    onPressed: (context) {
                      Navigator.pop(context);
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
