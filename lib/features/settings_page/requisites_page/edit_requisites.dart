import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vvault_redesign/features/shared/ui_kit/confirmation_window.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';

class EditRequisitePage extends StatefulWidget {
  final String? requisite;
  final String? comment;

  const EditRequisitePage({
    super.key,
    required this.requisite,
    required this.comment
  });

  @override
  State<EditRequisitePage> createState() => _EditRequisitePageState();
}

class _EditRequisitePageState extends State<EditRequisitePage> {
  late TextEditingController requisiteContr;
  late TextEditingController commentsContr;

  @override
  void initState() {
    super.initState();
    requisiteContr = TextEditingController(text: widget.requisite);
    commentsContr = TextEditingController(text: widget.comment);
  }

  @override
  void dispose() {
    commentsContr.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                          ),
                        ],
                      ),
                      SizedBox(height: 50.h,),
                      Text(
                        'Новые реквизиты',
                        style: TextStyle(
                          color: Color(0x7FEDF7FF),
                          fontSize: 16.sp,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
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
                            Expanded(
                              child: TextField(
                                controller: requisiteContr,
                                style: TextStyle(
                                  color: Color(0xFFEDF7FF),
                                  fontSize: 16.sp,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter requisite',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF8A929A),
                                    fontSize: 16.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            SvgPicture.asset("assets/edit_icon.svg")
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Text(
                        'Комментарий',
                        style: TextStyle(
                          color: Color(0x7FEDF7FF),
                          fontSize: 16.sp,
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
                            color: Color(0xFF1D2126)
                        ),
                        child: TextField(
                          controller: commentsContr,
                          maxLength: 50,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: 'Напишите Ваши условия',
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
                      Spacer(),
                      CustomButton(text: "Сохранить",
                          onPressed: (context) {
                            ConfirmationWindow(
                              content: 'Вы точно хотите удалить реквизиты 3243 2212 8873 3341?',
                              confirmButtonText: 'Подтвердить',
                              cancelButtonText: 'Отмена',
                              onConfirm: () {
                                Navigator.pop(context);
                              },
                            ).showConfirmationDialog(context);
                          },
                          clr: Color(0xFF272D35)),
                      SizedBox(height: 10.h,),
                      CustomButton(text: "Удалить",
                          onPressed: (context) {
                            print("tapped");
                          },
                          clr: Color(0xFFE93349)),
                      SizedBox(height: 20.h,),
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
