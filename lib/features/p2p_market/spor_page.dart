import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vvault_redesign/features/home_page/home_screen.dart';
import 'package:vvault_redesign/features/shared/ui_kit/p2p_buy-sell_banks.dart';


class SporPage extends StatefulWidget {
  final String dealNumber;
  final Function(BuildContext)? onPressed;
  final String sellerAmount;
  final String sellerLogin;
  final String sellerCurrency;

  const SporPage({
    Key? key,
    required this.dealNumber,
    required this.onPressed,
    required this.sellerAmount,
    required this.sellerLogin,
    required this.sellerCurrency
  }) : super(key: key);

  @override
  _SporPageState createState() => _SporPageState();
}

class _SporPageState extends State<SporPage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.only(
            top: 80,
            left: 20,
            right: 20,
          ),
          decoration: BoxDecoration(color: Color(0xFF141619)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap: () => widget.onPressed!(context),
                        child: Icon(Icons.arrow_back_outlined, color: Color(0xFF8A929A),)
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
                    )
                  ],
                ),
                SizedBox(height: 20.h,),
                Text(
                  'В процессе спора',
                  style: TextStyle(
                    color: Color(0xFFEDF7FF),
                    fontSize: 18.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5.h,),
                Text(
                  'Для решения спора перейдите в чат',
                  style: TextStyle(
                    color: Color(0x7FEDF7FF),
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20.h,),
                ExtendableBanksList(
                    banks: ["Сбербанк"],
                    price: "363 928",
                    currency: "RUB",
                    onPressed: (context) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                    },
                    bank_requis: "6529 0736 9087 1639",
                    comment: "Куча слов про сделку я не работаю со скамерами и прочими говнюками!"
                ),
                Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent, ),
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
                      isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: Color(0x7FEDF7FF),
                    ),
                    onExpansionChanged: (bool expanding) => setState(() => isExpanded = expanding),
                    children: [
                      Align(
                        alignment:Alignment.centerLeft,
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
                SizedBox(height: 20.h,),
                Container(
                  width: 350.w,
                  height: 1.50.h,
                  color: Color(0xFF1D2126),
                ),
                SizedBox(height: 20.h,),
                Text(
                  'Условия сделки',
                  style: TextStyle(
                    color: Color(0xFFEDF7FF),
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h,),
                Text(
                  'Куча слов про сделку я не работаю со скамерами и прочими говнюками!',
                  style: TextStyle(
                    color: Color(0x7FEDF7FF),
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 70.h,),
                Center(
                  child: Container(
                    width: 315.w,
                    height: 44.h,
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    decoration: ShapeDecoration(
                      color: Color(0xFF252A31),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Отменить спор',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
