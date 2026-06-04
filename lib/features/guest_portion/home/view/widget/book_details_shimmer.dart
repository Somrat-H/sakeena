import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class BookDetailsShimmer extends StatelessWidget {
  const BookDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120.w,
                  height: 170.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 18.h, width: 60.w, color: Colors.white),
                      SizedBox(height: 8.h),
                      Container(height: 24.h, width: 160.w, color: Colors.white),
                      SizedBox(height: 12.h),
                      Container(height: 16.h, width: 100.w, color: Colors.white),
                      SizedBox(height: 8.h),
                      Container(height: 20.h, width: 80.w, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Container(height: 40.h, width: double.infinity, color: Colors.white),
            SizedBox(height: 12.h),
            Container(height: 40.h, width: double.infinity, color: Colors.white),
            SizedBox(height: 32.h),
            Container(height: 20.h, width: 120.w, color: Colors.white),
            SizedBox(height: 12.h),
            Container(height: 100.h, width: double.infinity, color: Colors.white),
          ],
        ),
      ),
    );
  }
}