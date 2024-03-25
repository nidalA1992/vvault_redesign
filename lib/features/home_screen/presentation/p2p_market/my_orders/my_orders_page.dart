import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/my_orders/edit_order_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/my_orders/new_order_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar_without_avatar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/my_orders/order_instance.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
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
              children: [
                CustomAppBarWithoutAva(txt: "Мои ордера"),
                SizedBox(height: 20.h,),
                Container(
                  width: 350.w,
                  height: 1.50.h,
                  color: Color(0xFF1D2126),
                ),
                SizedBox(height: 30.h,),
                OrderInstance(
                  price: '1000',
                  priceCurrency: 'USD',
                  onPressed: (context) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditOrderPage(
                                price: "1000",
                                priceCurrency: "RUB",
                                banks: ['Bank 1', 'Bank 2'],
                                titleCurrency: "RUB",
                                lowerLimit: "500",
                                upperLimit: "1000")
                        )
                    );
                  },
                  banks: ['Bank 1', 'Bank 2'],
                  isActive: true,
                  titleCurrency: 'EUR',
                  isBuy: true,
                  lowerLimit: '500',
                  upperLimit: '1500',
                ),
                Spacer(),
                CustomButton(text: "Создать объявление",
                    onPressed: (context) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CreateOrder()));
                    },
                    clr: Color(0xFF0066FF)
                ),
                SizedBox(height: 20.h,)
              ],
            ),
          )
      ),
    );
  }
}
