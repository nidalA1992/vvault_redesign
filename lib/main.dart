import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/home_screen.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/p2p_market_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/settings_page.dart';

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
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child: NavBar(),
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
