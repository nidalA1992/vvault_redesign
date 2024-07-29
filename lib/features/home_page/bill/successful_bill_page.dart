import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';

class SuccessfulBill extends StatefulWidget {
  final String paymentId;

  const SuccessfulBill({
    required this.paymentId,
    super.key
  });

  @override
  State<SuccessfulBill> createState() => _SuccessfulBillState();
}

class _SuccessfulBillState extends State<SuccessfulBill> {
  @override
  Widget build(BuildContext context) {
    String _link = 'https://senpay.tech/${widget.paymentId}?type=by_order';

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(color: Color(0xFF141619)),
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SvgPicture.asset("assets/graph.svg"),
                    ),
                    SizedBox(height: 20.h,),
                    Text(
                      'Скопируйте ссылку на оплату',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFEDF7FF),
                        fontSize: 16.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Container(
                      width: 350.w,
                      height: 56.h,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: ShapeDecoration(
                          color: Color(0x00D9D9D9),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Color(0x1CEDF7FF)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              _link,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 16.sp,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: _link))
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
                              child: SvgPicture.asset("assets/copy_icon.svg", height: 20.h, color: Colors.white.withOpacity(0.5),)
                          )
                        ],
                      )
                    ),
                    SizedBox(height: 20.h ,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                        child: CustomButton(text: "На главную", clr: Color(0xFF0066FF))
                    ),
                    SizedBox(height: 80.h,)
                  ],
                ),
              )
          ),

        ],
      ),
    );
  }
}
