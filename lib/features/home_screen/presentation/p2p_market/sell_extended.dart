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

class SellExtended extends StatefulWidget {
  String? fiat;
  String? crypto;
  String? cost;
  List<dynamic> banks;
  String? comments;
  String? unitCost;

  SellExtended({super.key, required this.fiat, required this.crypto, required this.banks, required this.comments, required this.unitCost, required this.cost});

  @override
  State<SellExtended> createState() => _SellExtendedState();
}

class _SellExtendedState extends State<SellExtended> {
  final List<String> _paymentMethods = ['Sberbank', 'Ziraat', 'Garanti'];

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
                    'Продажа ${widget.crypto}',
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
              BuySellConverterField(isBuy: false, price: '${widget.cost}', fiat: widget.fiat, crypto: widget.crypto),
              SizedBox(height: 10.h,),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return OrdersBottomSheet(
                        options: widget.banks,
                        title: 'Выберите криптовалюту',
                        searchText: "Поиск монет",
                      );
                    },
                  );
                },
                child: Container(
                  width: 350.w,
                  height: 56.h,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: ShapeDecoration(
                    color: Color(0xFF272D35),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Способ оплаты',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF8A929A),
                          fontSize: 14.sp,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down_outlined, color: Color(0xFF8A929A),)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h,),
              BuySellField(isBuy: true, hint_txt: "Я заплачу",fiat: '${widget.fiat}', textController: TextEditingController(),),
              SizedBox(height: 10.h,),
              BuySellField(isBuy: true, hint_txt: "Я получу",fiat: '${widget.crypto}', textController: TextEditingController(),),
              SizedBox(height: 10.h,),
              BuySellButton(txt: "Продать", isBuy: false, sellerCurrency: '', sellerLogin: '', amount: '', requisiteId: '', sellerBank: '', requisite: '', comment: '', orderId: '',),
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
                widget.banks.join(", "),
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
                widget.comments!,
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
