import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/my_orders/my_orders_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/create_buy_order_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/create_sell_order_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/get_banks_list_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/get_fiat_currencies_provider.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar_without_avatar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/my_orders/modal_bottom_sheet.dart';
import 'package:vvault_redesign/features/shared/ui_kit/my_orders/order_instance.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_payment_methods_button.dart';

import '../provider/get_my_requisites/my_requisite.dart';
import '../provider/get_my_requisites/my_requisite_provider.dart';

class CreateOrder extends StatefulWidget {

  CreateOrder({Key? key,}) : super(key: key);

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  TextEditingController commentsController = TextEditingController();
  TextEditingController unitCostController = TextEditingController();
  TextEditingController lowerController = TextEditingController();
  TextEditingController upperController = TextEditingController();
  bool isFixed = true;
  List<String> banks = [];
  bool isBuy = true;
  String mySelectedRequisite = '';

  String selectedRequisiteId = '';
  String selectedPaymentMethod = "Выберите способ оплаты";
  final _formKey = GlobalKey<FormState>();
  String _makerCurrency = 'RUB';
  String _takerCurrency = 'USDT';
  String selectedCoin = "USDT";
  String selectedFiatCoin = 'RUB';

  void loadFiatCurrencies() async {
    await Provider.of<FiatCurrenciesListProvider>(context, listen: false).loadFiatCurrencies();
  }

