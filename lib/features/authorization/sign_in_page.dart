import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_textfield.dart';
import 'package:vvault_redesign/main.dart';

import 'provider/auth_providers.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<SignInProvider>(context, listen: false);

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
                height: 0.3.sh,
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                decoration: BoxDecoration(color: Color(0xFF141619)),
                child: Padding(
                  padding: EdgeInsets.only(top: 120.h),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'Вход',
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 36.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 70.h,),
                        CustomTextField(
                            hintText: 'Логин (Никнейм, почта, номер)',
                            isHidden: false,
                            controller: emailController,
                        ),
                        SizedBox(height: 15.h,),
                        CustomTextField(
                            hintText: 'Пароль*',
                            controller: passwordController,
                        ),
                        SizedBox(height: 300.h,),
                        GestureDetector(
                          onTap: () async {
                            try {
                              await userProvider.signIn(
                                emailController.text,
                                passwordController.text,
                              );
                              Future.delayed(Duration(seconds: 1));
                              if (mounted) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => NavBar()),
                                      (Route<dynamic> route) => false,
                                );
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: CustomButton(
                              text: "Войти",
                              clr: Color(0xFF0066FF),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ),

          ],
        ),
      ),
    );
  }
}
