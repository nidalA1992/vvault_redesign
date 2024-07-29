import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/p2p_market/buy_extended.dart';
import 'package:vvault_redesign/features/p2p_market/my_deals/my_deals_page.dart';
import 'package:vvault_redesign/features/p2p_market/my_orders/my_orders_page.dart';
import 'package:vvault_redesign/features/p2p_market/provider/p2p_market_providers.dart';
import 'package:vvault_redesign/features/p2p_market/sell_extended.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/my_orders/modal_bottom_sheet.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_order_instance.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../home_page/provider/home_page_providers.dart';

class P2PMarket extends StatefulWidget {
  const P2PMarket({super.key});

  @override
  State<P2PMarket> createState() => _P2PMarketState();
}

class _P2PMarketState extends State<P2PMarket> {
  bool isPurchaseSelected = true;
  String selectedCurrency = 'USDT';
  String selectedValuta = 'KZT';
  TextEditingController searchController1 = TextEditingController();
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  String? selectedBank;
  String? selectedFiatCurrency = "RUB";
  String? enteredPrice;
  bool isLoading = false; // Loading state flag

  void loadBanksList() async {
    await Provider.of<BanksListProvider>(context, listen: false).loadBanks();
  }

  void loadFiatCurrencies() async {
    await Provider.of<FiatCurrenciesListProvider>(context, listen: false).loadFiatCurrencies();
  }

  void loadCryptoCurrencies() async {
    await Provider.of<CryptoCurrenciesListProvider>(context, listen: false).loadCryptoCurrencies();
  }

