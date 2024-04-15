import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/get_crypto_currencies_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/wallet_by_currency_provider.dart';
import 'package:vvault_redesign/features/shared/ui_kit/confirmation_window.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_textfield.dart';
import 'package:vvault_redesign/features/shared/ui_kit/my_orders/modal_bottom_sheet.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_converter.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_field.dart';
import 'package:vvault_redesign/features/shared/ui_kit/transfer_confirmation_window.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  String selectedCoin = "USDT";
  TextEditingController idController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  TextEditingController takerController = TextEditingController();
  TextEditingController _makerController = TextEditingController();
  double usdToRubRate = 93.50;
  bool isTakerActive = false;
  bool isMakerActive = false;
  bool qrSelected = true;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      print('QR Code Data: ${scanData.code}');
      controller.pauseCamera();

      final qrData = jsonDecode(scanData.code ?? '{}');

      if (qrData != null && qrData['idUser'] != null && qrData['amountRub'] != null &&
          qrData['amountCrypto'] != null && qrData['crypto'] != null && qrData['comment'] != null) {

        setState(() {
          idController.text = qrData['idUser'];
          takerController.text = qrData['amountRub'];
          _makerController.text = qrData['amountCrypto'];
          selectedCoin = qrData['crypto'];
          commentsController.text = qrData['comment'];
        });

        TransferConfirmationWindow(
            idUser: idController.text,
            amountRub: takerController.text,
            amountCrypto: _makerController.text,
            crypto: selectedCoin,
            comment: commentsController.text
        ).showConfirmationDialog(context);
      }
    });
  }


  void loadCryptoCurrencies() async {
    await Provider.of<CryptoCurrenciesListProvider>(context, listen: false).loadCryptoCurrencies();
  }

  void loadWalletByCurrency() async {
    await Provider.of<WalletByCurrencyProvider>(context, listen: false).fetchWallet("USDT");
  }

  void _onTakerChanged() {
    if (isMakerActive) return;

    double takerValue = double.tryParse(takerController.text) ?? 0.0;
    double makerValue = takerValue / usdToRubRate;
    _makerController.text = makerValue.toString();
  }

  void _onMakerChanged() {
    if (isTakerActive) return;

    double makerValue = double.tryParse(_makerController.text) ?? 0.0;
    double takerValue = makerValue * usdToRubRate;
    takerController.text = takerValue.toString();
  }

  @override
  void initState() {
    loadCryptoCurrencies();
    loadWalletByCurrency();
    takerController.addListener(() {
      isTakerActive = true;
      _onTakerChanged();
      isTakerActive = false;
    });
    _makerController.addListener(() {
      isMakerActive = true;
      _onMakerChanged();
      isMakerActive = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.only(top: 50.h, bottom: 20.h),
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
                          'Перевод пользователю',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              qrSelected = true;
                            });
                          },
                            child: Container(
                              width: 170.w,
                              height: 46.h,
                              decoration: ShapeDecoration(
                                color: qrSelected ? Color(0xFF0066FF) : Color(0xFF262C35),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Сканировать QR",
                                    style: TextStyle(
                                      color: qrSelected ? Colors.white : Color(0x7FEDF7FF),
                                      fontSize: 16.sp,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              qrSelected = false;
                            });
                          },
                            child: Container(
                              width: 170.w,
                              height: 46.h,
                              decoration: ShapeDecoration(
                                color: qrSelected ? Color(0xFF262C35): Color(0xFF0066FF),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "По реквизитам",
                                    style: TextStyle(
                                      color: qrSelected ? Color(0x7FEDF7FF) : Colors.white,
                                      fontSize: 16.sp,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            )
                        )
                      ],
                    ),
                    SizedBox(height: 20.h,),
                    if (qrSelected) ... [
                      _buildQrContent()
                    ] else ... [
                      _buildReqContent()
                    ]
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }

  Widget _buildQrContent() {
    final double scanArea = MediaQuery.of(context).size.width * 0.8;

    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
              bottom: 0,
              child: Divider()
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 408.h,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Center(
            child: Container(
              width: scanArea * 0.7,
              height: scanArea * 0.7,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.transparent,
                  width: 0,
                ),
              ),
              child: CustomPaint(
                painter: QrBorderPainter(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReqContent() {
    final cryptoCurrencies = Provider.of<CryptoCurrenciesListProvider>(context).cryptoCurrencies;
    final walletByCurrency = Provider.of<WalletByCurrencyProvider>(context).wallet;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        CustomTextField(hintText: 'ID пользователя Sentoke', isHidden: false, controller: idController,),
        SizedBox(height: 20.h,),
        BuySellField(hint_txt: "Сумма", isBuy: true, fiat: selectedCoin, textController: _makerController),
        SizedBox(height: 10.h,),
        BuySellField(hint_txt: "Сумма", isBuy: true, fiat: "RUB", textController: takerController),
        SizedBox(height: 30.h,),
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
        SizedBox(height: 70.h,),
        CustomButton(text: "Далее",
            onPressed: (context) {
              TransferConfirmationWindow(
                  idUser: idController.text,
                  amountRub: takerController.text,
                  amountCrypto: _makerController.text,
                  crypto: selectedCoin,
                  comment: commentsController.text
              ).showConfirmationDialog(context);
            },
            clr: Color(0xFF0066FF)
        ),
        SizedBox(height: 20.h,)
      ],
    );
  }

  String formatLimit(String limit) {
    return limit.length > 10 ? limit.substring(0, 10) : limit;
  }

}

class QrBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    canvas.drawLine(Offset(0, 0), Offset(0, 30), paint);
    canvas.drawLine(Offset(0, 0), Offset(30, 0), paint);

    canvas.drawLine(Offset(size.width, 0), Offset(size.width - 30, 0), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, 30), paint);

    canvas.drawLine(Offset(0, size.height), Offset(0, size.height - 30), paint);
    canvas.drawLine(Offset(0, size.height), Offset(30, size.height), paint);

    canvas.drawLine(Offset(size.width, size.height), Offset(size.width, size.height - 30), paint);
    canvas.drawLine(Offset(size.width, size.height), Offset(size.width - 30, size.height), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}