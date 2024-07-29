import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/my_orders/modal_bottom_sheet.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_converter.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_field.dart';

class P2PLoadingPage extends StatefulWidget {
  const P2PLoadingPage({super.key});

  @override
  State<P2PLoadingPage> createState() => _P2PLoadingPageState();
}

class _P2PLoadingPageState extends State<P2PLoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.only(
            top: 80,
            left: 20,
            right: 20,
          ),
          decoration: BoxDecoration(color: Color(0xFF141619)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 160.h,),
              Center(
                child: SvgPicture.asset("assets/loading_graph.svg"),
              ),
              SizedBox(height: 20.h,),
              Center(
                child: Text(
                  'Несколько секунд! \nНачинаем сделку...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFEDF7FF),
                    fontSize: 18.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}
