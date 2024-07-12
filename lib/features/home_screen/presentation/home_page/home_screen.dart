import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/bill/bill_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/camera_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/all_money_1value_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/check_balance_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/create_wallet_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/get_user_wallets_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/notifications_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/transaction_history_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/replenish/replenish_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/transfer/transactions_history_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/transfer/transfer_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/withdraw/withdraw_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/home_page/operation_instance.dart';
import 'package:vvault_redesign/main.dart';

import '../../../shared/ui_kit/home_page/notification_model.dart';
import '../../../shared/ui_kit/home_page/notification_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool notificationsSelected = false;
  bool isLoading = false;

  Future<void> loadAllData() async {
    setState(() {
      isLoading = true;
    });
    try {
      await Future.wait([
        Provider.of<AllMoneyProvider>(context, listen: false).fetchAllMoney("RUB"),
        Provider.of<TransactionHistoryProvider>(context, listen: false).loadTransactions(),
        Provider.of<WalletProvider>(context, listen: false).loadWallets(),
        Provider.of<NotificationsProvider>(context, listen: false).loadNotifications(),
      ]);
    } catch (error) {
      print("Failed to load data: $error");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadAllData();
  }

  Future<void> _onRefresh() async {
    await loadAllData();
  }

  Future<void> _deleteAllNotifications() async {
    await Provider.of<NotificationsProvider>(context, listen: false).deleteAllNotifications();
  }

  Future<void> _deleteNotification(String id) async {
    await Provider.of<NotificationsProvider>(context, listen: false).deleteNotification(id);
  }

  void _toggleNotificationsSelected(BuildContext context) {
    setState(() {
      notificationsSelected = !notificationsSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _wallets = Provider.of<WalletProvider>(context).wallets;
    final createWallet = Provider.of<WalletCreationProvider>(context, listen: false);
    final checkBalance = Provider.of<CheckBalanceProvider>(context, listen: false);
    final _transactions = Provider.of<TransactionHistoryProvider>(context).transactions;
    final notifications = Provider.of<NotificationsProvider>(context).notifications;

    if (isLoading) {
      return Scaffold(
        backgroundColor: Color(0xFF141619),
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

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
                        onPressedNotifications: (context) => _toggleNotificationsSelected(context),
                        onPressedScanQR: (context) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CameraPage()));
                        },
                      ),
                      SizedBox(height: 20.h),
                      notificationsSelected ? notificationsContent(notifications) : mainContent(_wallets, _transactions),
                      SizedBox(height: 30.h,),
                      Text(
                        'Cчета',
                        style: TextStyle(
                          color: Color(0xFFEDF7FF),
                          fontSize: 20.sp,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      if (_wallets.isNotEmpty) ...[
                        customCryptoWidget(
                          img: "assets/crypto logo.svg",
                          cryptoName: _wallets[0]['currency'] ?? 'N/A',
                          cryptoAmount: _wallets[0]['balance']?.toString() ?? '0.00',
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
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      _transactions.isEmpty
                          ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 100.h),
                            Text("No transactions yet", style: TextStyle(color: Color(0x7FEDF7FF), fontSize: 16.sp)),
                            SizedBox(height: 100.h),
                          ],
                        ),
                      )
                          : ListView.builder(
                        physics: ClampingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: min(_transactions.length, 4),
                        itemBuilder: (context, index) {
                          var transaction = _transactions[index];

                          return OperationInstance(
                            type: transaction['Type'] as String? ?? 'N/A',
                            username: transaction['From'] as String? ?? 'Unknown',
                            quantity: transaction['GiveAmount'] as String? ?? '0.00',
                            currency: transaction['Currency'] as String? ?? 'N/A',
                            walletAdress: transaction['data']?['wallet_address'] ?? '',
                            tx_hash: transaction['data']?['tx_hash'] ?? '',
                            dateTime: transaction['UpdatedAt'] ?? 'N/A',
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget notificationsContent(List<NotificationModel> notifications) {
    return Container(
      width: 370.w,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 9.w),
      decoration: ShapeDecoration(
        color: Color(0xFF262C35),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Уведомления',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: _deleteAllNotifications,
                child: Text(
                  'Очистить',
                  style: TextStyle(
                    color: Color(0xFF62A0FF),
                    fontSize: 12.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          if (notifications.isEmpty)
            Center(
              child: Text(
                'No notifications',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          else
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return NotificationItem(notification: notification);
              },
            ),
        ],
      ),
    );
  }

  Widget mainContent(List<dynamic> wallets, List<dynamic> transactions) {
    final allmoney = Provider.of<AllMoneyProvider>(context).allMoney;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            ),
          ],
        ),
        SizedBox(height: 30.h),
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
                "Пополнить",
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
                "Вывести",
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
                "Перевести",
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.find<NavBarVisibilityController>().hide();
                Navigator.push(context, MaterialPageRoute(builder: (context) => BillPage())).then((_) {
                  Get.find<NavBarVisibilityController>().show();
                });
              },
              child: buildHelperTool(
                "assets/dollar-sign_icon.svg",
                "Счет",
              ),
            ),
          ],
        ),
      ],
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
              child: SvgPicture.asset(img)
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          txt,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0x7FEDF7FF),
            fontSize: 12.sp,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
          ),
        ),
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
                      child: SvgPicture.asset(img),
                    ),
                  ),
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
                  formatLimit(cryptoAmount),
                  style: TextStyle(
                    color: Color(0x7FEDF7FF),
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
        if (includeDivider) ...[
          SizedBox(height: 15.h),
          Container(
            width: 350.w,
            height: 1.50.h,
            color: Color(0xFF1D2126),
          ),
        ],
      ],
    );
  }

  String formatLimit(String limit) {
    if (limit == null || limit.isEmpty) return '0.00';
    try {
      double value = double.parse(limit);
      return value.toStringAsFixed(2);
    } catch (e) {
      return '0.00';
    }
  }
}