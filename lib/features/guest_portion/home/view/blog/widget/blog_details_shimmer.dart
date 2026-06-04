import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class BlogDetailsShimmer extends StatelessWidget {
  const BlogDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 240.h, width: double.infinity, color: Colors.white),
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 30.h, width: double.infinity, color: Colors.white),
                  SizedBox(height: 8.h),
                  Container(height: 30.h, width: 200.w, color: Colors.white),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      CircleAvatar(radius: 20.r, backgroundColor: Colors.white),
                      SizedBox(width: 12.w),
                      Container(height: 14.h, width: 100.w, color: Colors.white),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Container(height: 16.h, width: double.infinity, color: Colors.white),
                  SizedBox(height: 8.h),
                  Container(height: 16.h, width: double.infinity, color: Colors.white),
                  SizedBox(height: 8.h),
                  Container(height: 16.h, width: 180.w, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}