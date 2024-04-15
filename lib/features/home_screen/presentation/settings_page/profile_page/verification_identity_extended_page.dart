import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/settings_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';

class VerificationIdentityExtended extends StatefulWidget {
  const VerificationIdentityExtended({super.key});

  @override
  State<VerificationIdentityExtended> createState() => _VerificationIdentityExtendedState();
}

class _VerificationIdentityExtendedState extends State<VerificationIdentityExtended> {
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
                    CustomAppBar(img_path: "assets/avatar.png"),
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
                          'Профиль',
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
                        SizedBox(
                          width: 335.09.w,
                          child: Text(
                            'Подтвердите свою личность',
                            style: TextStyle(
                              color: Color(0xFFEDF7FF),
                              fontSize: 24.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Text(
                          'Страна/регион выдачи',
                          style: TextStyle(
                            color: Color(0x7FEDF7FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Container(
                          width: 350.09.w,
                          height: 50.h,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: ShapeDecoration(
                            color: Color(0xFF272D35),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/russia_flag.svg"),
                              SizedBox(width: 10.w,),
                              Text(
                                'Russia',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'Местоположение',
                                style: TextStyle(
                                  color: Color(0x7FEDF7FF),
                                  fontSize: 14.sp,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 5.w,),
                              Icon(Icons.keyboard_arrow_down_outlined, color: Color(0x7FEDF7FF),)
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        SizedBox(
                          width: 360.41.w,
                          child: Text(
                            'Загрузите фотографию паспорта в развёрнутом виде',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Text(
                          'Снимок должен быть:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Text(
                          '• Светлым и чётким',
                          style: TextStyle(
                            color: Color(0x7FEDF7FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        Text(
                          '• Необрезанным',
                          style: TextStyle(
                            color: Color(0x7FEDF7FF),
                            fontSize: 14.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 110.07.w,
                              height: 98.11.h,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Center(child: SvgPicture.asset("assets/correct_passport_view.svg")),
                                  Center(child: SvgPicture.asset("assets/passport_check.svg"),)
                                ],
                              ),
                            ),
                            Container(
                              width: 110.07.w,
                              height: 98.11.h,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  ClipRect(
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      heightFactor: 0.5,
                                      child: SvgPicture.asset("assets/correct_passport_view.svg"),
                                    ),
                                  ),
                                  Center(child: SvgPicture.asset("assets/passport_uncheck.svg"),)
                                ],
                              ),
                            ),
                            Container(
                              width: 110.07.w,
                              height: 98.11.h,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: SizedBox(
                                      height: 40.h,
                                        child: SvgPicture.asset("assets/correct_passport_view.svg")
                                    ),
                                  ),
                                  Center(child: SvgPicture.asset("assets/passport_uncheck.svg"),)
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h,),
                        SizedBox(
                          width: 350.09.w,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Загрузите ',
                                  style: TextStyle(
                                    color: Color(0x7FEDF7FF),
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: 'фото',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ',
                                  style: TextStyle(
                                    color: Color(0x7FEDF7FF),
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: 'документов,',
                                  style: TextStyle(
                                    color: Color(0xFFEDF7FF),
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: ' подтверждающие Вашу личность',
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
                        ),
                        SizedBox(height: 20.h,),
                        GestureDetector(
                          // onTap: _pickDocument,
                          child: Container(
                            width: 348.80.w,
                            height: 95.14.h,
                            decoration: ShapeDecoration(
                              color: Color(0xFF272D35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.77),
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/passport_upload_icon.svg",),
                                  SizedBox(height: 10.h,),
                                  Text(
                                    'Загрузить документ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        SizedBox(
                          width: 350.09.w,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Загрузите ',
                                  style: TextStyle(
                                    color: Color(0x7FEDF7FF),
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: 'селфи с документом, ',
                                  style: TextStyle(
                                    color: Color(0xFFEDF7FF),
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: 'подтверждающим личность',
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
                        ),
                        SizedBox(height: 20.h,),
                        GestureDetector(
                          // onTap: _pickDocument,
                          child: Container(
                            width: 348.80.w,
                            height: 95.14.h,
                            decoration: ShapeDecoration(
                              color: Color(0xFF272D35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.77),
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/passport_upload_icon.svg",),
                                  SizedBox(height: 10.h,),
                                  Text(
                                    'Загрузить документ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        CustomButton(text: "Подтвердить", clr: Color(0xFF0066FF),
                            onPressed: (context) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                            }),
                        SizedBox(height: 20.h,),
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

  // Future<void> _pickDocument() async {
  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: ['pdf', 'doc', 'docx'], // Specify the extensions
  //     );
  //
  //     if (result != null) {
  //       PlatformFile file = result.files.first;
  //       // Do something with the file
  //     } else {
  //       // User canceled the picker
  //     }
  //   } catch (e) {
  //     // Print or handle the error
  //     print('Error picking file: $e');
  //   }
  // }
}
