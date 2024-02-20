import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/home_screen.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/api_keys_page/api_creation_confirmation.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/api_keys_page/api_have_company.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/api_keys_page/api_key_view.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/api_keys_page/api_keys_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/api_keys_page/create_api_key.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/api_keys_page/no_api_keys_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/api_keys_page/not_verified.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/api_keys_page/successfully_created_api.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/confidentiality_page/confidentiality_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/profile_page/profile_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/requisites_page/edit_requisites.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/requisites_page/empty_requisites.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/requisites_page/requisites_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/settings_page_instance.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                    CustomAppBar(img_path: "assets/avatar.png", username: "diehie"),
                  ],
                ),
              )
          ),
          Positioned(
              top: 120,
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
                  padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SettingsPageInstance(
                          icon_path: "assets/profile_icon.svg",
                          onPressed: (context) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ProfilePage())
                            );
                          },
                          txt: "Профиль"),
                      SizedBox(height: 40.h,),
                      SettingsPageInstance(
                          icon_path: "assets/confidentiality_icon.svg",
                          onPressed: (context) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ConfidentialityPage())
                            );
                          },
                          txt: "Безопасность"),
                      SizedBox(height: 40.h,),
                      SettingsPageInstance(
                          icon_path: "assets/apikey_icon.svg",
                          onPressed: (context) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SuccessfullyCreatedApi())
                            );
                          },
                          txt: "API-ключи"),
                      SizedBox(height: 40.h,),
                      SettingsPageInstance(
                          icon_path: "assets/requisites_icon.svg",
                          onPressed: (context) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => EditRequisitePage(requisite: "123"))
                            );
                          },
                          txt: "Реквизиты"),
                      SizedBox(height: 40.h,),
                      SettingsPageInstance(
                          icon_path: "assets/logout_icon.svg",
                          onPressed: (context) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomeScreen())
                            );
                          },
                          txt: "Выход"),
                    ],
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}
