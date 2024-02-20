import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/home_screen.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/confidentiality_page/confirmation_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar_without_avatar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_textfield.dart';
import '../../../../../../main.dart';

class DidntGetConfirmLetter extends StatefulWidget {
  final String txt;
  const DidntGetConfirmLetter({super.key, required this.txt});

  @override
  State<DidntGetConfirmLetter> createState() => _DidntGetConfirmLetterState();
}

class _DidntGetConfirmLetterState extends State<DidntGetConfirmLetter> {
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
                CustomAppBarWithoutAva(txt: widget.txt),
                SizedBox(height: 30.h,),
                SizedBox(
                  width: 342.88.w,
                  child: Text(
                    'Не получили электронное письмо с кодом подтверждения?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 30.h,),
                SizedBox(
                  width: 339.44.w,
                  child: Opacity(
                    opacity: 0.50,
                    child: Text(
                      'Попробуйте несколько вариантов решения:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                solutionRow("assets/1_in_circle.svg", "Проверьте папку спам в вашей электронной почте"),
                SizedBox(height: 15.h,),
                solutionRow("assets/2_in_circle.svg", 'Убедитесь, что вы верно указали адрес электронной почты: ghdfhshsh@gmsil.com '),
                SizedBox(height: 15.h,),
                solutionRow("assets/3_in_circle.svg", "Повторите попытку через 10 минут"),
                SizedBox(height: 20.h,),
                SizedBox(
                  width: 339.44.w,
                  child: Opacity(
                    opacity: 0.50,
                    child: Text(
                      'Если выше указанные способы не подошли, и вы так и не получили сообщения, то свяжитесь с нашей службой поддержки',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                CustomButton(text: "Хорошо",
                    onPressed: (context) {
                  Navigator.pop(context);
                    },
                    clr: Color(0xFF0066FF)),
                SizedBox(height: 10.h,),
                CustomButton(text: "Чат с поддержкой",
                    onPressed: (context) {
                      Navigator.pop(context);
                    },
                    clr: Color(0xFF262C35)),
                SizedBox(height: 40.h,)
              ],
            ),
          )
      ),
    );
  }

  Widget solutionRow(String img_path, String txt) {
    return Row(
      children: [
        SvgPicture.asset(img_path),
        SizedBox(width: 10.w,),
        SizedBox(
          width: 270.41.w,
          child: Text(
            txt,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}
