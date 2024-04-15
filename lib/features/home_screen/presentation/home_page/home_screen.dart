import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/all_money_1value_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/check_balance_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/create_wallet_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/get_user_wallets_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/transaction_history_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/replenish/replenish_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/transfer/transactions_history_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/transfer/transfer_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/withdraw/withdraw_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/settings_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/home_page/operation_instance.dart';
import 'package:vvault_redesign/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void loadAllMoney() async {
    await Provider.of<AllMoneyProvider>(context, listen: false).fetchAllMoney("RUB");
  }

  void loadTransactions() async {
    await Provider.of<TransactionHistoryProvider>(context, listen: false).loadTransactions();
  }

  void loadWallets() async {
    await Provider.of<WalletProvider>(context, listen: false).loadWallets();
  }

  @override
  void initState() {
    loadAllMoney();
    loadWallets();
    loadTransactions();
    super.initState();
  }

  Future<void> _onRefresh() async {
    try {
      await Provider.of<AllMoneyProvider>(context, listen: false).fetchAllMoney("RUB");
      await Provider.of<WalletProvider>(context, listen: false).loadWallets();
      await Provider.of<TransactionHistoryProvider>(context, listen: false).loadTransactions();
    } catch (error) {
      print("Failed to refresh data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final allmoney = Provider.of<AllMoneyProvider>(context).allMoney;
    final _wallets = Provider.of<WalletProvider>(context).wallets;
    final createWallet = Provider.of<WalletCreationProvider>(context, listen: false);
    final checkBalance = Provider.of<CheckBalanceProvider>(context, listen: false);
    final transactionProvider = Provider.of<TransactionHistoryProvider>(context, listen: false);
    final _transactions = transactionProvider.transactions;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(color: Color(0xFF141619)),
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: RefreshIndicator(
                  color: Color(0xFF141619),
                  onRefresh: _onRefresh,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAppBar(
                            img_path: "assets/avatar.svg",
                            id_user: "201938064",
                            onPressedScanQR: (context) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                            },
                        ),
                        SizedBox(height: 20.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${formatLimit(allmoney.toString())} ₽',
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
                            GestureDetector(
                              onTap: () {
                                Get.find<NavBarVisibilityController>().hide();
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ReplenishPage())).then((_) {
                                  Get.find<NavBarVisibilityController>().show();
                                });
                              },
                              child: buildHelperTool(
                                  "assets/download_icon.svg",
                                  "Пополнить"
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.find<NavBarVisibilityController>().hide();
                                Navigator.push(context, MaterialPageRoute(builder: (context) => WithdrawPage())).then((_) {
                                  Get.find<NavBarVisibilityController>().show();
                                });
                              },
                              child: buildHelperTool(
                                  "assets/ver2_upload.svg",
                                  "Вывести"
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.find<NavBarVisibilityController>().hide();
                                Navigator.push(context, MaterialPageRoute(builder: (context) => TransferPage())).then((_) {
                                  Get.find<NavBarVisibilityController>().show();
                                });
                              },
                              child: buildHelperTool(
                                  "assets/arrow-left.svg",
                                  "Перевести"
                              ),
                            ),
                            buildHelperTool(
                                "assets/dollar-sign_icon.svg",
                                "Счет"
                            )
                          ],
                        ),
                        SizedBox(height: 40.h,),
                        Text(
                          'Cчета',
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 20.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        if (_wallets.isNotEmpty) ... [
                          customCryptoWidget(
                            img: "assets/crypto logo.svg",
                            cryptoName: _wallets[0]['currency'],
                            cryptoAmount: _wallets[0]['balance'],
                            includeDivider: false,
                          ),
                        ],
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
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionsHistoryPage()));
                              },
                              child: Text(
                                'История операций',
                                style: TextStyle(
                                  color: Color(0xFF62A0FF),
                                  fontSize: 14.sp,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 15.h,),
                        _transactions.isEmpty
                            ? Center(child: Text("No transactions yet", style: TextStyle(color: Color(0x7FEDF7FF), fontSize: 16.sp)))
                            : ListView.builder(
                          physics: ClampingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: min(_transactions.length, 4),
                          itemBuilder: (context, index) {
                            var transaction = _transactions[index];
                            return OperationInstance(
                              type: transaction['Type'] as String,
                              username: transaction['To'] as String,
                              quantity: transaction['GiveAmount'] as String,
                              currency: transaction['Currency'] as String,
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  checkBalance.checkBalance("USDT");
                                },
                                child: Text('add balance', style: TextStyle(color: Color(0xFF141619)),)
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  createWallet.createWallet("USDT");
                                },
                                child: Text('create wallet', style: TextStyle(color: Color(0xFF141619)),)
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }

  Widget buildHelperTool(String img, String txt) {
    return Column(
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
                      child: SvgPicture.asset(img)
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

  String formatLimit(String limit) {
    return limit.length > 10 ? limit.substring(0, 10) : limit;
  }

}
