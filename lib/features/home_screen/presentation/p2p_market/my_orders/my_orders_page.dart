import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/my_orders/edit_order_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
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
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
              width: double.infinity,
              height: 0.3.sh,
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(color: Color(0xFF1D2126)),
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    CustomAppBar(img_path: "assets/avatar.png", username: "diehie", isP2P: true,
                      onPressedOrders: (context) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrdersPage()));
                      },),
                    SizedBox(height: 20.h,),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back_outlined, color: Color(0x7FEDF7FF))
                        ),
                        SizedBox(width: 10.w,),
                        Text(
                          'Мои объявления',
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 20.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
          ),
          Positioned(
              top: 160,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: Color(0xFF141619),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        SizedBox(height: 320.h,),
                        CustomButton(text: "Создать объявление",
                            onPressed: (context) {
                          print("madi eshak");
                            },
                            clr: Color(0xFF0066FF)
                        )
                      ],
                    ),
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}
