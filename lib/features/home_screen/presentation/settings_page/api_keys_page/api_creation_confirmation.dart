import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/home_screen.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/confidentiality_page/confirmation_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/api_key_instance.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar_without_avatar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_textfield.dart';
import 'package:vvault_redesign/features/shared/ui_kit/otp_box.dart';
import '../../../../../../main.dart';

class ConfirmApiCreation extends StatefulWidget {
  const ConfirmApiCreation({super.key});

  @override
  State<ConfirmApiCreation> createState() => _ConfirmApiCreationState();
}

class _ConfirmApiCreationState extends State<ConfirmApiCreation> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;
  String _buttonText = 'Получить новый код';
  late Timer _timer;
  int _remainingSeconds = 30;
  String _name = "Изменить логин";

  bool areAllOtpBoxesFilled() {
    for (var controller in _controllers) {
      if (controller.text.isEmpty) {
        return false;
      }
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(6, (index) => FocusNode());
    _controllers = List.generate(6, (index) => TextEditingController());
  }

  void _startTimer() {
    setState(() {
      _buttonText = 'Следующий код через $_remainingSeconds с.';
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 1) {
        _stopTimer();
        setState(() {
          _buttonText = 'Получить новый код';
        });
      } else {
        setState(() {
          _remainingSeconds--;
          _buttonText = 'Следующий код через $_remainingSeconds с.';
        });
      }
    });
  }

  void _stopTimer() {
    if (_timer.isActive) {
      _timer.cancel();
      _remainingSeconds = 30;
    }
  }

  @override
  void dispose() {
    _stopTimer();
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          decoration: BoxDecoration(color: Color(0xFF141619)),
          child: Padding(
            padding: EdgeInsets.only(top: 90.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Введите код',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFEDF7FF),
                      fontSize: 36.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 120.h,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) => _buildOtpBox(index)),
                  ),
                ),
                SizedBox(height: 60.h,),
                Center(
                  child: Text(
                    'Введите код подтверждения,\nкоторый пришёл на Вашу почту',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0x7FEDF7FF),
                      fontSize: 16.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  width: 350.w,
                  height: 60.h,
                  decoration: ShapeDecoration(
                    color: Color(0xFF262C35),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _startTimer();
                        },
                        child: Center(
                          child: Text(
                            _buttonText,
                            style: TextStyle(
                              color: Color(0x7FEDF7FF),
                              fontSize: 16.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.h,),
                CustomButton(text: "Подтвердить создание",
                    onPressed: (context) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmLogin()));
                    },
                    clr: Color(0xFF0066FF)),
                SizedBox(height: 20.h,)
              ],
            ),
          )
      ),
    );
  }

  Widget _buildOtpBox(int index) {
    return OtpBox(
      controller: _controllers[index],
      focusNode: _focusNodes[index],
      onChanged: (value) {
        if (value.length == 1 && index < _controllers.length - 1) {
          FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
        } else if (value.isEmpty && index > 0) {
          FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
        }
      },
    );
  }

}
