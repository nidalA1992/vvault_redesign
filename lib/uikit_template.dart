  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';

  class Name extends StatelessWidget {
    final String? text;
    final String img_path;
    final Function(BuildContext)? onPressed;

    const Name({Key? key, this.text, this.onPressed, this.img_path = ''}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Scaffold();
    }
  }
