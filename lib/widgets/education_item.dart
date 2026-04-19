import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/core/app_theme.dart';
import 'package:sakeena/features/teachers/profile/controller/teacher_profile_controller.dart';

class EducationItem extends StatelessWidget {
  final String degree;
  final String institution;
  final IconData icon;

  const EducationItem({
    super.key,
    required this.degree,
    required this.institution,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // Temporary variables to hold input changes

    final controller = context.watch<TeacherProfileController>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color:  Colors.white ,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: 
               AppTheme.primaryColor
              
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.primaryColor, size: 24.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: 
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        degree,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        institution,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
          ),
         
        ],
      ),
    );
  }
}
