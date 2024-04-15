import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';

class TransferConfirmedPage extends StatefulWidget {
  const TransferConfirmedPage({super.key});

  @override
  State<TransferConfirmedPage> createState() => _TransferConfirmedPageState();
}

class _TransferConfirmedPageState extends State<TransferConfirmedPage> {
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
            padding: EdgeInsets.only(top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SvgPicture.asset("assets/confirm_graph.svg"),
                ),
                SizedBox(height: 20.h,),
                Text(
                  'Перевод успешно выполнен!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFEDF7FF),
                    fontSize: 18.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 40.h,),
                CustomButton(text: "На главную", clr: Color(0xFF0066FF),
                  onPressed: (context) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                },
                ),
                SizedBox(height: 80.h,),
              ],
            ),
          )
      ),
    );
  }
}
