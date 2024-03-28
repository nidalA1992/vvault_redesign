import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/my_orders/my_orders_page.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/get_banks_list_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/update_order_provider.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/my_orders/modal_bottom_sheet.dart';
import 'package:vvault_redesign/features/shared/ui_kit/my_orders/order_instance.dart';

class EditOrderPage extends StatefulWidget {
  final String price;
  final String titleCurrency;
  final String priceCurrency;
  final List<dynamic> banks;
  final String lowerLimit;
  final String upperLimit;
  final String comment;
  final String orderID;

  EditOrderPage({
    Key? key,
    required this.price,
    required this.priceCurrency,
    required this.banks,
    required this.titleCurrency,
    required this.lowerLimit,
    required this.upperLimit,
    required this.comment,
    required this.orderID
  }) : super(key: key);

  @override
  State<EditOrderPage> createState() => _EditOrderPageState();
}

class _EditOrderPageState extends State<EditOrderPage> {
  bool isFixed = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController commentsController = TextEditingController(text: widget.comment);
    List<dynamic> banks = widget.banks;
    final _banks = Provider.of<BanksListProvider>(context).banks;

    final updateOrderProvider = Provider.of<UpdateOrderProvider>(context, listen: false);

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
                    CustomAppBar(img_path: "assets/avatar.png", username: "diehie", isP2P: true,
                      onPressedOrders: (context) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrdersPage()));
                      },),
                    SizedBox(height: 20.h,),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back_outlined, color: Color(0x7FEDF7FF))
                        ),
                        SizedBox(width: 10.w,),
                        Text(
                          'Моё объявление',
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 20.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
          ),
          Positioned(
              top: 160,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: Color(0xFF141619),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Цена',
                          style: TextStyle(
                            color: Color(0x7FEDF7FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Container(
                              width: 250.w,
                              height: 45.h,
                              padding: EdgeInsets.symmetric(horizontal: 20.h),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 1.50.w, color: Color(0xFF262C35)),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    formatLimit(widget.price),
                                    style: TextStyle(
                                      color: Color(0x7FEDF7FF),
                                      fontSize: 16.sp,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    widget.priceCurrency,
                                    style: TextStyle(
                                      color: Color(0x7FEDF7FF),
                                      fontSize: 16.sp,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10.w,),
                            GestureDetector(
                              onTap: () {
                                _typeOfPrice(context);
                              },
                              child: Container(
                                width: 90.w,
                                height: 45.h,
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 1.50, color: Color(0xFF262C35)),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        isFixed ? "assets/lock_icon.svg" : "assets/percent_gray.svg"
                                    ),
                                    Icon(Icons.keyboard_arrow_down_outlined, color: Color(0x7FEDF7FF),)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20.h,),
                        Container(
                          width: 350.w,
                          height: 45.h,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          decoration: ShapeDecoration(
                            color: Color(0xFF272D35),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Текущий биржевой курс  91,20  ${widget.priceCurrency}/${widget.titleCurrency}',
                                style: TextStyle(
                                  color: Color(0x7FEDF7FF),
                                  fontSize: 14.sp,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Text(
                          'Лимиты сделки',
                          style: TextStyle(
                            color: Color(0x7FEDF7FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _limitBox(true),
                            _limitBox(false),
                          ],
                        ),
                        SizedBox(height: 20.h,),
                        Text(
                          'Способы оплаты',
                          style: TextStyle(
                            color: Color(0x7FEDF7FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        GestureDetector(
                          onTap: () async {
                            final chosenBank = await showModalBottomSheet<String>(
                              context: context,
                              builder: (BuildContext context) {
                                return OrdersBottomSheet(
                                  options: _banks,
                                  title: 'Выберите банк',
                                  searchText: 'Поиск',
                                );
                              },
                            );

                            if (chosenBank != null && !banks.contains(chosenBank)) {
                              setState(() {
                                banks.add(chosenBank);
                              });
                            }
                          },
                          child: Container(
                            width: 350.w,
                            height: 45.h,
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 1.50.w, color: Color(0xFF262C35)),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Выбрано ${banks.length} банка',
                                  style: TextStyle(
                                    color: Color(0xFFEDF7FF),
                                    fontSize: 16.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SvgPicture.asset("assets/search_icon.svg")
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Wrap(
                          spacing: 10.w,
                          runSpacing: 5.h,
                          children: widget.banks.asMap().entries.map((entry) {
                            int index = entry.key;
                            String label = entry.value;
                            return buildLabel(label, index);
                          }).toList(),
                        ),
                        SizedBox(height: 20.h,),
                        Text(
                          'Условия сделки',
                          style: TextStyle(
                            color: Color(0x7FEDF7FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Container(
                          width: 370.w,
                          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1.50.w, color: Color(0xFF262C35)),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: TextField(
                            controller: commentsController,
                            maxLength: 300,
                            maxLines: null,
                            decoration: InputDecoration(
                              labelText: "Напишите Ваши условия",
                              labelStyle: TextStyle(
                                color: Color(0xFF8A929A),
                                fontSize: 16.sp,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                              counterStyle: TextStyle(
                                color: Color(0xFF8A929A),
                                fontSize: 14.sp,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                              border: InputBorder.none,
                            ),
                            buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) => Text(
                              '${currentLength ?? 0} / ${maxLength ?? 300}',
                              style: TextStyle(
                                color: Color(0xFF8A929A),
                                fontSize: 14.sp,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h,),
                        Form(
                          key: _formKey,
                          child: GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                final orderData = {
                                  "active": true,
                                  "conditions": {
                                    "comment": commentsController.text,
                                    "lower": "2",
                                    "upper": "4"
                                  },
                                  "price": {
                                    "type": "exchange",
                                    "unit_cost": "5"
                                  }
                                };
                                updateOrderProvider.updateOrder(orderData, widget.orderID);
                              }
                              Navigator.pop(context);
                            },
                            child: CustomButton(text: "Сохранить",
                                clr: Color(0xFF0066FF)
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        CustomButton(text: "Удалить",
                            clr: Color(0xFF0E2241)
                        ),
                        SizedBox(height: 20.h,)
                      ],
                    ),
                  ),
                ),
              ),
          )
        ],
      ),
    );
  }

  Widget _limitBox(bool lower) {
    return Container(
      width: 170.w,
      height: 45.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.50.w, color: Color(0xFF262C35)),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            lower ? formatLimit(widget.lowerLimit) : formatLimit(widget.upperLimit),
            style: TextStyle(
              color: Color(0x7FEDF7FF),
              fontSize: 16.sp,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            widget.priceCurrency,
            style: TextStyle(
              color: Color(0x7FEDF7FF),
              fontSize: 16.sp,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLabel(String label, int index) {
    return IntrinsicWidth(
      child: Container(
        key: ValueKey(label),
        width: 170.w,
        height: 30.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: ShapeDecoration(
          color: Color(0xFF243248),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Color(0xFF62A0FF),
                  fontSize: 14.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () => removeLabel(index),
                child: Icon(Icons.close, color: Color(0xFF62A0FF), size: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatLimit(String limit) {
    return limit.length > 6 ? limit.substring(0, 6) : limit;
  }

  void removeLabel(int index) {
    setState(() {
      widget.banks.removeAt(index);
    });
  }

  Future<void> _typeOfPrice(BuildContext context) async {
    final bool? result = await showModalBottomSheet<bool> (
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
                      height: 220.h,
                      padding: EdgeInsets.only(
                        top: 20.h,
                        left: 20.w,
                        right: 20.w,
                        bottom: 30.h,
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
                            'Выберите тип цены',
                            style: TextStyle(
                              color: Color(0x7FEDF7FF),
                              fontSize: 16.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context, false);
                            },
                            child: Container(
                              width: 350.w,
                              height: 50.h,
                              padding: EdgeInsets.symmetric(horizontal: 20.h),
                              decoration: ShapeDecoration(
                                color: !isFixed ? Color(0xFF1A283C) : Color(0xFF21262D),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/percent_gray.svg"),
                                  SizedBox(width: 10.w,),
                                  Text(
                                    'Плавающая цена',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(),
                                  if (!isFixed) ... [
                                    Icon(Icons.check, color: Colors.white,)
                                  ]
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context, true);
                            },
                            child: Container(
                              width: 350.w,
                              height: 50.h,
                              padding: EdgeInsets.symmetric(horizontal: 20.h),
                              decoration: ShapeDecoration(
                                color: isFixed ? Color(0xFF1A283C) : Color(0xFF21262D),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/lock_icon.svg"),
                                  SizedBox(width: 10.w,),
                                  Text(
                                    'Фиксированная цена',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(),
                                  if (isFixed) ... [
                                    Icon(Icons.check, color: Colors.white,)
                                  ]
                                ],
                              ),
                            ),
                          ),
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
        isFixed = result;
      });
    }
  }

}
