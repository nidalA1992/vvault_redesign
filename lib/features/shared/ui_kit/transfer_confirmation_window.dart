import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/transfer_currency_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/transfer/transfer_confirmed_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/orders_list_provider.dart';

class TransferConfirmationWindow {
  final String amountRub;
  final String idUser;
  final String amountCrypto;
  final String crypto;
  final String? comment;

  TransferConfirmationWindow({
    required this.amountRub,
    required this.amountCrypto,
    required this.crypto,
    required this.idUser,
    this.comment = 'empty'
  });

  void showConfirmationDialog(BuildContext context) async {
    final userStats = await Provider.of<OrderProvider>(context, listen: false).fetchUserStats(idUser);
    final user_name = userStats['user_name'];

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF1D2126),
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          content: SizedBox(
            height: 350.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Подтвердите перевод средств',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFEDF7FF),
                    fontSize: 20.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5.h,),
                Divider(color: Color(0x7FEDF7FF),),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Получатель',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 14.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      user_name,
                      style: TextStyle(
                        color: Color(0xFFEDF7FF),
                        fontSize: 14.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Сумма в рублях',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 14.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      amountRub,
                      style: TextStyle(
                        color: Color(0xFFEDF7FF),
                        fontSize: 14.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Сумма в криптовалюте',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 14.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      amountCrypto,
                      style: TextStyle(
                        color: Color(0xFFEDF7FF),
                        fontSize: 14.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Криптовалюта',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 14.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      height: 22.64.h,
                      width: 66.64.w,
                      decoration: ShapeDecoration(
                        color: Color(0xFF39424F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.33),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/crypto logo.svg", height: 12.h,),
                          SizedBox(width: 5.w,),
                          Text(
                            crypto,
                            style: TextStyle(
                              color: Color(0x7FEDF7FF),
                              fontSize: 9.33.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 29.h,),
                GestureDetector(
                  onTap: () {
                    final transactionProvider = Provider.of<TransferCurrencyProvider>(context, listen: false);

                    transactionProvider.submitTransaction(
                      amount: amountCrypto,
                      comment: comment.toString(),
                      currency: "USDT",
                      user: idUser,
                    ).then((_) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TransferConfirmedPage()));
                    }).catchError((error) {
                      print('Error submitting transaction: $error');
                    });
                  },
                  child: Container(
                    width: 248.68.w,
                    height: 45.h,
                    decoration: ShapeDecoration(
                      color: Color(0xFF0066FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.88.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Подтвердить',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 16.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h,),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 248.68.w,
                    height: 45.h,
                    decoration: ShapeDecoration(
                      color: Color(0x330066FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.88.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Отмена",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 16.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
