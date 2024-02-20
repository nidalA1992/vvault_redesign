import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_converter.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_field.dart';

class BuyExtended extends StatefulWidget {
  const BuyExtended({super.key});

  @override
  State<BuyExtended> createState() => _BuyExtendedState();
}

class _BuyExtendedState extends State<BuyExtended> {
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
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                      child: Icon(Icons.arrow_back_outlined, color: Color(0xFF8A929A),)
                  ),
                  Spacer(),
                  Text(
                    'Покупка USDT',
                    style: TextStyle(
                      color: Color(0xFFEDF7FF),
                      fontSize: 16.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.h,),
              BuySellConverterField(isBuy: true,),
              SizedBox(height: 20.h,),
              BuySellField(isBuy: true, hint_txt: "Я заплачу",),
              SizedBox(height: 20.h,),
              BuySellField(isBuy: true, hint_txt: "Я получу",),
              SizedBox(height: 20.h,),
              BuySellButton(txt: "Купить", isBuy: true),
              SizedBox(height: 20.h,),
              Text(
                'Способ оплаты',
                style: TextStyle(
                  color: Color(0xFFEDF7FF),
                  fontSize: 18.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.h,),
              Text(
                'Сбер, Тинькофф, Совкомбанк, Тинькофф, УралСиб',
                style: TextStyle(
                  color: Color(0xFF8A929A),
                  fontSize: 14.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20.h,),
              Container(
                width: 350.w,
                height: 1.50.h,
                color: Color(0xFF1D2126),
              ),
              SizedBox(height: 20.h,),
              Text(
                'Условия сделки',
                style: TextStyle(
                  color: Color(0xFFEDF7FF),
                  fontSize: 18.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.h,),
              Text(
                'Куча слов про сделку я не работаю со скамерами и прочими говнюками!\n\nПрошу заметить что я честный трейдер и если вы обманите меня то будете иметь дело с моими братанами. ',
                style: TextStyle(
                  color: Color(0x7FEDF7FF),
                  fontSize: 14.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          )
      ),
    );
  }
}
