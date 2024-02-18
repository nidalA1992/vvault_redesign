import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                    CustomAppBar(img_path: "assets/avatar.svg", username: "diehie", id_user: "201938064"),
                    SizedBox(height: 20.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '0.00',
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 28.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              print("tapped!");
                            },
                            child: Icon(Icons.keyboard_arrow_down_outlined, color: Color(0x80EDF7FF),)
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildHelperTool(
                            "assets/download_icon.svg",
                            "Пополнить",
                                (BuildContext context) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ),
                                  );
                                }),
                        buildHelperTool(
                            "assets/upload_icon.svg",
                            "Вывести",
                                (BuildContext context) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            }),
                        buildHelperTool(
                            "assets/dollar-sign_icon.svg",
                            "Оплатить",
                                (BuildContext context) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            }),
                        buildHelperTool(
                            "assets/corner-down-right_icon.svg",
                            "Получить",
                                (BuildContext context) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            }),
                      ],
                    )
                  ],
                ),
              )
          ),
          Positioned(
              top: 250,
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
                        Text(
                          'Мои счета',
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 20.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        customCryptoWidget(
                            img: "assets/etherium.png",
                            cryptoName: "Etherium",
                            cryptoAmount: "1.0023 ETH",
                            percentageChange: "+0.23%",
                            includeDivider: true,
                        ),
                        SizedBox(height: 15.h,),
                        customCryptoWidget(
                          img: "assets/etherium.png",
                          cryptoName: "Bitcoin",
                          cryptoAmount: "1.0023 BTC",
                          percentageChange: "+0.23%",
                          includeDivider: true,
                        ),
                        SizedBox(height: 15.h,),
                        customCryptoWidget(
                          img: "assets/etherium.png",
                          cryptoName: "Litecoin",
                          cryptoAmount: "1.0023 LTC",
                          percentageChange: "+0.23%",
                          includeDivider: false,
                        ),
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

  Widget buildHelperTool(String img, String txt, Function(BuildContext)? onPressed) {
    return GestureDetector(
      onTap: () => onPressed,
      child: Column(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF0066FF),
            ),
            child: Center(
              child: Container(
                width: 18.w,
                height: 18.h,
                child: ClipOval(
                  child: SvgPicture.asset(
                    img,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h,),
          Text(
            txt,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0x7FEDF7FF),
              fontSize: 12.sp,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  Widget customCryptoWidget({
    required String img,
    required String cryptoName,
    required String cryptoAmount,
    required String percentageChange,
    required bool includeDivider,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 30.w,
              height: 30.h,
              child: Stack(
                children: [
                  Container(
                    width: 30.w,
                    height: 30.h,
                    decoration: ShapeDecoration(
                      color: Color(0xFFFFFFFF),
                      shape: OvalBorder(),
                    ),
                    child: Center(
                      child: Image.asset(img),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(width: 15.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cryptoName,
                  style: TextStyle(
                    color: Color(0xFFEDF7FF),
                    fontSize: 16.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      cryptoAmount,
                      style: TextStyle(
                        color: Color(0x7FEDF7FF),
                        fontSize: 14.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      percentageChange,
                      style: TextStyle(
                        color: Color(0xFF05CA77),
                        fontSize: 12.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                )
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "К счёту",
                  style: TextStyle(
                    color: Color(0x7FEDF7FF),
                    fontSize: 12.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 5.w),
                Icon(Icons.arrow_forward_outlined, size: 20, color: Color(0x7FEDF7FF))
              ],
            ),
          ],
        ),
        if (includeDivider) ... [
          SizedBox(height: 15.h),
          Container(
            width: 350.w,
            height: 1.50.h,
            color: Color(0xFF1D2126),
          ),
        ]
      ],
    );
  }

}
