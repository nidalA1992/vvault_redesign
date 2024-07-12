import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/get_banks_list_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/requisites_page/provider/new_requisite_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/settings_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_textfield.dart';
import 'package:vvault_redesign/features/shared/ui_kit/my_orders/modal_bottom_sheet.dart';
import 'package:vvault_redesign/features/shared/ui_kit/requisite_instance.dart';

class NewRequisitePage extends StatefulWidget {
  const NewRequisitePage({super.key});

  @override
  State<NewRequisitePage> createState() => _NewRequisitePageState();
}

class _NewRequisitePageState extends State<NewRequisitePage> {
  TextEditingController requisiteController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  String selectedBank = 'Выберите один банк';

  Future<void> _loadBanks() async {
    await Provider.of<BanksListProvider>(context, listen: false).loadBanks();
  }

  @override
  void initState() {
    _loadBanks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final banks = Provider.of<BanksListProvider>(context).banks;
    final requisiteProvider = Provider.of<NewRequisiteProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            'Реквизиты',
                            style: TextStyle(
                              color: Color(0xFFEDF7FF),
                              fontSize: 20.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20.h,),
                      Container(
                        width: 350.w,
                        height: 1.50.h,
                        color: Color(0xFF1D2126),
                      ),
                      SizedBox(height: 20.h,),
                      Text(
                        'Реквизиты',
                        style: TextStyle(
                          color: Color(0x7FEDF7FF),
                          fontSize: 16.sp,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      CustomTextField(
                        hintText: "Введите реквизит",
                        isHidden: false,
                        isRequisite: true,
                        controller: requisiteController,
                      ),
                      SizedBox(height: 20.h,),
                      Text(
                        'Банк оплаты',
                        style: TextStyle(
                          color: Color(0x7FEDF7FF),
                          fontSize: 16.sp,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      GestureDetector(
                        onTap: () async {
                          final chosenBank = await showModalBottomSheet<String>(
                            context: context,
                            builder: (BuildContext context) {
                              return OrdersBottomSheet(
                                options: banks,
                                title: 'Выберите банк',
                                searchText: 'Поиск',
                                onSelected: (String bank) {
                                  setState(() {
                                    selectedBank = bank;
                                  });
                                },
                              );
                            },
                          );

                          if (chosenBank != null) {
                            setState(() {
                              selectedBank = chosenBank;
                            });
                          }
                        },
                        child: Container(
                          width: 350.w,
                          height: 54.h,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          decoration: ShapeDecoration(
                            color: Color(0xFF1D2126),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedBank,
                                style: TextStyle(
                                  color: Color(0x7FEDF7FF),
                                  fontSize: 16.sp,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SvgPicture.asset("assets/search_icon.svg")
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Text(
                        'Комментарий',
                        style: TextStyle(
                          color: Color(0x7FEDF7FF),
                          fontSize: 16.sp,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Container(
                        width: 370.w,
                        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.50.w, color: Color(0xFF262C35)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          color: Color(0xFF1D2126)
                        ),
                        child: TextField(
                          controller: commentsController,
                          maxLength: 50,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: 'Напишите Ваши условия',
                            labelStyle: TextStyle(
                              color: Color(0xFF8A929A),
                              fontSize: 16.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                            counterStyle: TextStyle(
                              color: Color(0xFF8A929A),
                              fontSize: 14.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                            border: InputBorder.none,
                          ),
                          buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) => Text(
                            '${currentLength ?? 0} / ${maxLength ?? 300}',
                            style: TextStyle(
                              color: Color(0xFF8A929A),
                              fontSize: 14.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          final requisiteData = {
                            "bank": selectedBank,
                            "comment": commentsController.text,
                            "requisite": requisiteController.text,
                          };
                          requisiteProvider.createRequisite(requisiteData);
                          Navigator.pop(context, true);
                        },
                          child: CustomButton(text: "Добавить", clr: Color(0xFF0066FF))
                      ),
                      SizedBox(height: 20.h,)
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
