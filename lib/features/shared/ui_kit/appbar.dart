import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/get_banks_list_provider.dart';

class CustomAppBar extends StatefulWidget {
  final String img_path;
  final String? id_user;
  final bool isP2P;
  final Function(BuildContext)? onPressedNotifications;
  final Function(BuildContext)? onPressedOrders;
  final Function(BuildContext)? onPressedDeals;
  final Function(BuildContext)? onPressedScanQR;

  const CustomAppBar({
    Key? key,
    this.isP2P = false,
    required this.img_path,
    this.id_user,
    this.onPressedNotifications,
    this.onPressedOrders,
    this.onPressedDeals,
    this.onPressedScanQR
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
    final String username = userme['username'] ?? 'No name provided';
    final String userId = userme['id'] ?? 'No ID available';

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
              username,
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
              Row(
                children: [
                  Text(
                    formatLimit(userId),
                    style: TextStyle(
                      color: Color(0xFF80868C),
                      fontSize: 12.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(width: 5.w,),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: userId))
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
                    child: SvgPicture.asset(
                      "assets/copy_icon.svg",
                      color: Color(0xFF80868C),
                      height: 14.h,
                    ),
                  ),
                ],
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
        if (widget.onPressedScanQR != null) ... [
          SvgPicture.asset('assets/qr-scan-svgrepo-com 1.svg'),
          SizedBox(width: 15.w,),
        ],
        GestureDetector(
          onTap: () => widget.onPressedNotifications!(context),
          child: SvgPicture.asset("assets/bell_icon.svg"),
        ),
      ],
    );
  }

  String formatLimit(String id) {
    return id.length > 8 ? '...${id.substring(id.length - 8)}' : id;
  }


}