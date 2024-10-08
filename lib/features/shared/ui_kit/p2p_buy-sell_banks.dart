import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExtendableBanksList extends StatefulWidget {
  final String price;
  final String currency;
  final String bank_requis;
  final String comment;
  final List<String> banks;
  final bool? isBuy;
  final Function(BuildContext)? onPressed;

  const ExtendableBanksList({
    Key? key,
    required this.price,
    required this.currency,
    required this.onPressed,
    required this.bank_requis,
    required this.comment,
    required this.banks,
    this.isBuy = true,
  }) : super(key: key);

  @override
  _ExtendableBanksListState createState() => _ExtendableBanksListState();
}

class _ExtendableBanksListState extends State<ExtendableBanksList> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.banks.length == 1 ? 226.h : 276.h,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: widget.banks.length,
        shrinkWrap: true,
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
                              widget.isBuy! ? 'Переведите' : 'Получите',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              formatLimit(widget.price),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              widget.currency,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            InkWell(
                                onTap: () {
                                  Clipboard.setData(ClipboardData(text: widget.price))
                                      .then((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Color(0xFF262C35),
                                        content: Text("Copied to clipboard!"),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  });
                                },
                                child: SvgPicture.asset("assets/copy_icon.svg")
                            )
                          ],
                        ),
                        SizedBox(height: 10.h),
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
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(width: 10.w),
                            InkWell(
                                onTap: () {
                                  Clipboard.setData(ClipboardData(text: widget.bank_requis))
                                      .then((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Color(0xFF262C35),
                                        content: Text("Copied to clipboard!"),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  });
                                },
                                child: SvgPicture.asset("assets/copy_icon.svg")
                            )
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'Комментарий',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          widget.comment,
                          style: TextStyle(
                            color: Color(0x7FEDF7FF),
                            fontSize: 12.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                        : null,
                  ),
                  SizedBox(height: 10.h)
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
                      widget.banks[index],
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
    );
  }

  String formatLimit(String limit) {
    return limit.length > 10 ? limit.substring(0, 10) : limit;
  }
}