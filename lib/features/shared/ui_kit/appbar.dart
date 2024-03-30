import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/get_banks_list_provider.dart';

class CustomAppBar extends StatefulWidget {
  final String img_path;
  final String username;
  final String? id_user;
  final bool isP2P;
  final Function(BuildContext)? onPressedNotifications;
  final Function(BuildContext)? onPressedOrders;
  final Function(BuildContext)? onPressedDeals;

  const CustomAppBar({
    Key? key,
    this.isP2P = false,
    required this.img_path,
    required this.username,
    this.id_user,
    this.onPressedNotifications,
    this.onPressedOrders,
    this.onPressedDeals,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {

  void loadUserMe() async {
    await Provider.of<BanksListProvider>(context, listen: false).loadUserMe();
  }

  @override
  void initState() {
    loadUserMe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userme = Provider.of<BanksListProvider>(context).userme;

    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.h,
          decoration: ShapeDecoration(
            image: DecorationImage(
              image: AssetImage("assets/avatar.png"),
              fit: BoxFit.cover,
            ),
            shape: OvalBorder(),
          ),
        ),
        SizedBox(width: 15.w,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userme['username'],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFEDF7FF),
                fontSize: 14.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
            if (widget.id_user != null) ... [
              SizedBox(height: 5.h,),
              Text(
                '${userme['id']}',
                style: TextStyle(
                  color: Color(0xFF80868C),
                  fontSize: 11.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
              )
            ]
          ],
        ),
        Spacer(),
        if (widget.isP2P) ... [
          GestureDetector(
              onTap: () => widget.onPressedDeals!(context),
              child: SvgPicture.asset("assets/users.svg")
          ),
          SizedBox(width: 15.w,),
          GestureDetector(
              onTap: () => widget.onPressedOrders!(context),
              child: SvgPicture.asset("assets/file-minus.svg")
          ),
        ],
        SizedBox(width: 15.w,),
        GestureDetector(
          onTap: () => widget.onPressedNotifications!(context),
          child: SvgPicture.asset("assets/bell_icon.svg"),
        ),
        SizedBox(width: 15.w,),
      ],
    );
  }
}