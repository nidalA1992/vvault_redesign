import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/home_screen.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/buy_extended.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_order_instance.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_payment_methods_button.dart';

class P2PMarket extends StatefulWidget {
  const P2PMarket({super.key});

  @override
  State<P2PMarket> createState() => _P2PMarketState();
}

class _P2PMarketState extends State<P2PMarket> {
  bool isPurchaseSelected = true;
  final List<String> _items = ['BTC', 'ETH', 'BTC', 'ETH', 'BTC', 'ETH', 'BTC', 'ETH'];
  final List<String> _itemsValutas = ['RUB', 'KZT', 'USD', 'UZS', 'TRY', 'UAH', 'TJA', 'ETH'];
  int _selectedCurrencyItemIndex = -1;
  String selectedCurrency = 'BTC';
  int _selectedValutaItemIndex = -1;
  String selectedValuta = 'KZT';
  TextEditingController searchController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    CustomAppBar(img_path: "assets/avatar.svg", username: "diehie", id_user: "201938064"),
                  ],
                ),
              )
          ),
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
                            }),
                            child: Container(
                              width: 199.75.w,
                              height: 31.h,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1.w,
                                      color: isPurchaseSelected ? Color(0xFF05CA77) : Color(0xFF7F2531)),
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
                                        ? purchaseContainer(Color(0x4C05CA77), Color(0xFF05CA77), 'Покупка')
                                        : saleContainer(Colors.white, 'Покупка'),
                                  ),
                                  Expanded(
                                    child: isPurchaseSelected
                                        ? saleContainer(Colors.white, 'Продажа')
                                        : purchaseContainer(Color(0xFF3F1C23), Color(0xFFE93349), 'Продажа'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              _bottomSheetCurrency(context);
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
                                  Image.asset("assets/bitcoin-btc-logo 1.png"),
                                  Text(
                                    selectedCurrency,
                                    style: TextStyle(
                                      color: Color(0xFF8A929A),
                                      fontSize: 12.sp,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Icon(Icons.keyboard_arrow_down_outlined, color: Color(0xFF8A929A), size: 16.sp,),
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
                              _bottomSheetValuta(context);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  selectedValuta,
                                  style: TextStyle(
                                    color: Color(0xFF8A929A),
                                    fontSize: 12.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Icon(Icons.keyboard_arrow_down_outlined, color: Color(0xFF8A929A), size: 16.sp,),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _bottomSheetPaymentMethods(context);
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
                                Icon(Icons.keyboard_arrow_down_outlined, color: Color(0xFF8A929A), size: 16.sp,),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h,),
                      Builder(
                        builder: (context) {
                          if (isPurchaseSelected) {
                            return buyOrders();
                          } else {
                            return sellOrders();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
          )
        ],
      ),
    );
  }

  Widget buyOrders() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 1,
        itemBuilder: (context, index) {
          return P2Pinstance(
            login: 'JohnDoe123',
            like_percentage: '95%',
            order_quantity: '120',
            success_percentage: '98',
            price: '5000',
            currency: 'USD',
            lower_limit: '100',
            upper_limit: '10000',
            banks: ['Сбер', 'Тинькофф', 'Совкомбанк', 'УралСиб'],
            buyOrder: true,
            onPressed: (context) {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BuyExtended())
              );
            },
          );
        },
      ),
    );
  }

  Widget sellOrders() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 1,
        itemBuilder: (context, index) {
          return P2Pinstance(
            login: 'JohnDoe123',
            like_percentage: '95%',
            order_quantity: '120',
            success_percentage: '98',
            price: '1000000',
            currency: 'USD',
            lower_limit: '100',
            upper_limit: '10000',
            banks: ['Сбер', 'Тинькофф', 'Совкомбанк', 'УралСиб'],
            buyOrder: false,
            onPressed: (context) {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen())
              );
            },
          );
        },
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

  Future<void> _bottomSheetCurrency(BuildContext context) async {
    final String? result = await showModalBottomSheet<String> (
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.0),
        ),
        useRootNavigator: true,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return FractionallySizedBox(
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Container(
                      width: 390.w,
                      height: 450.h,
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                        bottom: 30,
                      ),
                      decoration: ShapeDecoration(
                        color: Color(0xFF262C35),
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
                            'Выберите монету',
                            style: TextStyle(
                              color: Color(0x7FEDF7FF),
                              fontSize: 16.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            width: 349.68.w,
                            height: 33.17.h,
                            decoration: ShapeDecoration(
                              color: Color(0xFF3E4349),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/search_icon.svg"),
                                SizedBox(width: 10.w,),
                                Text(
                                  'Поиск монет',
                                  style: TextStyle(
                                    color: Color(0x7FEDF7FF),
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          Text(
                            'Поддерживающие монеты для Р2Р',
                            style: TextStyle(
                              color: Color(0x7FEDF7FF),
                              fontSize: 12.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          Expanded(
                            child: ListView.builder(
                              itemCount: _items.length,
                              itemBuilder: (context, index) {
                                bool isSelected = index == _selectedCurrencyItemIndex;
                                return Container(
                                  padding: EdgeInsets.symmetric(vertical: 8), // Adjust padding as needed
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _selectedCurrencyItemIndex = index;
                                        Navigator.pop(context, _items[index]);
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center, // Centers the children horizontally
                                      children: [
                                        Text(
                                          _items[index],
                                          style: TextStyle(
                                            color: Color(0xFF8A929A),
                                            fontSize: 14.sp,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(width: 20), // Space between text and icon
                                        if (isSelected)
                                          Icon(Icons.check, color: Color(0xFF0066FF)),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  }
              )
          );
        }
    );
    if (result != null) {
      setState(() {
        selectedCurrency = result;
      });
    }
  }

  Future<void> _bottomSheetPaymentMethods(BuildContext context) async {
    final String? result = await showModalBottomSheet<String> (
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.0),
        ),
        useRootNavigator: true,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return FractionallySizedBox(
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Container(
                      width: 390.w,
                      height: 450.h,
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                        bottom: 30,
                      ),
                      decoration: ShapeDecoration(
                        color: Color(0xFF262C35),
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
                            'Методы оплаты',
                            style: TextStyle(
                              color: Color(0x7FEDF7FF),
                              fontSize: 16.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            width: 349.68.w,
                            height: 33.17.h,
                            decoration: ShapeDecoration(
                              color: Color(0xFF3E4349),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/search_icon.svg"),
                                SizedBox(width: 10.w,),
                                Text(
                                  'Поиск монет',
                                  style: TextStyle(
                                    color: Color(0x7FEDF7FF),
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PaymentMethodsButton(txt: 'Все',),
                              PaymentMethodsButton(txt: 'Garanti',),
                            ],
                          ),
                          SizedBox(height: 10.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PaymentMethodsButton(txt: 'Банковский перевод',),
                              PaymentMethodsButton(txt: 'Ziraat',),
                            ],
                          ),
                          SizedBox(height: 10.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PaymentMethodsButton(txt: 'Все',),
                              PaymentMethodsButton(txt: 'Garanti',),
                            ],
                          ),
                          SizedBox(height: 10.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PaymentMethodsButton(txt: 'Банковский перевод',),
                              PaymentMethodsButton(txt: 'Ziraat',),
                            ],
                          ),
                          SizedBox(height: 10.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PaymentMethodsButton(txt: 'Все',),
                              PaymentMethodsButton(txt: 'Garanti',),
                            ],
                          ),
                          SizedBox(height: 10.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PaymentMethodsButton(txt: 'Банковский перевод',),
                              PaymentMethodsButton(txt: 'Ziraat',),
                            ],
                          ),
                          SizedBox(height: 10.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PaymentMethodsButton(txt: 'Все',),
                              PaymentMethodsButton(txt: 'Garanti',),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
              )
          );
        }
    );
  }

  Future<void> _bottomSheetEnterPrice(BuildContext context) async {
    final String? result = await showModalBottomSheet<String> (
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.0),
        ),
        useRootNavigator: true,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return FractionallySizedBox(
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Container(
                      width: 390.w,
                      height: 180.h,
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
                                Text(
                                  'Введите сумму',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF8A929A),
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  'RUB',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
              )
          );
        }
    );
  }

  Future<void> _bottomSheetValuta(BuildContext context) async {
    // Variable to hold the filtered list based on the search
    List<String> filteredItems = _itemsValutas;

    final String? result = await showModalBottomSheet<String>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.0.r),
        ),
        useRootNavigator: true,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return FractionallySizedBox(
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Container(
                      width: 390.w,
                      height: 450.h,
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                        bottom: 30,
                      ),
                      decoration: ShapeDecoration(
                        color: Color(0xFF262C35),
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
                            'Выберите монету',
                            style: TextStyle(
                              color: Color(0x7FEDF7FF),
                              fontSize: 16.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          TextField(
                            controller: searchController1,
                            decoration: InputDecoration(
                              prefixIcon: SvgPicture.asset("assets/search_icon.svg", fit: BoxFit.scaleDown), // Adjust as needed
                              hintText: 'Поиск монет',
                              hintStyle: TextStyle(
                                color: Color(0x7FEDF7FF),
                                fontSize: 14.sp,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.r),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color(0xFF3E4349),
                            ),
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 14.sp,
                            ),
                            onChanged: (value) {
                              setState(() {
                                // Filter the list of items based on the search term
                                filteredItems = _itemsValutas.where((item) => item.toLowerCase().contains(value.toLowerCase())).toList();
                              });
                            },
                          ),
                          SizedBox(height: 10.h,),
                          Text(
                            'Поддерживающие монеты для Р2Р',
                            style: TextStyle(
                              color: Color(0x7FEDF7FF),
                              fontSize: 12.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          Expanded(
                            child: ListView.builder(
                              itemCount: filteredItems.length,
                              itemBuilder: (context, index) {
                                bool isSelected = index == _selectedValutaItemIndex;
                                return Container(
                                  padding: EdgeInsets.symmetric(vertical: 8), // Adjust padding as needed
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _selectedValutaItemIndex = index;
                                        Navigator.pop(context, filteredItems[index]);
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center, // Centers the children horizontally
                                      children: [
                                        Text(
                                          filteredItems[index],
                                          style: TextStyle(
                                            color: Color(0xFF8A929A),
                                            fontSize: 14.sp,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(width: 20), // Space between text and icon
                                        if (isSelected)
                                          Icon(Icons.check, color: Color(0xFF0066FF)),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  }
              )
          );
        }
    );
    if (result != null) {
      setState(() {
        selectedValuta = result;
      });
    }
  }
}
