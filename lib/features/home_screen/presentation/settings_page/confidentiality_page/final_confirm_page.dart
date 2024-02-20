import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';


class FinalConfirmation extends StatefulWidget {
  const FinalConfirmation({super.key});

  @override
  State<FinalConfirmation> createState() => _FinalConfirmationState();
}

class _FinalConfirmationState extends State<FinalConfirmation> {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      //onTap: () => onPressedNotifications!(context),
                      child: SvgPicture.asset("assets/bell_icon.svg"),
                    ),
                  ],
                ),
                SizedBox(height: 150.h,),
                Center(
                  child: SvgPicture.asset("assets/confirm_graph.svg"),
                ),
                SizedBox(height: 20.h,),
                Center(
                  child: SizedBox(
                    width: 226.39.w,
                    child: Text(
                      'Настройки профиля успешно сохранены!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 80.h,),
                CustomButton(text: "На главную",
                    onPressed: (context) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                    },
                    clr: Color(0xFF0066FF))
              ],
            ),
          )
      ),
    );
  }
}
