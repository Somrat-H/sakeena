import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena/core/app_theme.dart';

class ProfileSectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const ProfileSectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.h),
        Row(
          children: [
            Icon(
              icon,
              color: AppTheme.primaryColor,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
           Expanded(
      child: Text(
        title,
        overflow: TextOverflow.ellipsis, // Adds "..." if text is too long
        maxLines: 1,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppTheme.primaryColor,
        ),
      ),
    ),
          ],
        ),
        SizedBox(height: 16.h),
        child,
      ],
    );
  }
}
