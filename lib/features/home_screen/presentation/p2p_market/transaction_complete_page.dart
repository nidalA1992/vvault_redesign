import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/deal_info/deal_info_provider.dart';


class TransactionCompleteScreen extends StatefulWidget {
  final String cost;
  final String dealId;

  TransactionCompleteScreen({Key? key, required this.cost, required this.dealId}) : super(key: key);

  @override
  State<TransactionCompleteScreen> createState() => _TransactionCompleteScreenState();
}

class _TransactionCompleteScreenState extends State<TransactionCompleteScreen> {
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = Stream.periodic(Duration(seconds: 5)).listen((_) {
      final provider = Provider.of<DealInfoProvider>(context, listen: false);
      provider.fetchDealDetail(widget.dealId);
      print(provider.dealDetail?.status);// Вызываем запрос для обновления данных
    });
  }

  @override
  void dispose() {
    _subscription.cancel(); // Отменяем подписку при уничтожении виджета
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff14161A),
      body: Consumer<DealInfoProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.errorMessage != null) {
            return Center(
              child: Text(provider.errorMessage!,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          } else if (provider.dealDetail != null && provider.dealDetail!.status == "approved") {
            return _buildContent(widget.cost, context);
          } else {
            return Center(child: Text("Transaction is ${provider.dealDetail?.status}",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ));
          }
        },
      ),
    );
  }

  Widget _buildContent(String cost, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: SvgPicture.asset('assets/graph.svg', height: 200.h, width: 200.w),
        ),
        SizedBox(height: 24.h),
        Text(
          'Сделка успешно завершена',
          style: TextStyle(
            fontSize: 24.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          'На ваш счёт зачислено\n${cost} RUB',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.white,
          ),
        ),
        Spacer(),
        Text(
          'Оцените, как прошла Ваша сделка',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.thumb_up),
              color: Colors.green,
              onPressed: () {
                // Handle "thumb up" action
              },
            ),
            SizedBox(width: 12.w),
            IconButton(
              icon: Icon(Icons.thumb_down),
              color: Colors.red,
              onPressed: () {
                // Handle "thumb down" action
              },
            ),
          ],
        ),
        Spacer(),
        Container(
          width: 350.w,
          height: 60.h,
          decoration: BoxDecoration(
              color: Color(0xff0066FF),
              borderRadius: BorderRadius.circular(5)
          ),
          child: Center(
            child: Text('Вернуться', style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600
            )),
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
