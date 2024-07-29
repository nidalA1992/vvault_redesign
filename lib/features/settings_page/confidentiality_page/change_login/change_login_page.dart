import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar_without_avatar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_textfield.dart';

import '../confirmation_page.dart';

class ChangeLogin extends StatefulWidget {
  const ChangeLogin({super.key});

  @override
  State<ChangeLogin> createState() => _ChangeLoginState();
}

class _ChangeLoginState extends State<ChangeLogin> {
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
                CustomAppBarWithoutAva(txt: "Изменить логин"),
                SizedBox(height: 30.h,),
                Text(
                  'Старый логин',
                  style: TextStyle(
                    color: Color(0x7FEDF7FF),
                    fontSize: 16.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h,),
                CustomTextField(hintText: "diehie", isHidden: false,),
                SizedBox(height: 20.h,),
                Text(
                  'Повторите логин',
                  style: TextStyle(
                    color: Color(0x7FEDF7FF),
                    fontSize: 16.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h,),
                CustomTextField(hintText: "diehie", isHidden: false,),
                SizedBox(height: 80.h,),
                CustomButton(text: "Далее",
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
