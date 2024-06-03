import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/transfer_confirmation_window.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
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

        TransferConfirmationWindow(
            idUser: qrData['idUser'],
            amountRub: qrData['amountRub'],
            amountCrypto: qrData['amountCrypto'],
            crypto: qrData['crypto'],
            comment: qrData['comment']
        ).showConfirmationDialog(context);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final double scanArea = MediaQuery.of(context).size.width * 0.8;

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
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned(
                            bottom: 0,
                            child: Divider()
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 639.h,
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
                  ],
                )
              )
          ),
        ],
      ),
    );
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