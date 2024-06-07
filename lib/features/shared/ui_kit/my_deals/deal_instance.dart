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
    required this.maker_id
  }) : super(key: key);
}

class _DealInstanceState extends State<DealInstance> {
  Future<String>? userIdFuture;

  @override
  void initState() {
    super.initState();
    loadUserMe();
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


  @override
  Widget build(BuildContext context) {
    final statusProps = getStatusProperties(widget.status);
    final userme = Provider.of<BanksListProvider>(context).userme;
    bool isSell = userme['id'] == widget.maker_id;

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DealExtended(
            dealType: statusProps['text'],
            isSell: !isSell,
            dealNumber: widget.id,
            sellerAmount: widget.amount,
            sellerLogin: "poka net",
            sellerCurrency: widget.makerCurrency,
            requisiteId: widget.req,
            comment: "poka net",
            buyerAmount: "poka net"
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
                isSell ? 'Продажа ${widget.makerCurrency}' : 'Покупка ${widget.takerCurrency}',
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
                  left: 20.w,
                  right: 20.w,
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
                'Zaluper_312_cu8m',
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
    return limit.length > 10 ? limit.substring(0, 10) : limit;
  }

}