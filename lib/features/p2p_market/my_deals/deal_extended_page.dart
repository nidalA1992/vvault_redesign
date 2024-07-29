import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/home_page/home_screen.dart';
import 'package:vvault_redesign/features/p2p_market/deal_canceled_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/confirmation_window.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_banks.dart';
import '../provider/deal_info/deal_info_provider.dart';
import '../provider/notify_deal/notify_deal_provider.dart';

class DealExtended extends StatefulWidget {
  final String dealNumber;
  final String? sellerAmount;
  final String? buyerAmount;
  final String? sellerLogin;
  final String? sellerCurrency;
  final String? requisiteId;
  final String? comment;
  final String? dealType;
  final bool? isSell;
  final String? bank;

  const DealExtended({
    Key? key,
    required this.dealNumber,
    this.sellerAmount,
    this.buyerAmount,
    this.sellerLogin,
    this.sellerCurrency,
    this.requisiteId,
    this.comment,
    this.dealType,
    this.isSell,
    this.bank,
  }) : super(key: key);

  @override
  _DealExtendedState createState() => _DealExtendedState();
}

class _DealExtendedState extends State<DealExtended> {
  bool isExpanded = false;
  String? dealStatus;
  Map<String, dynamic>? dealInfo;

  Future<void> loadDealDetails() async {
    await Provider.of<DealInfoProvider>(context, listen: false).fetchDealDetail(widget.dealNumber);
    final dealDetail = Provider.of<DealInfoProvider>(context, listen: false).dealDetail;
    setState(() {
      dealInfo = dealDetail != null ? {
        'sellerAmount': dealDetail.sellerAmount,
        'buyerAmount': dealDetail.buyerAmount,
        'sellerLogin': dealDetail.sellerLogin,
        'sellerCurrency': dealDetail.sellerCurrency,
        'requisiteId': dealDetail.requisiteId,
        'comment': dealDetail.comment,
        'bank': dealDetail.bank,
      } : null;
      dealStatus = dealDetail?.status;
    });
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
    final sellerAmount = widget.sellerAmount ?? dealInfo?['sellerAmount'] ?? '';
    final buyerAmount = widget.buyerAmount ?? dealInfo?['buyerAmount'] ?? '';
    final sellerLogin = widget.sellerLogin ?? dealInfo?['sellerLogin'] ?? '';
    final sellerCurrency = widget.sellerCurrency ?? dealInfo?['sellerCurrency'] ?? '';
    final requisiteId = widget.requisiteId ?? dealInfo?['requisiteId'] ?? '';
    final comment = widget.comment ?? dealInfo?['comment'] ?? '';
    final bank = widget.bank ?? dealInfo?['bank'] ?? '';
    final isSell = widget.isSell ?? dealInfo?['taker_currency'] == "USDT";

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: loadDealDetails,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.only(
            top: 80,
            left: 20,
            right: 20,
          ),
          decoration: BoxDecoration(color: Color(0xFF141619)),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_outlined,
                        color: Color(0xFF8A929A),
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Сделка #${formatLimit(widget.dealNumber)}',
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
                if (dealStatus == 'approved' || dealStatus == 'cancelled')
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dealStatus == 'approved'
                                ? 'Сделка успешно завершена'
                                : 'Сделка отменена',
                            style: TextStyle(
                              color: Color(0xFFEDF7FF),
                              fontSize: 18.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            'Продано $sellerAmount $sellerCurrency',
                            style: TextStyle(
                              color: Color(0x7FEDF7FF),
                              fontSize: 14.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      dealStatus == 'approved' ? SvgPicture.asset("assets/check-circle.svg") : SvgPicture.asset("assets/cancelled_deal.svg"),
                    ],
                  ),
                SizedBox(height: 20.h),
                ExtendableBanksList(
                  banks: [bank],
                  price: sellerAmount,
                  currency: sellerCurrency,
                  onPressed: (context) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  bank_requis: requisiteId,
                  comment: comment,
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
                          'Количество: ${formatLimit(sellerAmount)} $sellerCurrency',
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
                          'Продавец: $sellerLogin',
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
                  comment,
                  style: TextStyle(
                    color: Color(0x7FEDF7FF),
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (isSell) SizedBox(height: 110.h,) else SizedBox(height: 150.h,),
                if (isSell && dealStatus == 'notified') sellContent(sellerAmount, sellerCurrency, sellerLogin),
                if (isSell && dealStatus == 'active') buyContent(),
                SizedBox(height: 20.h,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buyContent() {
    final notificationProvider = Provider.of<NotificationProvider>(context, listen: false);
    return Column(
      children: [
        CustomButton(
          text: "Платёж выполнен",
          onPressed: (context) {
            ConfirmationWindow(
              content: 'Вы точно перевели деньги по указанным реквизитам?',
              confirmButtonText: 'Подтвердить',
              cancelButtonText: 'Отмена',
              onConfirm: () {
                notificationProvider.notifyTransfer(widget.dealNumber);
                Navigator.pop(context);
                loadDealDetails(); // Refresh deal details
              },
            ).showConfirmationDialog(context);
          },
          clr: Color(0xFF0066FF),
        ),
        SizedBox(height: 20.h,),
        GestureDetector(
          onTap: () {
            ConfirmationWindow(
              content: 'Вы точно хотите отменить сделку?',
              confirmButtonText: 'Подтвердить',
              cancelButtonText: 'Отмена',
              onConfirm: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CanceledDealPage()));
                loadDealDetails(); // Refresh deal details
              },
            ).showConfirmationDialog(context);
          },
          child: Center(
            child: Text(
              'Отменить',
              style: TextStyle(
                color: Color(0xFFEDF7FF),
                fontSize: 14.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget sellContent(String sellerAmount, String sellerCurrency, String sellerLogin) {
    return CustomButton(
      text: 'Платеж получен',
      clr: Color(0xFF0066FF),
      onPressed: (context) {
        ConfirmationWindow(
          content: 'Вы точно получили ${formatLimit(sellerAmount)} $sellerCurrency \nот пользователя $sellerLogin?',
          confirmButtonText: 'Подтвердить',
          cancelButtonText: 'Отмена',
          onConfirm: () async {
            final provider = Provider.of<DealInfoProvider>(context, listen: false);
            await provider.approveDeal(widget.dealNumber);
            Navigator.pop(context);
            loadDealDetails(); // Refresh deal details
          },
        ).showConfirmationDialog(context);
      },
    );
  }

  String formatLimit(String limit) {
    return limit.length > 10 ? limit.substring(0, 10) : limit;
  }
}
