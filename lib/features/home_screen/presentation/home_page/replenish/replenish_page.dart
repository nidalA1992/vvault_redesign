import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/get_crypto_currencies_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/wallet_by_currency_provider.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_textfield.dart';
import 'package:vvault_redesign/features/shared/ui_kit/my_orders/modal_bottom_sheet.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_field.dart';
import 'package:vvault_redesign/features/shared/ui_kit/transfer_confirmation_window.dart';
import 'package:vvault_redesign/features/shared/ui_kit/withdraw_confirmation_window.dart';

class ReplenishPage extends StatefulWidget {
  const ReplenishPage({super.key});

  @override
  State<ReplenishPage> createState() => _ReplenishPageState();
}

class _ReplenishPageState extends State<ReplenishPage> {
  String selectedCoin = "USDT";
  TextEditingController idController = TextEditingController();
  TextEditingController makerController = TextEditingController();

  void loadCryptoCurrencies() async {
    await Provider.of<CryptoCurrenciesListProvider>(context, listen: false).loadCryptoCurrencies();
  }

  void loadWalletByCurrency() async {
    await Provider.of<WalletByCurrencyProvider>(context, listen: false).fetchWallet("USDT");
  }

  @override
  void initState() {
    loadCryptoCurrencies();
    loadWalletByCurrency();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cryptoCurrencies = Provider.of<CryptoCurrenciesListProvider>(context).cryptoCurrencies;
    final walletByCurrency = Provider.of<WalletByCurrencyProvider>(context).wallet;

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
                    Center(
                      child: Text(
                        "Минимальная сумма к пополнению - 200 USDT",
                        style: TextStyle(
                          color: Color(0x7FEDF7FF),
                          fontSize: 14.sp,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Center(
                      child: Text(
                        walletByCurrency['id'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFEDF7FF),
                          fontSize: 15.sp,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Center(
                      child: Text(
                        'Ваш адрес USDT в сети TRC-20',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0x7FEDF7FF),
                          fontSize: 14.sp,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h,),
                    Center(child: SvgPicture.asset("assets/qr_borders.svg", height: 250.h,)),
                    Spacer(),
                    Center(
                      child: Text(
                        'После отправки средств проверьте баланс',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0x7FEDF7FF),
                          fontSize: 14.sp,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    CustomButton(text: "Скопировать адрес",
                        onPressed: (context) {
                          Clipboard.setData(ClipboardData(text: walletByCurrency['id']))
                              .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Color(0xFF262C35),
                                content: Text("Copied to clipboard!"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          });
                        },
                        clr: Color(0xFF262C35),
                      img_path: "assets/copy_icon.svg",
                    ),
                    SizedBox(height: 10.h,),
                    CustomButton(text: "Проверить баланс",
                        onPressed: (context) {
                          WithdrawConfirmationWindow(
                            idUser: idController.text,
                            amountRub: makerController.text,
                            amountCrypto: "${int.parse(makerController.text) * 93.50}",
                            crypto: selectedCoin,
                          ).showConfirmationDialog(context);
                        },
                        clr: Color(0xFF0066FF)
                    ),
                    SizedBox(height: 45.h,)
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }

  String formatLimit(String limit) {
    return limit.length > 10 ? limit.substring(0, 10) : limit;
  }

}