  void _onRefresh() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<OrderProvider>(context, listen: false).loadOrders(price: enteredPrice);
    _refreshController.refreshCompleted();
    setState(() {
      isLoading = false;
    });
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    loadBanksList();
    loadFiatCurrencies();
    loadCryptoCurrencies();
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<OrderProvider>(context, listen: false).loadOrders(price: enteredPrice);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final orders = Provider.of<OrderProvider>(context).orders;
    final banks = Provider.of<BanksListProvider>(context).banks;
    final fiatCurrencies = Provider.of<FiatCurrenciesListProvider>(context).fiatCurrencies;
    final cryptoCurrencies = Provider.of<CryptoCurrenciesListProvider>(context).cryptoCurrencies;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
              width: double.infinity,
              height: 0.3.sh,
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(color: Color(0xFF1D2126)),
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    CustomAppBar(
                      img_path: "assets/avatar.png",
                      isP2P: true,
                      onPressedOrders: (context) {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => MyOrdersPage()));
                      },
                      onPressedDeals: (context) {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => MyDealsPage()));
                      },
                    ),
                  ],
                ),
              )),
          Positioned(
              top: 110,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: Color(0xFF141619),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => setState(() {
                              isPurchaseSelected = !isPurchaseSelected;
                              enteredPrice = null;
                            }),
                            child: Container(
                              width: 199.75.w,
                              height: 31.h,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1.w,
                                      color: isPurchaseSelected
                                          ? Color(0xFF05CA77)
                                          : Color(0xFF7F2531)),
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: isPurchaseSelected
                                        ? purchaseContainer(Color(0x4C05CA77), Color(0xFF05CA77),
                                        'Покупка')
                                        : saleContainer(Colors.white, 'Покупка'),
                                  ),
                                  Expanded(
                                    child: isPurchaseSelected
                                        ? saleContainer(Colors.white, 'Продажа')
                                        : purchaseContainer(Color(0xFF3F1C23),
                                        Color(0xFFE93349), 'Продажа'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return OrdersBottomSheet(
                                    options: cryptoCurrencies,
                                    title: 'Выберите криптовалюту',
                                    searchText: "Поиск монет",
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: 126.w,
                              height: 31.h,
                              decoration: BoxDecoration(
                                color: Color(0xFF1D2126),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/crypto logo.svg"),
                                  Text(
                                    selectedCurrency,
                                    style: TextStyle(
                                      color: Color(0xFF8A929A),
                                      fontSize: 12.sp,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Icon(Icons.keyboard_arrow_down_outlined,
                                    color: Color(0xFF8A929A), size: 16.sp,),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _bottomSheetEnterPrice(context);
                            },
                            child: Text(
                              'Введите сумму',
                              style: TextStyle(
                                color: Color(0xFF8A929A),
                                fontSize: 12.sp,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return OrdersBottomSheet(
                                    options: fiatCurrencies,
                                    title: 'Выберите валюту',
                                    searchText: "Поиск валют",
                                    onSelected: (String fiatCur) {
                                      setState(() {
                                        selectedFiatCurrency = fiatCur;
                                      });
                                    },
                                  );
                                },
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  selectedFiatCurrency.toString(),
                                  style: TextStyle(
                                    color: Color(0xFF8A929A),
                                    fontSize: 12.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Icon(Icons.keyboard_arrow_down_outlined,
                                  color: Color(0xFF8A929A), size: 16.sp,),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return OrdersBottomSheet(
                                    options: banks,
                                    title: 'Выберите банк',
                                    searchText: 'Поиск',
                                    onSelected: (String bank) {
                                      setState(() {
                                        selectedBank = bank;
                                      });
                                    },
                                  );
                                },
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Метод оплаты',
                                  style: TextStyle(
                                    color: Color(0xFF8A929A),
                                    fontSize: 12.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Icon(Icons.keyboard_arrow_down_outlined,
                                  color: Color(0xFF8A929A), size: 16.sp,),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h,),
                      isLoading
                          ? Center(child: CircularProgressIndicator(color: Colors.white))
                          : Expanded(
                        child: OrdersList(
                          isPurchaseSelected: isPurchaseSelected,
                          enteredPrice: enteredPrice,
                          selectedBank: selectedBank,
                          selectedFiatCurrency: selectedFiatCurrency,
                          refreshController: _refreshController,
                          onRefresh: _onRefresh,
                          onLoading: _onLoading,
                        ),
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget purchaseContainer(Color bgColor, Color textColor, String text) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: isPurchaseSelected
            ? BorderRadius.only(
          topLeft: Radius.circular(4),
          bottomLeft: Radius.circular(4),
        )
            : BorderRadius.only(
          topRight: Radius.circular(4),
          bottomRight: Radius.circular(4),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12.sp,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget saleContainer(Color textColor, String text) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12.sp,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Future<void> _bottomSheetEnterPrice(BuildContext context) async {
    final String? result = await showModalBottomSheet<String>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22.0),
      ),
      useRootNavigator: true,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        String tempEnteredPrice = enteredPrice ?? "";
        return FractionallySizedBox(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: 390.w,
                height: 190.h,
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: 30,
                ),
                decoration: ShapeDecoration(
                  color: Color(0xFF1D2126),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Сумма',
                      style: TextStyle(
                        color: Color(0x7FEDF7FF),
                        fontSize: 16.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Container(
                      width: 349.w,
                      height: 51.h,
                      padding: EdgeInsets.only(left: 15.w, right: 15.w),
                      decoration: ShapeDecoration(
                        color: Color(0xFF272D35),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: TextEditingController(text: tempEnteredPrice),
                              onChanged: (value) {
                                tempEnteredPrice = value;
                              },
                              decoration: InputDecoration(
                                hintText: 'Введите сумму',
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: Color(0xFF8A929A),
                                  fontSize: 14.sp,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h,),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
    setState(() {
      enteredPrice = result;
      _loadData();
    });
  }
}

class OrdersList extends StatelessWidget {
  final bool isPurchaseSelected;
  final String? enteredPrice;
  final String? selectedBank;
  final String? selectedFiatCurrency;
  final RefreshController refreshController;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;

  const OrdersList({
    Key? key,
    required this.isPurchaseSelected,
    required this.enteredPrice,
    required this.selectedBank,
    required this.selectedFiatCurrency,
    required this.refreshController,
    required this.onRefresh,
    required this.onLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrderProvider>(context).orders;
    return isPurchaseSelected ? buyOrders(context, orders) : sellOrders(context, orders);
  }

  Widget buyOrders(BuildContext context, List<dynamic> orders) {
    List<dynamic> filteredOrders = selectedBank == null
        ? orders
        : orders.where((order) => order['order']['banks'].contains(selectedBank)).toList();

    filteredOrders = selectedFiatCurrency == null
        ? filteredOrders
        : filteredOrders.where((order) => order['order']['taker_currency'].contains(selectedFiatCurrency)).toList();

    return SmartRefresher(
      controller: refreshController,
      onRefresh: onRefresh,
      onLoading: onLoading,
      enablePullDown: true,
      enablePullUp: false,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: filteredOrders.length,
        itemBuilder: (context, index) {
          if (filteredOrders[index]['order']['maker_currency_type'] != 'crypto') {
            return SizedBox.shrink();
          } else {
            final order = filteredOrders[index];
            return FutureBuilder<Map<String, dynamic>>(
              future: Provider.of<OrderProvider>(context, listen: false).fetchUserStats(order['order']['maker']),
              builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: Colors.white,));
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return P2Pinstance(
                    login: snapshot.data?['user_name'] ?? 'N/A',
                    like_percentage: calculateLikesPercentage(snapshot.data?['likes'], snapshot.data?['dislikes']).toString(),
                    order_quantity: snapshot.data!['deals_count'].toString(),
                    success_percentage: (snapshot.data?['success_deals'] * 100 / snapshot.data!['deals_count']).toString(),
                    price: order['order']['price'],
                    currency: order['order']['taker_currency'],
                    lower_limit: order['order']['lower'],
                    upper_limit: order['order']['upper'],
                    banks: order['order']['banks'],
                    buyOrder: true,
                    onPressed: (context) {
                      var orderProvider = Provider.of<OrderProvider>(context, listen: false);
                      orderProvider.makerId = order['order']['maker'];
                      orderProvider.banks = order['order']['banks'];
                      orderProvider.cost = order['order']['price'];
                      orderProvider.fiat = order['order']['taker_currency'];
                      orderProvider.comments = order['order']['comment'];
                      orderProvider.crypto = order['order']['maker_currency'];
                      orderProvider.unitCost = order['order']['upper'];
                      orderProvider.login = snapshot.data?['user_name'] ?? 'N/A';
                      orderProvider.upper = order['order']['upper'];
                      orderProvider.lower = order['order']['lower'];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BuyExtended(
                              orderId: order['order']['id'],
                            )),
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }

  double calculateLikesPercentage(int likes, int dislikes) {
    if (likes + dislikes == 0) {
      return 0;
    } else return (likes / (likes + dislikes));
  }

  Widget sellOrders(BuildContext context, List<dynamic> orders) {
    List<dynamic> filteredOrders = selectedBank == null
        ? orders
        : orders.where((order) => order['order']['banks'].contains(selectedBank)).toList();

    filteredOrders = selectedFiatCurrency == null
        ? filteredOrders
        : filteredOrders.where((order) => order['order']['maker_currency'].contains(selectedFiatCurrency)).toList();

    return SmartRefresher(
      controller: refreshController,
      onRefresh: onRefresh,
      onLoading: onLoading,
      enablePullDown: true,
      enablePullUp: false,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: filteredOrders.length,
        itemBuilder: (context, index) {
          if (filteredOrders[index]['order']['maker_currency_type'] == 'crypto') {
            return SizedBox.shrink();
          } else {
            final order = filteredOrders[index];
            return FutureBuilder<Map<String, dynamic>>(
              future: Provider.of<OrderProvider>(context, listen: false).fetchUserStats(order['order']['maker']),
              builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: Colors.white,));
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return P2Pinstance(
                    login: snapshot.data?['user_name'] ?? 'N/A',
                    like_percentage: calculateLikesPercentage(snapshot.data?['likes'], snapshot.data?['dislikes']).toString(),
                    order_quantity: snapshot.data!['deals_count'].toString(),
                    success_percentage: (snapshot.data?['success_deals'] * 100 / snapshot.data!['deals_count']).toString(),
                    price: order['order']['price'],
                    currency: order['order']['maker_currency'],
                    lower_limit: order['order']['lower'],
                    upper_limit: order['order']['upper'],
                    banks: order['order']['banks'],
                    buyOrder: false,
                    onPressed: (context) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SellExtended(
                              orderId: order['order']['id'],
                              lower: order['order']['lower'],
                              login: snapshot.data?['user_name'] ?? 'N/A',
                              banks: order['order']['banks'],
                              cost: double.parse(order['order']['price']).toInt().toString(),
                              fiat: order['order']['taker_currency'],
                              comments: order['order']['comment'],
                              crypto: order['order']['maker_currency'],
                              unitCost: order['order']['upper'],
                            )),
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
