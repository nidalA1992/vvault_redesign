import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/settings_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/requisite_instance.dart';

class EditRequisitePage extends StatefulWidget {
  final String requisite;
  const EditRequisitePage({super.key, required this.requisite});

  @override
  State<EditRequisitePage> createState() => _EditRequisitePageState();
}

class _EditRequisitePageState extends State<EditRequisitePage> {
  TextEditingController commentsContr = TextEditingController();

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
                    CustomAppBar(img_path: "assets/avatar.png", username: "diehie"),
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
                          'Редактировать реквизиты',
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
                          'Новые реквизиты',
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 18.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Container(
                          width: 350.w,
                          height: 54.h,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          decoration: ShapeDecoration(
                            color: Color(0xFF1D2126),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)), // Use ScreenUtil for borderRadius if needed
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.requisite,
                                style: TextStyle(
                                  color: Color(0xFFEDF7FF),
                                  fontSize: 16.sp,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              SvgPicture.asset("assets/pencil_icon.svg")
                            ],
                          ),
                        ),
                        SizedBox(height: 30.h,),
                        CustomButton(text: "Редактировать",
                            onPressed: (context) {
                          print("tapped");
                            },
                            clr: Color(0xFF0066FF)),
                        SizedBox(height: 10.h,),
                        CustomButton(text: "Удалить",
                            onPressed: (context) {
                              print("tapped");
                            },
                            clr: Color(0xFF0E2241)),
                        SizedBox(height: 10.h,),
                      ],
                    ),
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}
