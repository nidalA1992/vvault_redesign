import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/home_screen.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/deal_info/deal_info_provider.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_banks.dart';
import 'package:vvault_redesign/features/shared/ui_kit/timer.dart';

import '../../../shared/ui_kit/confirmation_window.dart';
import 'p2p_market_page.dart';

class SellExtended2 extends StatefulWidget {
  final String dealNumber;
  final Function(BuildContext)? onPressed;
  final String sellerAmount;
  final String sellerLogin;
  final String sellerCurrency;
  final String bank;
  final String requisite;
  final String comment;
  final String makerAmount;
  final String deal_id;

  const SellExtended2({
    Key? key,
    required this.dealNumber,
    required this.onPressed,
    required this.sellerAmount,
    required this.sellerLogin,
    required this.sellerCurrency,
    required this.bank,
    required this.requisite,
    required this.comment,
    required this.makerAmount,
    required this.deal_id,
  }) : super(key: key);

  @override
  _SellExtended2State createState() => _SellExtended2State();
}

class _SellExtended2State extends State<SellExtended2> {
  bool isExpanded = false;

  Future<void> loadDealDetails() async {
    await Provider.of<DealInfoProvider>(context, listen: false)
        .fetchDealDetail(widget.deal_id);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadDealDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dealInfo = Provider.of<DealInfoProvider>(context).dealDetail;
    print('Deal status: ${dealInfo?.status}');

    return Scaffold(
      backgroundColor: Color(0xFF141619),
      body: RefreshIndicator(
        onRefresh: loadDealDetails,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Container(
                padding: const EdgeInsets.only(
                  top: 80,
                  left: 20,
                  right: 20,
                ),
                decoration: BoxDecoration(color: Color(0xFF141619)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => widget.onPressed!(context),
                          child: Icon(
                            Icons.arrow_back_outlined,
                            color: Color(0xFF8A929A),
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Сделка #${widget.dealNumber}',
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 16.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        SizedBox(
                          width: 212.w,
                          child: Text(
                            'Ожидайте поступления средств',
                            style: TextStyle(
                              color: Color(0xFFEDF7FF),
                              fontSize: 18.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Spacer(),
                        CountdownTimer(),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    ExtendableBanksList(
                      banks: [widget.bank],
                      price: widget.makerAmount,
                      currency: "RUB",
                      onPressed: (context) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                      bank_requis: widget.requisite,
                      comment: widget.comment,
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        childrenPadding: EdgeInsets.zero,
                        title: Text(
                          'Информация о сделке',
                          style: TextStyle(
                            color: Color(0x7FEDF7FF),
                            fontSize: 12.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Color(0x7FEDF7FF),
                        ),
                        onExpansionChanged: (bool expanding) =>
                            setState(() => isExpanded = expanding),
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Количество: ${widget.sellerAmount} ${widget.sellerCurrency}',
                              style: TextStyle(
                                color: Color(0xFFEDF7FF),
                                fontSize: 14.sp,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Продавец: ${widget.sellerLogin}',
                              style: TextStyle(
                                color: Color(0xFFEDF7FF),
                                fontSize: 14.sp,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      width: 350.w,
                      height: 1.50.h,
                      color: Color(0xFF1D2126),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Условия сделки',
                      style: TextStyle(
                        color: Color(0xFFEDF7FF),
                        fontSize: 14.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      widget.comment,
                      style: TextStyle(
                        color: Color(0x7FEDF7FF),
                        fontSize: 14.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 100.h,),
                    if (dealInfo?.status == 'notified') ...[
                      notifiedContent()
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget notifiedContent() {
    return CustomButton(
      text: 'Платеж получен',
      clr: Color(0xFF0066FF),
      onPressed: (context) {
        ConfirmationWindow(
          content:
          'Вы точно получили ${widget.makerAmount} RUB \nот пользователя ${widget.sellerLogin}?',
          confirmButtonText: 'Подтвердить',
          cancelButtonText: 'Отмена',
          onConfirm: () async {
            final provider =
            Provider.of<DealInfoProvider>(context, listen: false);
            await provider.approveDeal(widget.deal_id);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (BuildContext context) => P2PMarket()),
                ModalRoute.withName('/'));
          },
        ).showConfirmationDialog(context);
      },
    );
  }
}
