import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/p2p_market/provider/p2p_market_providers.dart';
import 'package:vvault_redesign/features/shared/ui_kit/home_page/operation_extended_window.dart';


class OperationInstance extends StatefulWidget {
  final String type;
  final String username;
  final String quantity;
  final String currency;
  final String walletAdress;
  final String tx_hash;
  final String dateTime;

  const OperationInstance({
    Key? key,
    required this.type,
    required this.username,
    required this.quantity,
    required this.currency,
    required this.walletAdress,
    required this.tx_hash,
    required this.dateTime,
  }) : super(key: key);

  @override
  State<OperationInstance> createState() => _OperationInstanceState();
}

class _OperationInstanceState extends State<OperationInstance> {
  Future<String>? userIdFuture;

  @override
  void initState() {
    super.initState();
    userIdFuture = loadId();
  }

  Future<String> loadId() async {
    await Provider.of<BanksListProvider>(context, listen: false).loadUserMe();
    final userme = Provider.of<BanksListProvider>(context, listen: false).userme;
    if (userme != null && userme.containsKey('id')) {
      return userme['id'];
    } else {
      throw Exception('User ID not found');
    }
  }

  Color _getColorFromType(String type, String userId) {
    switch (type) {
      case 'deal':
        return userId == widget.username ? Color(0xFF14A769) : Color(0xFFE93349);
      case 'payment':
        return userId == widget.username ? Color(0xFFE93349) : Color(0xFF14A769);
      case 'exchange':
        return Color(0xFF14A769);
      case 'withdraw':
        return Color(0xFF0066FF);
      case 'deposit':
        return Color(0xFF0066FF);
      case 'transfer':
        return userId == widget.username ? Color(0xFF14A769) : Color(0xFFE93349);
      case 'freezing':
        return Color(0xFFE93349);
      case 'payment_deal':
        return Color(0xFFE93349);
      default:
        return Color(0xFF0066FF);
    }
  }

  String _getImagePath(String type, String userId) {
    switch (type) {
      case 'deal':
        return "assets/users_white.svg";
      case 'payment':
        return "assets/download_icon.svg";
      case 'exchange':
        return "assets/vyvesti_icon.svg";
      case 'withdraw':
        return "assets/ver2_upload.svg";
      case 'deposit':
        return "assets/download_icon.svg";
      case 'transfer':
        return userId == widget.username ? "assets/arrow-right.svg" : "assets/arrow-left.svg";
      case 'freezing':
        return "assets/vyvesti_icon.svg";
      case 'payment_deal':
        return "assets/download_icon.svg";
      default:
        return "something is wrong";
    }
  }

  String _getTitle(String type, String userId) {
    switch (type) {
      case 'deal':
        return userId == widget.username ? "Покупка криптовалюты Р2Р" : "Продажа криптовалюты Р2Р";
      case 'payment':
        return userId == widget.username ? "Оплата через Senpay" : "Поступление через Senpay";
      case 'exchange':
        return "assets/vyvesti_icon.svg";
      case 'withdraw':
        return "Вывод средств через \nBlockchain";
      case 'deposit':
        return "Поступление через \nBlokchain";
      case 'transfer':
        return userId == widget.username ? "Исходящий перевод" : "Входящий перевод";
      case 'freezing':
        return "assets/vyvesti_icon.svg";
      case 'payment_deal':
        return "Платеж через SenPay";
      default:
        return "something is wrong";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: userIdFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: Colors.white,));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return Text('No user ID found');
        } else {
          Color clr = _getColorFromType(widget.type, snapshot.data!);
          String imgPath = _getImagePath(widget.type, snapshot.data!);
          String title = _getTitle(widget.type, snapshot.data!);

          return GestureDetector(
            onTap: () {
              final operationWindow = OperationExtendedWindowWindow(
                title: title,
                amountCrypto: widget.quantity,
                walletAddress: widget.walletAdress,
                tx_hash: widget.tx_hash,
                idUser: snapshot.data!,
                dateTime: widget.dateTime,
              );

              operationWindow.showConfirmationDialog(context);
            },
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 35.w,
                      height: 35.h,
                      decoration: ShapeDecoration(
                        color: clr,
                        shape: CircleBorder(),
                      ),
                      child: Center(
                        child: SvgPicture.asset(imgPath),
                      ),
                    ),
                    SizedBox(width: 10.w,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: Color(0x7FEDF7FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (widget.type == 'incoming' || widget.type == 'outgoing') ... [
                          Text(
                            widget.username,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFEDF7FF),
                              fontSize: 14.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ]
                      ],
                    ),
                    Spacer(),
                    Text(
                      formatLimit(widget.quantity),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFFEDF7FF),
                        fontSize: 16.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 3.w,),
                    Text(
                      widget.currency,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0x7FEDF7FF),
                        fontSize: 12.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.h,),
                Container(
                  width: 350.w,
                  height: 1.50.h,
                  color: Color(0xFF1D2126),
                ),
                SizedBox(height: 10.h,)
              ],
            ),
          );
        }
      },
    );
  }

  String formatLimit(String limit) {
    if (limit == null || limit.isEmpty) return '0.00';
    try {
      double value = double.parse(limit);
      return value.toStringAsFixed(2);
    } catch (e) {
      return '0.00';
    }
  }
}
