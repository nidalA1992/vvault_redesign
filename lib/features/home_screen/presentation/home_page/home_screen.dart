import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/all_money_1value_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/create_wallet_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/get_user_wallets_provider.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/home_page/operation_instance.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void loadAllMoney() async {
    await Provider.of<AllMoneyProvider>(context, listen: false).fetchAllMoney("RUB");
  }

  void loadWallets() async {
    await Provider.of<WalletProvider>(context, listen: false).loadWallets();
  }

  @override
  void initState() {
    loadAllMoney();
    loadWallets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final allmoney = Provider.of<AllMoneyProvider>(context).allMoney;
    final _wallets = Provider.of<WalletProvider>(context).wallets;
    final createWallet = Provider.of<WalletCreationProvider>(context, listen: false);

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
              decoration: BoxDecoration(color: Color(0xFF141619)),
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAppBar(img_path: "assets/avatar.svg", username: "diehie", id_user: "201938064"),
                      SizedBox(height: 20.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${allmoney} ₽',
                            style: TextStyle(
                              color: Color(0xFFEDF7FF),
                              fontSize: 36.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 30.h,),
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
                              "assets/vyvesti_icon.svg",
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
                              "assets/arrow-left.svg",
                              "Перевести",
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
                              "Счет",
                                  (BuildContext context) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                );
                              }),
                        ],
                      ),
                      SizedBox(height: 40.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Cчета',
                            style: TextStyle(
                              color: Color(0xFFEDF7FF),
                              fontSize: 20.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down_outlined, color: Color(0x7FEDF7FF))
                        ],
                      ),
                      SizedBox(height: 10.h,),
                      Container(
                        width: 350.w,
                        height: 1.50.h,
                        color: Color(0xFF1D2126),
                      ),
                      SizedBox(height: 30.h,),
                      customCryptoWidget(
                        img: "assets/etherium.png",
                        cryptoName: _wallets[0]['currency'],
                        cryptoAmount: _wallets[0]['balance'],
                        includeDivider: false,
                      ),
                      SizedBox(height: 30.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'События',
                            style: TextStyle(
                              color: Color(0xFFEDF7FF),
                              fontSize: 20.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'История операций',
                            style: TextStyle(
                              color: Color(0xFF62A0FF),
                              fontSize: 14.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 15.h,),
                      OperationInstance(
                          type: "incoming",
                          username: "diehie",
                          quantity: "7800",
                          currency: "USDT"
                      ),
                    ],
                  ),
                ),
              )
          ),
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
            width: 54.w,
            height: 54.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF0066FF),
            ),
            child: Center(
              child: ClipOval(
                child: SvgPicture.asset(
                  img,
                  fit: BoxFit.cover,
                  width: 20.w,
                  height: 20.h,
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
    required bool includeDivider,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 35.w,
              height: 35.h,
              child: Stack(
                children: [
                  Container(
                    width: 35.w,
                    height: 35.h,
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
            SizedBox(width: 10.w),
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
                Text(
                  cryptoAmount,
                  style: TextStyle(
                    color: Color(0x7FEDF7FF),
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            Spacer(),
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
