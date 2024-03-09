import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/home_screen.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/deal_canceled_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/spor_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_banks.dart';
import 'package:vvault_redesign/features/shared/ui_kit/timer.dart';

import '../../../shared/ui_kit/confirmation_window.dart';

class ConfirmedDealPage extends StatefulWidget {
  final String dealNumber;
  final Function(BuildContext)? onPressed;
  final String sellerAmount;
  final String sellerLogin;
  final String sellerCurrency;

  const ConfirmedDealPage({
    Key? key,
    required this.dealNumber,
    required this.onPressed,
    required this.sellerAmount,
    required this.sellerLogin,
    required this.sellerCurrency
  }) : super(key: key);

  @override
  _ConfirmedDealPageState createState() => _ConfirmedDealPageState();
}

class _ConfirmedDealPageState extends State<ConfirmedDealPage> {
  bool isExpanded = false;

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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap: () => widget.onPressed!(context),
                        child: Icon(Icons.arrow_back_outlined, color: Color(0xFF8A929A),)
                    ),
                    Spacer(),
                    Text(
                      'Сделка #${widget.dealNumber}',
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
                Row(
                  children: [
                    SizedBox(
                      width: 185.15.w,
                      child: Text(
                        'Завершите оплату в течение ',
                        style: TextStyle(
                          color: Color(0xFFEDF7FF),
                          fontSize: 18.sp,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    CountdownTimer()
                  ],
                ),
                SizedBox(height: 20.h,),
                ExtendableBanksList(
                  banks: ["Сбербанк"],
                    price: "363 928",
                    currency: "RUB",
                    onPressed: (context) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                    },
                    bank_requis: "6529 0736 9087 1639",
                    comment: "Куча слов про сделку я не работаю со скамерами и прочими говнюками!"
                ),
                Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent, ),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    title: Text(
                      'Информация о сделке',
                      style: TextStyle(
                        color: Color(0x7FEDF7FF),
                        fontSize: 12.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Icon(
                      isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: Color(0x7FEDF7FF),
                    ),
                    onExpansionChanged: (bool expanding) => setState(() => isExpanded = expanding),
                    children: [
                      Align(
                        alignment:Alignment.centerLeft,
                        child: Text(
                          'Количество: ${widget.sellerAmount} ${widget.sellerCurrency}',
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Продавец: ${widget.sellerLogin}',
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
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
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h,),
                Text(
                  'Куча слов про сделку я не работаю со скамерами и прочими говнюками!',
                  style: TextStyle(
                    color: Color(0x7FEDF7FF),
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 30.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        ConfirmationWindow(
                          content: 'Вы точно перевели деньги по указанным реквизитам?',
                          confirmButtonText: 'Подтвердить',
                          cancelButtonText: 'Отмена',
                          onConfirm: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => SporPage(
                                    dealNumber: widget.dealNumber,
                                    onPressed: (context) {
                                      Navigator.pop(context);
                                    },
                                    sellerAmount: widget.sellerAmount,
                                    sellerLogin: widget.sellerLogin,
                                    sellerCurrency: widget.sellerCurrency)));
                          },
                        ).showConfirmationDialog(context);
                      },
                      child: Container(
                        width: 167.w,
                        height: 44.h,
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        decoration: ShapeDecoration(
                          color: Color(0xFF252A31),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Спор',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFEDF7FF),
                                fontSize: 14.sp,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        ConfirmationWindow(
                          content: 'Вы точно хотите отменить сделку?',
                          confirmButtonText: 'Подтвердить',
                          cancelButtonText: 'Отмена',
                          onConfirm: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CanceledDealPage()));
                          },
                        ).showConfirmationDialog(context);
                      },
                      child: Container(
                        width: 167.w,
                        height: 44.h,
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        decoration: ShapeDecoration(
                          color: Color(0xFF252A31),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Отменить',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFEDF7FF),
                                fontSize: 14.sp,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h,)
              ],
            ),
          )
      ),
    );
  }
}
