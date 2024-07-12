import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/my_deals/deal_extended_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/update_order_activity_provider.dart';

import '../../../home_screen/presentation/p2p_market/provider/get_banks_list_provider.dart';

class DealInstance extends StatefulWidget {
  final String makerCurrency;
  final String takerCurrency;
  final String amount;
  final String price;
  final String quantity;
  final String id;
  final String status;
  final String data;
  final String req;
  final String maker_id;
  final String comment;
  final String bank;
  final String payer;

  final Function(BuildContext)? onPressed;

  @override
  _DealInstanceState createState() => _DealInstanceState();

  DealInstance({
    Key? key,
    required this.makerCurrency,
    required this.takerCurrency,
    required this.amount,
    required this.quantity,
    required this.price,
    required this.id,
    required this.status,
    required this.data,
    required this.req,
    this.onPressed,
    required this.maker_id,
    required this.comment,
    required this.bank,
    required this.payer
  }) : super(key: key);
}

class _DealInstanceState extends State<DealInstance> {
  Future<String>? userIdFuture;

  @override
  void initState() {
    super.initState();
    loadUserMe();
    loadAccountInfo(widget.id);
  }

  void loadUserMe() async {
    await Provider.of<BanksListProvider>(context, listen: false).loadUserMe();
  }

  Map<String, dynamic> getStatusProperties(String status) {
    switch (status) {
      case 'activeWithoutConfirmation':
      case 'active':
        return {'color': Color(0xFF0066FF), 'text': 'Перевод'};
      case 'notified':
        return {'color': Color(0xFF02603E), 'text': 'Подтверждение'};
      case 'approvedWithoutConfirmation':
      case 'approved':
        return {'color': Color(0xFF3E4349), 'text': 'Завершена'};
      case 'cancelledWithoutConfirmation':
      case 'cancelled':
        return {'color': Color(0xFF3E4349), 'text': 'Отменена'};
      case 'dispute':
        return {'color': Color(0xFFE93349), 'text': 'В споре'};
      case 'failed':
        return {'color': Color(0xFFE93349), 'text': 'Ошибка'};
      default:
        return {'color': Color(0xFF3E4349), 'text': 'Неизвестно'};
    }
  }

  Future<void> loadAccountInfo(String id) async {
    await Provider.of<BanksListProvider>(context, listen: false).loadAccountInfo(id);
  }

  @override
  Widget build(BuildContext context) {
    final statusProps = getStatusProperties(widget.status);
    final userme = Provider.of<BanksListProvider>(context).userme;
    final accountInfo = Provider.of<BanksListProvider>(context).accountInfo;
    bool isSell = widget.takerCurrency == 'USDT';

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DealExtended(
            dealType: statusProps['text'],
            isSell: isSell,
            dealNumber: widget.id,
            sellerAmount: widget.amount,
            sellerLogin: "poka net",
            sellerCurrency: widget.makerCurrency,
            requisiteId: widget.req,
            comment: widget.comment,
            buyerAmount: "poka net",
            bank: widget.bank,
        )
        )
        );
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isSell ? 'Продажа USDT' : 'Покупка USDT',
                style: TextStyle(
                  color: isSell ? Color(0xFFE93349): Color(0xFF05CA77),
                  fontSize: 16.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 128.w,
                height: 28.h,
                padding: EdgeInsets.only(
                  top: 5.h,
                  left: 10.w,
                  right: 10.w,
                  bottom: 10.h,
                ),
                decoration: ShapeDecoration(
                  color: statusProps['color'],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  statusProps['text'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10.h,),
          Row(
            children: [
              Text(
                'Сумма',
                style: TextStyle(
                  color: Color(0xFF8A929A),
                  fontSize: 14.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Text(
                formatLimit(widget.amount),
                style: TextStyle(
                  color: Color(0xFFEDF7FF),
                  fontSize: 14.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 5.w,),
              Text(
                widget.takerCurrency,
                style: TextStyle(
                  color: Color(0xFF8A929A),
                  fontSize: 14.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          SizedBox(height: 10.h,),
          Row(
            children: [
              Text(
                'Цена',
                style: TextStyle(
                  color: Color(0xFF8A929A),
                  fontSize: 14.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Text(
                '${formatLimit(widget.price)} ${widget.takerCurrency}',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFFEDF7FF),
                  fontSize: 12.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          SizedBox(height: 10.h,),
          Row(
            children: [
              Text(
                'Количество',
                style: TextStyle(
                  color: Color(0xFF8A929A),
                  fontSize: 14.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Text(
                '${formatLimit(widget.quantity)} ${widget.makerCurrency}',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF8A929A),
                  fontSize: 12.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          SizedBox(height: 10.h,),
          Row(
            children: [
              Text(
                'ID',
                style: TextStyle(
                  color: Color(0xFF8A929A),
                  fontSize: 14.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Text(
                widget.id,
                style: TextStyle(
                  color: Color(0xFF8A929A),
                  fontSize: 14.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          SizedBox(height: 10.h,),
          Row(
            children: [
              Text(
                accountInfo['username'] ?? "f",
                style: TextStyle(
                  color: Color(0xFF8A929A),
                  fontSize: 14.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              SvgPicture.asset("assets/message-circle.svg")
            ],
          ),
          SizedBox(height: 10.h,),
          Row(
            children: [
              Text(
                'Дата',
                style: TextStyle(
                  color: Color(0xFF8A929A),
                  fontSize: 14.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Text(
                widget.data,
                style: TextStyle(
                  color: Color(0xFF8A929A),
                  fontSize: 14.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h,),
          Divider(color: Color(0xFF262C35),),
          SizedBox(height: 10.h,)
        ],
      ),
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