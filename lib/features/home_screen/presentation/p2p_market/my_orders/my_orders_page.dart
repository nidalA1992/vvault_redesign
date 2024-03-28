import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/my_orders/edit_order_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/my_orders/new_order_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/get_banks_list_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/orders_list_provider.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar_without_avatar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/my_orders/order_instance.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  Future<void> _loadData() async {
    await Provider.of<OrderProvider>(context, listen: false).loadOrders(isMyOrders: true);
  }

  void loadUserMe() async {
    await Provider.of<BanksListProvider>(context, listen: false).loadUserMe();
  }

  void _onRefresh() async{
    await Provider.of<OrderProvider>(context, listen: false).loadOrders();
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
    loadUserMe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrderProvider>(context).orders;
    final userme = Provider.of<BanksListProvider>(context).userme;

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
                CustomAppBarWithoutAva(txt: "Мои ордера"),
                SizedBox(height: 20.h,),
                Container(
                  width: 350.w,
                  height: 1.50.h,
                  color: Color(0xFF1D2126),
                ),
                SizedBox(height: 20.h,),
                Text(
                  'Выключить все',
                  style: TextStyle(
                    color: Color(0xFF62A0FF),
                    fontSize: 16.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h,),
                _myOrders(orders, userme),
                SizedBox(height: 20.h,),
                CustomButton(text: "Создать объявление",
                    onPressed: (context) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CreateOrder()));
                    },
                    clr: Color(0xFF0066FF)
                ),
                SizedBox(height: 20.h,),
              ],
            ),
          )
      ),
    );
  }

  Widget _myOrders(List<dynamic> orders, Map<String, dynamic> userme) {
    return Expanded(
      child: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        enablePullDown: true,
        enablePullUp: false,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: orders.length,
          itemBuilder: (context, index) {
            if (orders[index]['order']['maker'] != userme['id']) {
              return SizedBox.shrink();
            } else {
              final order = orders[index];
              return FutureBuilder<String>(
                future: Provider.of<OrderProvider>(context, listen: false).fetchUserStats(order['order']['maker']),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return OrderInstance(
                      price: order['order']['price'],
                      priceCurrency: order['order']['maker_currency'],
                      onPressed: (context) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditOrderPage(
                                    price: order['order']['price'],
                                    priceCurrency: order['order']['maker_currency'],
                                    banks: order['order']['banks'],
                                    titleCurrency: order['order']['maker_currency'],
                                    lowerLimit: order['order']['lower'],
                                    upperLimit: order['order']['upper'],
                                    comment: order['order']['comment'],
                                    orderID: order['order']['id'],
                                )
                            )
                        );
                      },
                      banks: order['order']['banks'],
                      isActive: order['order']['active'],
                      titleCurrency: order['order']['maker_currency'],
                      isBuy: order['order']['maker_currency_type'] == 'crypto',
                      lowerLimit: order['order']['lower'],
                      upperLimit: order['order']['upper'],
                      comment: order['order']['comment'],
                      orderID: order['order']['id'],
                    );
                }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
