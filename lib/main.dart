import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/authorization/provider/sign_in_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/authorization/sign_in_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/home_screen.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/all_money_1value_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/check_balance_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/create_wallet_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/get_crypto_currencies_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/get_user_wallets_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/transaction_history_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/transfer_currency_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/wallet_by_currency_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/loading_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/my_deals/provider/my_deals_list_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/my_orders/new_order_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/p2p_market_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/create_buy_order_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/create_sell_order_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/deal_info/deal_info_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/get_banks_list_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/get_fiat_currencies_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/order_info/order_info_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/orders_list_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/update_order_activity_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/update_order_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/confidentiality_page/change_mail/change_mail_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/requisites_page/provider/new_requisite_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/requisites_page/provider/requisites_list_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/settings_page.dart';

import 'features/home_screen/presentation/p2p_market/provider/deal_from_order/deal_from_order_provider.dart';
import 'features/home_screen/presentation/p2p_market/provider/notify_deal/notify_deal_provider.dart';
import 'features/home_screen/presentation/p2p_market/provider/user_requisite_list/user_requisite_provider.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(NavBarVisibilityController());
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignInProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => BuyOrderProvider()),
        ChangeNotifierProvider(create: (context) => SellOrderProvider()),
        ChangeNotifierProvider(create: (context) => BanksListProvider()),
        ChangeNotifierProvider(create: (context) => UpdateOrderProvider()),
        ChangeNotifierProvider(create: (context) => FiatCurrenciesListProvider()),
        ChangeNotifierProvider(create: (context) => UserRequisiteProvider()),
        ChangeNotifierProvider(create: (context) => OrderInfoProvider()),
        ChangeNotifierProvider(create: (context) => DealProvider()),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
        ChangeNotifierProvider(create: (context) => UpdateOrderActivityProvider()),
        ChangeNotifierProvider(create: (context) => NewRequisiteProvider()),
        ChangeNotifierProvider(create: (context) => RequisitesListProvider()),
        ChangeNotifierProvider(create: (context) => AllMoneyProvider()),
        ChangeNotifierProvider(create: (context) => WalletProvider()),
        ChangeNotifierProvider(create: (context) => WalletCreationProvider()),
        ChangeNotifierProvider(create: (context) => DealListProvider()),
        ChangeNotifierProvider(create: (context) => DealInfoProvider()),
        ChangeNotifierProvider(create: (context) => CheckBalanceProvider()),
        ChangeNotifierProvider(create: (context) => WalletByCurrencyProvider()),
        ChangeNotifierProvider(create: (context) => TransferCurrencyProvider()),
        ChangeNotifierProvider(create: (context) => TransactionHistoryProvider()),
        ChangeNotifierProvider(create: (context) => CryptoCurrenciesListProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_ , child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'First Method',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            ),
            home: child,
          );
        },
        child: SignInPage(),
      ),
    );
  }
}

class NavBarVisibilityController extends GetxController {
  var isVisible = true.obs;
  void hide() => isVisible.value = false;
  void show() => isVisible.value = true;
}


class NavBar extends StatelessWidget {
  NavBar({Key? key}) : super(key: key);

  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  final NavBarVisibilityController navBarVisibilityController = Get.find<NavBarVisibilityController>();

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      P2PMarket(),
      SettingsPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset("assets/wallet_icon.svg"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Color(0xFF8A929A),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset("assets/p2p_icon.svg"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Color(0xFF8A929A),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset("assets/settings_icon.svg"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Color(0xFF8A929A),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Color(0xFF262C35),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBar: !navBarVisibilityController.isVisible.value,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0),
        colorBehindNavBar: Color(0xFF262C35),
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6, // The NavBarStyle should be adjusted to match the style in the attachment.
    ));
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
