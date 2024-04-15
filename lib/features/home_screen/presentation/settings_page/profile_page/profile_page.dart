import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/profile_page/own_company_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/profile_page/status_extended_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> currencyList = ['USD', 'EUR', 'GBP', 'RUB'];
  String? selectedCurrency = 'RUB';
  List<String> themeList = ['Темная', "Светлая"];
  String? selectedTheme = "Темная";
  List<String> languageList = ["RUS", "KAZ", "ENG"];
  String? selectedLanguage = "RUS";


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
                    CustomAppBar(img_path: "assets/avatar.png"),
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
                          'Профиль',
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
                        Text(
                          'Минимальный',
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 24.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Text(
                          'Ваш статус',
                          style: TextStyle(
                            color: Color(0x7FEDF7FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Row(
                          children: [
                            SvgPicture.asset("assets/check_icon.svg"),
                            SizedBox(width: 10.w,),
                            SizedBox(
                              width: 320.w,
                              child: Text(
                                'Оплачивайте товары и услуги, переводите деньги, пополняйте баланс через P2P',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 14.sp,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20.h,),
                        Row(
                          children: [
                            SvgPicture.asset("assets/angle-up_icon.svg"),
                            SizedBox(width: 10.w,),
                            SizedBox(
                              width: 310.w,
                              child: Text(
                                'Повысьте аккаунт до основного для пополнение через  BlockChain, создания объявлений и выставления счетов',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 14.sp,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h,),
                        CustomButton(text: "Узнать больше", clr: Color(0xFF0066FF),
                            onPressed: (context) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => StatusExntended()));
                            }),
                        SizedBox(height: 40.h,),
                        Text(
                          'У вас своя компания?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        SizedBox(
                          width: 335,
                          child: Text(
                            'Подключайте SENPAY и получайте платежи в криптовалюте мгновенно! ',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 14.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        CustomButton(text: "Узнать больше", clr: Color(0xFF0066FF),
                            onPressed: (context) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => OwnCompany()));
                            }),
                        SizedBox(height: 40.h,),
                        Text(
                          'Управление профилем',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Row(
                          children: [
                            Text(
                              'Валюта по умолчанию',
                              style: TextStyle(
                                color: Color(0x7FEDF7FF),
                                fontSize: 14.sp,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                              height: 20.h,
                              child: dropDownMenu(selectedCurrency, currencyList, (newValue) {
                                setState(() {
                                  selectedCurrency = newValue;
                                });
                              }),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          children: [
                            Text(
                              'Цвет темы',
                              style: TextStyle(
                                color: Color(0x7FEDF7FF),
                                fontSize: 14.sp,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                              height: 20.h,
                              child: dropDownMenu(selectedTheme, themeList, (newValue) {
                                setState(() {
                                  selectedTheme = newValue;
                                });
                              }),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          children: [
                            Text(
                              'Язык по умолчанию',
                              style: TextStyle(
                                color: Color(0x7FEDF7FF),
                                fontSize: 14.sp,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                              height: 20.h,
                              child: dropDownMenu(selectedLanguage, languageList, (newValue) {
                                setState(() {
                                  selectedLanguage = newValue;
                                });
                              }),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h,)
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

  Widget dropDownMenu(String? selectedValue, List<String> lst, Function(String?) onSelected) {
    return DropdownButton<String>(
      value: selectedValue,
      icon: const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14.sp,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500,
      ),
      underline: Container(),
      onChanged: (String? newValue) {
        onSelected(newValue);
      },
      dropdownColor: Color(0xFF1D2126),
      items: lst.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
