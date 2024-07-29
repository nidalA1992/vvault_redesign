import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vvault_redesign/features/settings_page/confidentiality_page/confirmation_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar_without_avatar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_textfield.dart';

class ChangeMail extends StatefulWidget {
  const ChangeMail({super.key});

  @override
  State<ChangeMail> createState() => _ChangeMailState();
}

class _ChangeMailState extends State<ChangeMail> {
  String _name = "Изменить почту";

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
                CustomAppBarWithoutAva(txt: _name),
                SizedBox(height: 30.h,),
                Text(
                  'Старая почта',
                  style: TextStyle(
                    color: Color(0x7FEDF7FF),
                    fontSize: 16.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h,),
                CustomTextField(hintText: "diehiehie@gmail.com", isHidden: false,),
                SizedBox(height: 20.h,),
                Text(
                  'Новая почта',
                  style: TextStyle(
                    color: Color(0x7FEDF7FF),
                    fontSize: 16.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h,),
                CustomTextField(hintText: "diehiehie@gmail.com", isHidden: false,),
                SizedBox(height: 20.h,),
                Text(
                  'Повторите почту',
                  style: TextStyle(
                    color: Color(0x7FEDF7FF),
                    fontSize: 16.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h,),
                CustomTextField(hintText: "diehiehie@gmail.com", isHidden: false,),
                SizedBox(height: 40.h,),
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
