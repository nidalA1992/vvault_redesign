import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/shared/ui_kit/bill_confirmation_window.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/my_orders/modal_bottom_sheet.dart';

import '../provider/home_page_providers.dart';

class BillPage extends StatefulWidget {
  const BillPage({super.key});

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  String selectedCoin = "USDT";
  TextEditingController idController = TextEditingController();
  TextEditingController makerController = TextEditingController();
  String? currentError;
  double usdToRubRate = 1/93.50;
  bool isMakerActive = false;
  bool isTakerActive = false;
  TextEditingController takerController = TextEditingController();
  Timer? _debouncer;

  void loadCryptoCurrencies() async {
    await Provider.of<CryptoCurrenciesListProvider>(context, listen: false).loadCryptoCurrencies();
  }

  void loadWalletByCurrency() async {
    await Provider.of<WalletByCurrencyProvider>(context, listen: false).fetchWallet("USDT");
  }

  void _onMakerChanged() {
    if (_debouncer?.isActive ?? false) _debouncer!.cancel();
    _debouncer = Timer(const Duration(milliseconds: 300), () {
      if (isTakerActive) return;
      double makerValue = double.tryParse(makerController.text) ?? 0.0;
      double takerValue = makerValue * usdToRubRate;
      setState(() {
        takerController.text = takerValue.toStringAsFixed(2);
      });
    });
  }

  @override
  void initState() {
    loadCryptoCurrencies();
    loadWalletByCurrency();
    makerController.addListener(() {
      isMakerActive = true;
      _onMakerChanged();
      isMakerActive = false;
    });
    super.initState();
  }

  @override
  void dispose() {
    takerController.dispose();
    makerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cryptoCurrencies = Provider.of<CryptoCurrenciesListProvider>(context).cryptoCurrencies;
    final walletByCurrency = Provider.of<WalletByCurrencyProvider>(context).wallet;

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
                  padding: EdgeInsets.only(top: 50.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            'Пополнить кошелёк',
                            style: TextStyle(
                              color: Color(0xFFEDF7FF),
                              fontSize: 20.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
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
                        'Выберите криптовалюту',
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
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return OrdersBottomSheet(
                                    options: cryptoCurrencies,
                                    title: 'Выберите валюту',
                                    searchText: "Поиск валют",
                                    onSelected: (String fiatCur) {
                                      setState(() {
                                        selectedCoin = fiatCur;
                                        loadWalletByCurrency();
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
                          ),
                          Row(
                            children: [
                              SvgPicture.asset("assets/crypto logo.svg"),
                              SizedBox(width: 15.w,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    walletByCurrency['currency'] ?? "Unknown",
                                    style: TextStyle(
                                      color: Color(0xFFEDF7FF),
                                      fontSize: 18.sp,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    formatLimit(walletByCurrency['balance']),
                                    style: TextStyle(
                                      color: Color(0x7FEDF7FF),
                                      fontSize: 16.sp,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Сумма в валюте',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SvgPicture.asset("assets/Vector 49.svg"),
                          Text(
                            'Сумма в криптовалюте',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 14.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20.h,),
                      Container(
                        width: 350.w,
                        height: 51.h,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: ShapeDecoration(
                          color: Color(0xFF272D35),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            makerController.text.isEmpty
                                ? Row(
                              children: [
                                SvgPicture.asset("assets/edit_icon.svg"),
                                SizedBox(width: 10.w,)
                              ],
                            )
                                : SizedBox.shrink(),
                            Expanded(
                              child: TextField(
                                controller: makerController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                onChanged: (value) {
                                  if (!isTakerActive) {
                                    setState(() {
                                      _onMakerChanged();
                                    });
                                  }
                                },
                                style: TextStyle(
                                  color: Color(0xFF8A929A),
                                  fontSize: 14.sp,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Сумма",
                                  hintStyle: TextStyle(
                                    color: Color(0xFF8A929A),
                                  ),
                                  errorText: currentError,
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              '~ ${takerController.text} $selectedCoin',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              height: 20.h,
                              width: 1.w,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              color: Color(0xFF8A929A),
                            ),
                            GestureDetector(
                              // onTap: () => widget.textController.text = widget.maxLimit.toString(),
                              child: Text(
                                '$selectedCoin',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      CustomButton(text: "Получить ссылку на оплату",
                          onPressed: (context) {
                            BillConfirmationWindow(
                              idUser: idController.text,
                              amountRub: makerController.text,
                              amountCrypto: takerController.text,
                              crypto: selectedCoin,
                            ).showConfirmationDialog(context);
                          },
                          clr: Color(0xFF0066FF)
                      ),
                      SizedBox(height: 47.h,)
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }

  String formatLimit(String? limit) {
    if (limit == null) return 'Not set';
    return limit.length > 10 ? limit.substring(0, 10) : limit;
  }

}
