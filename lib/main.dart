import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/authorization/sign_in_page.dart';
import 'package:vvault_redesign/features/authorization/sign_up_page.dart';
import 'package:vvault_redesign/features/home_page/home_screen.dart';
import 'package:vvault_redesign/features/p2p_market/my_deals/provider/my_deals_list_provider.dart';
import 'package:vvault_redesign/features/p2p_market/p2p_market_page.dart';
import 'package:vvault_redesign/features/settings_page/requisites_page/provider/new_requisite_provider.dart';
import 'package:vvault_redesign/features/settings_page/requisites_page/provider/requisites_list_provider.dart';
import 'package:vvault_redesign/features/settings_page/settings_page.dart';
import 'features/authorization/provider/auth_providers.dart';
import 'features/home_page/provider/home_page_providers.dart';
import 'features/p2p_market/provider/p2p_market_providers.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(NavBarVisibilityController());
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
        ChangeNotifierProvider(create: (context) => RequisitesProvider()),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => NotificationsProvider()),
        ChangeNotifierProvider(create: (context) => WithdrawProvider()),
        ChangeNotifierProvider(create: (context) => PaymentProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_ , child) {
          return GetMaterialApp(
            navigatorObservers: [routeObserver],
            debugShowCheckedModeBanner: false,
            title: 'First Method',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            ),
            home: child,
          );
        },
        child: SignUpPage(),
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
