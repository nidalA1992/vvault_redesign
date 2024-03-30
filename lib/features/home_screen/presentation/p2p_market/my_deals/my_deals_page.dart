import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/my_deals/provider/my_deals_list_provider.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar_without_avatar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/my_deals/deal_instance.dart';

class MyDealsPage extends StatefulWidget {
  const MyDealsPage({super.key});

  @override
  State<MyDealsPage> createState() => _MyDealsPageState();
}

class _MyDealsPageState extends State<MyDealsPage> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  Future<void> _loadData() async {
    await Provider.of<DealListProvider>(context, listen: false).loadDeals();
  }

  void _onRefresh() async{
    await Provider.of<DealListProvider>(context, listen: false).loadDeals();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    await Future.delayed(Duration(milliseconds: 1000));
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deals = Provider.of<DealListProvider>(context).deals;
    print("nurali ${deals}");
    print(deals[0]['id']);

    return Scaffold(
      body: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          decoration: BoxDecoration(color: Color(0xFF141619)),
          child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBarWithoutAva(txt: "Мои сделки"),
                SizedBox(height: 20.h,),
                Container(
                  width: 350.w,
                  height: 1.50.h,
                  color: Color(0xFF1D2126),
                ),
                SizedBox(height: 20.h,),
                Row(
                  children: [
                    Text(
                      'Фильтровать по',
                      style: TextStyle(
                        color: Color(0x7FEDF7FF),
                        fontSize: 14.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Все',
                      style: TextStyle(
                        color: Color(0xFF62A0FF),
                        fontSize: 14.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    Icon(Icons.keyboard_arrow_up_outlined, color: Color(0xFF62A0FF),)
                  ],
                ),
                SizedBox(height: 10.h,),
                _myDeals(deals),

              ],
            ),
          )
      ),
    );
  }

  Widget _myDeals(List<dynamic> deals) {
    return Expanded(
      child: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        enablePullDown: true,
        enablePullUp: false,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: deals.length,
          itemBuilder: (context, index) {
            final deal = deals[index];
            return DealInstance(
              makerCurrency: deal['maker_currency'],
              takerCurrency: deal['taker_currency'],
              amount: deal['taker_get'],
              quantity: deal['taker_give'],
              price: deal['price'],
              id: deal['id'],
              data: deal['created_at'],
              status: deal['status'],
            );
          },
        ),
      ),
    );
  }
}
