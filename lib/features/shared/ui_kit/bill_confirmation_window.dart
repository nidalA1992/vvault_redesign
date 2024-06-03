import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/bill/successful_bill_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/create_payment_provider.dart';

class BillConfirmationWindow {
  final String amountRub;
  final String idUser;
  final String amountCrypto;
  final String crypto;
  final String? comment;

  BillConfirmationWindow({
    required this.amountRub,
    required this.amountCrypto,
    required this.crypto,
    required this.idUser,
    this.comment = 'empty'
  });

  void showConfirmationDialog(BuildContext context) async {
    //final user_name = await Provider.of<OrderProvider>(context, listen: false).fetchUserStats(idUser);

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
                  'Вы собираетесь выставить счёт через систему SenPay',
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
                      'Сумма в рублях',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 14.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          amountRub,
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          " RUB",
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 15.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Сумма в \nкриптовалюте',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 14.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          amountCrypto,
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          " $crypto",
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 15.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Комиссия',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 14.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "com",
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          " $crypto",
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 29.h,),
                GestureDetector(
                  onTap: () async {
                    try {
                      await Provider.of<PaymentProvider>(context, listen: false).createPayment(
                        comment: comment ?? 'empty',
                        cryptoCurrency: crypto,
                        notifyUrl: '', // Add the correct URL
                        redirectUrl: '', // Add the correct URL
                        targetAmount: amountCrypto,
                        targetCurrency: crypto,
                      );
                      final paymentId = Provider.of<PaymentProvider>(context, listen: false).paymentId;
                      if (paymentId != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SuccessfulBill(paymentId: paymentId)),
                        );
                      } else {
                        print('Payment ID is null');
                      }
                    } catch (e) {
                      print(e);
                    }
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
