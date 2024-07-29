import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import '../../../../../../main.dart';

class CanceledDealPage extends StatefulWidget {
  const CanceledDealPage({super.key});

  @override
  State<CanceledDealPage> createState() => _CanceledDealPageState();
}

class _CanceledDealPageState extends State<CanceledDealPage> {
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: SvgPicture.asset("assets/not_verified.svg"),),
                SizedBox(height: 20.h,),
                Text(
                  'Сделка успешно отменена',
                  style: TextStyle(
                    color: Color(0xFFEDF7FF),
                    fontSize: 18.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 30.h,),
                CustomButton(
                    text: "Вернуться",
                    onPressed: (context) {
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
