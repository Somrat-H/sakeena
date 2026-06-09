import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final VoidCallback? onBack;
  final VoidCallback? onNotificationTap;
  final VoidCallback ? onTapCart;
  final String? logoPath;

   const CustomAppBar({
    super.key,
    this.showBackButton = false,
    this.onBack,
    this.onNotificationTap,
    this.onTapCart,
    this.logoPath = 'assets/images/sakeena_logo.svg',
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 45.h,
      leadingWidth: showBackButton ? 56.w : 80.w,

      leading: Padding(
        padding: EdgeInsets.only(left: 16.w),
        child: showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: onBack ?? () => Navigator.pop(context),
              )
            : SvgPicture.asset(
                logoPath!,
                width: 42.w,
                height: 42.h,
              ),
      ),

      actions: [
         IconButton(
          icon: const Icon(Icons.shopping_cart),
          color: Colors.black26,
          onPressed: onTapCart,
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none),
          color: Colors.black,
          onPressed: onNotificationTap,
        ),
        SizedBox(width: 12.w),
      ],
    );
  }
}
