import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vvault_redesign/features/settings_page/confidentiality_page/confirmation_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar_without_avatar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_textfield.dart';

class CreateApiKey extends StatefulWidget {
  const CreateApiKey({super.key});

  @override
  State<CreateApiKey> createState() => _CreateApiKeyState();
}

class _CreateApiKeyState extends State<CreateApiKey> {
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
                SizedBox(height: 30.h,),
                Text(
                  'Название ключа',
                  style: TextStyle(
                    color: Color(0x7FEDF7FF),
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h,),
                CustomTextField(hintText: "Введите название ключа", isHidden: false,),
                Spacer(),
                CustomButton(text: "Подтвердить создание",
                    onPressed: (context) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmLogin()));
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