  @override
  void initState() {
    loadFiatCurrencies();
    Provider.of<RequisitesProvider>(context, listen: false).fetchRequisites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    List<MyRequisite> requisites = Provider.of<RequisitesProvider>(context).requisites;

    return Scaffold(
      body: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          decoration: BoxDecoration(color: Color(0xFF141619)),
          child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBarWithoutAva(txt: "Новый ордер"),
                  SizedBox(height: 20.h,),
                  Container(
                    width: 350.w,
                    height: 1.50.h,
                    color: Color(0xFF1D2126),
                  ),
                  SizedBox(height: 20.h,),
                  Text(
                    'Тип сделки',
                    style: TextStyle(
                      color: Color(0x7FEDF7FF),
                      fontSize: 14.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isBuy = true;
                          });
                        },
                        child: Container(
                          width: 170.w,
                          height: 56.h,
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          decoration: ShapeDecoration(
                            color: isBuy ? Color(0xFF02603E) : Color(0xFF272D35),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Покупка',
                                style: TextStyle(
                                  color: isBuy ? Color(0xFFEDF7FF) : Color(0x7FEDF7FF),
                                  fontSize: 16.sp,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isBuy = false;
                          });
                        },
                        child: Container(
                          width: 170.w,
                          height: 56.h,
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          decoration: ShapeDecoration(
                            color: !isBuy ? Color(0xFF3F1C23) : Color(0xFF272D35),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Продажа',
                                style: TextStyle(
                                  color: !isBuy ? Color(0xFFEDF7FF) : Color(0x7FEDF7FF),
                                  fontSize: 16.sp,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h,),
                  if (isBuy) ... [
                    _createBuyContent(),
                  ] else ... [
                    _createSellContent()
                  ],
                  SizedBox(height: 20.h,)
                ],
              ),
            ),
          )
      ),
    );
  }

  Widget _createBuyContent() {
    final orderProvider = Provider.of<BuyOrderProvider>(context, listen: false);
    final _banks = Provider.of<BanksListProvider>(context).banks;
    final fiatCurrencies = Provider.of<FiatCurrenciesListProvider>(context).fiatCurrencies;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Монеты',
                  style: TextStyle(
                    color: Color(0x7FEDF7FF),
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h,),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return OrdersBottomSheet(
                          options: fiatCurrencies,
                          title: 'Выберите валюту',
                          searchText: "Поиск валют",
                          onSelected: (String fiatCur) {
                            setState(() {
                              selectedCoin = fiatCur;
                            });
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 170.w,
                    height: 56.h,
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.50.w, color: Color(0xFF262C35)),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          selectedCoin,
                          style: TextStyle(
                            color: Color(0x7FEDF7FF),
                            fontSize: 16.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_down_outlined, color: Color(0x7FEDF7FF),)
                      ],
                    ),
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Фиат',
                  style: TextStyle(
                    color: Color(0x7FEDF7FF),
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h,),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return OrdersBottomSheet(
                          options: fiatCurrencies,
                          title: 'Выберите валюту',
                          searchText: "Поиск валют",
                          onSelected: (String fiatCur) {
                            setState(() {
                              selectedFiatCoin = fiatCur;
                            });
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 170.w,
                    height: 56.h,
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.50.w, color: Color(0xFF262C35)),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          selectedFiatCoin,
                          style: TextStyle(
                            color: Color(0x7FEDF7FF),
                            fontSize: 16.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_down_outlined, color: Color(0x7FEDF7FF),)
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        SizedBox(height: 20.h),
        Text(
          'Цена',
          style: TextStyle(
            color: Color(0x7FEDF7FF),
            fontSize: 14.sp,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Container(
              width: 250.w,
              height: 56.h,
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.50.w, color: Color(0xFF262C35)),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: unitCostController,
                      decoration: InputDecoration(
                          hintText: 'Укажите цену',
                          hintStyle: TextStyle(
                              color: Color(0xFF8A929A)
                          ),
                          border: InputBorder.none
                      ),
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        color: Color(0xFF8A929A),
                        fontSize: 16.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    "RUB",
                    style: TextStyle(
                      color: Color(0x7FEDF7FF),
                      fontSize: 16.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w,),
            GestureDetector(
              onTap: () {
                _typeOfPrice(context);
              },
              child: Container(
                width: 90.w,
                height: 56.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.50, color: Color(0xFF262C35)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                        isFixed ? "assets/lock_icon.svg" : "assets/percent_gray.svg"
                    ),
                    Icon(Icons.keyboard_arrow_down_outlined, color: Color(0x7FEDF7FF),)
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 20.h,),
        Container(
          width: 350.w,
          height: 45.h,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: ShapeDecoration(
            color: Color(0xFF272D35),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Текущий биржевой курс  91,20  RUB/USD',
                style: TextStyle(
                  color: Color(0x7FEDF7FF),
                  fontSize: 14.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h,),
        Text(
          'Лимиты сделки',
          style: TextStyle(
            color: Color(0x7FEDF7FF),
            fontSize: 14.sp,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _limitBox(true, lowerController),
            _limitBox(false, upperController),
          ],
        ),
        SizedBox(height: 20.h,),
        Text(
          'Способы оплаты',
          style: TextStyle(
            color: Color(0x7FEDF7FF),
            fontSize: 14.sp,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 20.h,),
        GestureDetector(
          onTap: () async {
            final chosenBank = await showModalBottomSheet<String>(
              context: context,
              builder: (BuildContext context) {
                return OrdersBottomSheet(
                  options: _banks,
                  title: 'Выберите банк',
                  searchText: 'Поиск',
                  onSelected: (selectedBank) {
                    Navigator.pop(context, selectedBank);  // Ensure this is correct context
                  },
                );
              },
            );

            if (chosenBank != null && !banks.contains(chosenBank)) {
              setState(() {
                banks.add(chosenBank);
              });
            }
          },
          child: Container(
            width: 350.w,
            height: 56.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.50.w, color: Color(0xFF262C35)),
                borderRadius: BorderRadius.circular(5.r),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Выберите способ оплаты',
                  style: TextStyle(
                    color: Color(0xFF8A929A),
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
        SizedBox(height: 10.h,),
        Wrap(
          spacing: 10.w,
          runSpacing: 5.h,
          children: banks.asMap().entries.map((entry) {
            int index = entry.key;
            String label = entry.value;
            return buildLabel(label, index);
          }).toList(),
        ),
        SizedBox(height: 20.h,),
        Text(
          'Условия сделки',
          style: TextStyle(
            color: Color(0x7FEDF7FF),
            fontSize: 14.sp,
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
          ),
          child: TextField(
            controller: commentsController,
            maxLength: 300,
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
        SizedBox(height: 30.h,),
        Form(
          key: _formKey,
          child: GestureDetector(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                final orderData = {
                  'active': true,
                  'conditions': {
                    'comment': commentsController.text,
                    'lower': lowerController.text,
                    'upper': upperController.text,
                  },
                  'payment_details': {
                    'banks': banks,
                  },
                  'price': {
                    'maker_currency': selectedFiatCoin,
                    'taker_currency': selectedCoin,
                    'type': isFixed ? 'frozen' : 'unfrozen',
                    'unit_cost': unitCostController.text,
                  }
                };
                orderProvider.createBuyOrder(orderData);
              }
              Navigator.pop(context);
            },
            child: CustomButton(text: "Создать",
                clr: Color(0xFF0066FF),
                hgt: 56
            ),
          ),
        ),
      ],
    );
  }

  Widget _createSellContent() {
    final orderProvider = Provider.of<SellOrderProvider>(context, listen: false);
    final fiatCurrencies = Provider.of<FiatCurrenciesListProvider>(context).fiatCurrencies;
    List<MyRequisite> requisites = Provider.of<RequisitesProvider>(context).requisites;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Монеты',
                  style: TextStyle(
                    color: Color(0x7FEDF7FF),
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h,),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return OrdersBottomSheet(
                          options: fiatCurrencies,
                          title: 'Выберите валюту',
                          searchText: "Поиск валют",
                          onSelected: (String fiatCur) {
                            setState(() {
                              selectedCoin = fiatCur;
                            });
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 170.w,
                    height: 56.h,
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.50.w, color: Color(0xFF262C35)),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          selectedCoin,
                          style: TextStyle(
                            color: Color(0x7FEDF7FF),
                            fontSize: 16.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_down_outlined, color: Color(0x7FEDF7FF),)
                      ],
                    ),
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Фиат',
                  style: TextStyle(
                    color: Color(0x7FEDF7FF),
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h,),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return OrdersBottomSheet(
                          options: fiatCurrencies,
                          title: 'Выберите валюту',
                          searchText: "Поиск валют",
                          onSelected: (String fiatCur) {
                            setState(() {
                              selectedFiatCoin = fiatCur;
                            });
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 170.w,
                    height: 56.h,
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.50.w, color: Color(0xFF262C35)),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'RUB',
                          style: TextStyle(
                            color: Color(0x7FEDF7FF),
                            fontSize: 16.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_down_outlined, color: Color(0x7FEDF7FF),)
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        SizedBox(height: 20.h),
        Text(
          'Цена',
          style: TextStyle(
            color: Color(0x7FEDF7FF),
            fontSize: 14.sp,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Container(
              width: 250.w,
              height: 56.h,
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.50.w, color: Color(0xFF262C35)),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: unitCostController,
                      decoration: InputDecoration(
                          hintText: 'Укажите цену',
                          hintStyle: TextStyle(
                              color: Color(0xFF8A929A)
                          ),
                          border: InputBorder.none
                      ),
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        color: Color(0xFF8A929A),
                        fontSize: 16.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    "RUB",
                    style: TextStyle(
                      color: Color(0x7FEDF7FF),
                      fontSize: 16.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w,),
            GestureDetector(
              onTap: () {
                _typeOfPrice(context);
              },
              child: Container(
                width: 90.w,
                height: 56.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.50, color: Color(0xFF262C35)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                        isFixed ? "assets/lock_icon.svg" : "assets/percent_gray.svg"
                    ),
                    Icon(Icons.keyboard_arrow_down_outlined, color: Color(0x7FEDF7FF),)
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 20.h,),
        Container(
          width: 350.w,
          height: 45.h,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: ShapeDecoration(
            color: Color(0xFF272D35),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Текущий биржевой курс  91,20  RUB/USD',
                style: TextStyle(
                  color: Color(0x7FEDF7FF),
                  fontSize: 14.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h,),
        Text(
          'Лимиты сделки',
          style: TextStyle(
            color: Color(0x7FEDF7FF),
            fontSize: 14.sp,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _limitBox(true, lowerController),
            _limitBox(false, upperController),
          ],
        ),
        SizedBox(height: 20.h,),
        Text(
          'Способы оплаты',
          style: TextStyle(
            color: Color(0x7FEDF7FF),
            fontSize: 14.sp,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 20.h,),
        GestureDetector(
          onTap: () async {
            final chosenBank = await showModalBottomSheet<String>(
              context: context,
              builder: (BuildContext context) {
                return OrdersBottomSheet(
                  options: requisites.map((requisite) => requisite.bank).toList(),
                  title: 'Выберите банк',
                  searchText: 'Поиск',
                    onSelected: (selectedId) {
                      var selectedRequisite = requisites.firstWhere(
                              (requisite) => requisite.bank == requisite.bank,
                          orElse: () => MyRequisite(bank: '', comment: '', id: '', requisite: '', userId: '')
                      );
                      setState(() {
                        selectedPaymentMethod = selectedRequisite.bank; // Используем имя банка как пример
                        selectedRequisiteId = selectedRequisite.id;
                        mySelectedRequisite = selectedRequisite.requisite;
                        print(selectedRequisiteId);
                      });
                    }
                );
              },
            );
            },
          child: Container(
            width: 350.w,
            height: 56.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.50.w, color: Color(0xFF262C35)),
                borderRadius: BorderRadius.circular(5.r),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  selectedPaymentMethod,
                  style: TextStyle(
                    color: Color(0xFF8A929A),
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
        SizedBox(height: 10.h,),
        Wrap(
          spacing: 10.w,
          runSpacing: 5.h,
          children: banks.asMap().entries.map((entry) {
            int index = entry.key;
            String label = entry.value;
            return buildLabel(label, index);
          }).toList(),
        ),
        SizedBox(height: 20.h,),
        Text(
          'Условия сделки',
          style: TextStyle(
            color: Color(0x7FEDF7FF),
            fontSize: 14.sp,
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
          ),
          child: TextField(
            controller: commentsController,
            maxLength: 300,
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
        SizedBox(height: 30.h,),
        Form(
          key: _formKey,
          child: GestureDetector(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                final orderData = {
                  'active': true,
                  'conditions': {
                    'comment': commentsController.text,
                    'lower': lowerController.text,
                    'upper': upperController.text,
                  },
                  'payment_details': {
                    'requisiteIDs': [
                      selectedRequisiteId,
                    ]
                  },
                  'price': {
                    'maker_currency': _takerCurrency,
                    'taker_currency': _makerCurrency,
                    'type': 'frozen',
                    'unit_cost': unitCostController.text,
                  }
                };
                orderProvider.createSellOrder(orderData);
              }
              Navigator.pop(context);
            },
            child: CustomButton(text: "Создать",
                clr: Color(0xFF0066FF),
                hgt: 56
            ),
          ),
        ),
      ],
    );
  }

  Widget _limitBox(bool lower, TextEditingController contr) {
    return Container(
      width: 170.w,
      height: 56.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.50.w, color: Color(0xFF262C35)),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: contr,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: lower ? 'от' : 'до',
                hintStyle: TextStyle(
                  color: Color(0xFF8A929A),
                ),
              ),
              style: TextStyle(
                color: Color(0x7FEDF7FF),
                fontSize: 16.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Text(
            "RUB",
            style: TextStyle(
              color: Color(0x7FEDF7FF),
              fontSize: 16.sp,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLabel(String label, int index) {
    return IntrinsicWidth(
      child: Container(
        key: ValueKey(label),
        width: 170.w,
        height: 30.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: ShapeDecoration(
          color: Color(0xFF243248),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Color(0xFF62A0FF),
                  fontSize: 14.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () => removeLabel(index),
                child: Icon(Icons.close, color: Color(0xFF62A0FF), size: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void removeLabel(int index) {
    setState(() {
      banks.removeAt(index);
    });
  }

  Future<void> _typeOfPrice(BuildContext context) async {
    final bool? result = await showModalBottomSheet<bool> (
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.0),
        ),
        useRootNavigator: true,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return FractionallySizedBox(
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Container(
                      width: 390.w,
                      height: 220.h,
                      padding: EdgeInsets.only(
                        top: 20.h,
                        left: 20.w,
                        right: 20.w,
                        bottom: 30.h,
                      ),
                      decoration: ShapeDecoration(
                        color: Color(0xFF1D2126),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Выберите тип цены',
                            style: TextStyle(
                              color: Color(0x7FEDF7FF),
                              fontSize: 16.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context, false);
                            },
                            child: Container(
                              width: 350.w,
                              height: 50.h,
                              padding: EdgeInsets.symmetric(horizontal: 20.h),
                              decoration: ShapeDecoration(
                                color: !isFixed ? Color(0xFF1A283C) : Color(0xFF21262D),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/percent_gray.svg"),
                                  SizedBox(width: 10.w,),
                                  Text(
                                    'Плавающая цена',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(),
                                  if (!isFixed) ... [
                                    Icon(Icons.check, color: Colors.white,)
                                  ]
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context, true);
                            },
                            child: Container(
                              width: 350.w,
                              height: 50.h,
                              padding: EdgeInsets.symmetric(horizontal: 20.h),
                              decoration: ShapeDecoration(
                                color: isFixed ? Color(0xFF1A283C) : Color(0xFF21262D),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/lock_icon.svg"),
                                  SizedBox(width: 10.w,),
                                  Text(
                                    'Фиксированная цена',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(),
                                  if (isFixed) ... [
                                    Icon(Icons.check, color: Colors.white,)
                                  ]
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              )
          );
        }
    );
    if (result != null) {
      setState(() {
        isFixed = result;
      });
    }
  }

}
