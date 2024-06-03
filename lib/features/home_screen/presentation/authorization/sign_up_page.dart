import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/authorization/provider/sign_in_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/authorization/provider/sign_up_provider.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_textfield.dart';
import 'package:vvault_redesign/main.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<SignUpProvider>(context, listen: false);

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
                        hintText: 'email',
                        isHidden: false,
                        controller: emailController,
                      ),
                      SizedBox(height: 15.h,),
                      CustomTextField(
                        hintText: 'pass',
                        controller: passwordController,
                      ),
                      SizedBox(height: 15.h,),
                      CustomTextField(
                        hintText: 'phone',
                        controller: phoneController,
                      ),
                      SizedBox(height: 15.h,),
                      CustomTextField(
                        hintText: 'username',
                        controller: usernameController,
                      ),
                      SizedBox(height: 200.h,),
                      GestureDetector(
                        onTap: () async {
                          try {
                            await userProvider.signUp(
                              emailController.text,
                              passwordController.text,
                              phoneController.text,
                              usernameController.text
                            );
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
    );
  }
}
