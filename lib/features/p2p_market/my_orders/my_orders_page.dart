import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:vvault_redesign/features/p2p_market/my_orders/edit_order_page.dart';
import 'package:vvault_redesign/features/p2p_market/my_orders/new_order_page.dart';
import 'package:vvault_redesign/features/p2p_market/provider/p2p_market_providers.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar_without_avatar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/my_orders/order_instance.dart';

import '../../../../../main.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> with RouteAware {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool _isLoading = true;

  Future<void> _loadData() async {
    await Provider.of<OrderProvider>(context, listen: false).loadOrders(isMyOrders: true);
    setState(() {
      _isLoading = false;
    });
  }

  void loadUserMe() async {
    await Provider.of<BanksListProvider>(context, listen: false).loadUserMe();
  }

  void _onRefresh() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<OrderProvider>(context, listen: false).loadOrders(isMyOrders: true);
    setState(() {
      _isLoading = false;
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    loadUserMe();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ModalRoute? modalRoute = ModalRoute.of(context);
    if (modalRoute is PageRoute) {
      routeObserver.subscribe(this, modalRoute);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    _loadData();
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
              SizedBox(height: 20.h),
              Container(
                width: 350.w,
                height: 1.50.h,
                color: Color(0xFF1D2126),
              ),
              SizedBox(height: 20.h),
              Text(
                'Выключить все',
                style: TextStyle(
                  color: Color(0xFF62A0FF),
                  fontSize: 16.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.h),
              _isLoading
                  ? Center(child: CircularProgressIndicator(color: Colors.white))
                  : _myOrders(orders, userme),
              SizedBox(height: 20.h),
              CustomButton(
                text: "Создать объявление",
                onPressed: (context) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => CreateOrder()));
                },
                clr: Color(0xFF0066FF),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
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
              return FutureBuilder<Map<String, dynamic>>(
                future: Provider.of<OrderProvider>(context, listen: false)
                    .fetchUserStats(order['order']['maker']),
                builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox.shrink(); // Hide the circular progress indicator here
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
                                )));
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
