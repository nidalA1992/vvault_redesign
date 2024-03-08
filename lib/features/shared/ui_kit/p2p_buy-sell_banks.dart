import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExtendableBanksList extends StatefulWidget {
  final String price;
  final String currency;
  final String bank_requis;
  final String comment;
  final Function(BuildContext)? onPressed;

  const ExtendableBanksList({
    Key? key,
    required this.price,
    required this.currency,
    required this.onPressed,
    required this.bank_requis,
    required this.comment,
  }) : super(key: key);

  @override
  _ExtendableBanksListState createState() => _ExtendableBanksListState();
}

class _ExtendableBanksListState extends State<ExtendableBanksList> {
  int selectedIndex = 0;

  List<String> buttons = ['Сбербанк', 'Тинькофф'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 276.h,
      child: Expanded(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: buttons.length,
          itemBuilder: (context, index) {
            bool isSelected = selectedIndex == index;
            return Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: 348.92.w,
                      height: isSelected ? 216.52.h : 50.h,
                      padding: EdgeInsets.only(top: 50, right: 20, left: 20),
                      decoration: ShapeDecoration(
                        color: isSelected ? Color(0xFF1D2126) : Colors.transparent,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1.50, color: Color(0xFF272D35)),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                      child: isSelected
                          ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Переведите',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Text(
                                widget.price,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 5.w,),
                              Text(
                                widget.currency,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 10.w,),
                              SvgPicture.asset("assets/copy_icon.svg")
                            ],
                          ),
                          SizedBox(height: 10.h,),
                          Row(
                            children: [
                              Text(
                                'На реквизиты',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Text(
                                widget.bank_requis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 10.w,),
                              SvgPicture.asset("assets/copy_icon.svg")
                            ],
                          ),
                          SizedBox(height: 20.h,),
                          Text(
                            'Комментарий',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          Text(
                            widget.comment,
                            style: TextStyle(
                              color: Color(0x7FEDF7FF),
                              fontSize: 12.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      )
                          : null,
                    ),
                    SizedBox(height: 10.h,)
                  ],
                ),
                RadioListTile<int>(
                  value: index,
                  groupValue: selectedIndex,
                  onChanged: (int? value) {
                    setState(() {
                      selectedIndex = value!;
                    });
                  },
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        buttons[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  activeColor: Color(0xFF0066FF),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}