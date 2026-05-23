import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sakeena/core/app_theme.dart';
import 'package:sakeena/features/teachers/dashboard/controller/teacher_dashboard_controller.dart';
import 'package:sakeena/widgets/custom_app_bar.dart';
import 'package:sakeena/widgets/stat_card.dart';
import 'package:sakeena/widgets/session_card.dart';
import 'package:sakeena/widgets/upload_item.dart';
import 'package:sakeena/widgets/teacher_bottom_navigation.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TeacherDashboardController>();

    return Scaffold(
      appBar: CustomAppBar(),
      body: controller.isLoading
          ? _buildShimmerEffect()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title Section
                        Text(
                          'Teacher Dashboard',
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Welcome back! Here\'s your overview for today.',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        // Stat Cards
                        StatCard(
                          title: 'Active Courses',
                          value: controller.teacherDashboardResponse.activeCourses?.toString() ?? '0',
                          icon: Icons.book_outlined,
                          backgroundColor: Color(0xFFE3F2FD),
                          iconColor: Color(0xFF2196F3),
                        ),
                        SizedBox(height: 12.h),
                        StatCard(
                          title: 'Live Sessions Today',
                          value: controller.teacherDashboardResponse.liveSessionsToday?.toString() ?? '0',
                          icon: Icons.videocam_outlined,
                          backgroundColor: Color(0xFFE8F5E9),
                          iconColor: Color(0xFF4CAF50),
                        ),
                        SizedBox(height: 12.h),
                        StatCard(
                          title: 'New Uploads',
                          value: controller.teacherDashboardResponse.recentUploads?.length.toString() ?? '0',
                          icon: Icons.cloud_upload_outlined,
                          backgroundColor: Color(0xFFF3E5F5),
                          iconColor: Color(0xFF9C27B0),
                        ),
                        SizedBox(height: 32.h),
                        // Upcoming Live Sessions
                        Text(
                          'Upcoming Live Sessions',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        ...?controller.teacherDashboardResponse.upcomingLiveSessions?.map((session) => Column(
                          children: [
                            SessionCardForTeacher(
                              title: session.title ?? '',
                              time: session.scheduledAt ?? '',
                              studentCount: session.enrolledCount ?? 0,
                            ),
                            SizedBox(height: 12.h),
                          ],
                        )),
                        SizedBox(height: 32.h),
                        // Recent Uploads
                        Text(
                          'Recent Uploads',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        ...?controller.teacherDashboardResponse.recentUploads?.map((upload) => Column(
                          children: [
                            UploadItem(
                              fileName: upload.title ?? '',
                              category: upload.courseTitle ?? '',
                              date: 'N/A', // Since date is not in the model
                            ),
                            SizedBox(height: 12.h),
                          ],
                        )),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Section
                  Container(
                    height: 28.sp,
                    width: 200.w,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    height: 14.sp,
                    width: 250.w,
                    color: Colors.white,
                  ),
                  SizedBox(height: 24.h),
                  // Stat Cards
                  ...List.generate(3, (index) => Column(
                    children: [
                      Container(
                        height: 80.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      SizedBox(height: 12.h),
                    ],
                  )),
                  SizedBox(height: 32.h),
                  // Upcoming Live Sessions
                  Container(
                    height: 18.sp,
                    width: 180.w,
                    color: Colors.white,
                  ),
                  SizedBox(height: 16.h),
                  ...List.generate(3, (index) => Column(
                    children: [
                      Container(
                        height: 100.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      SizedBox(height: 12.h),
                    ],
                  )),
                  SizedBox(height: 32.h),
                  // Recent Uploads
                  Container(
                    height: 18.sp,
                    width: 120.w,
                    color: Colors.white,
                  ),
                  SizedBox(height: 16.h),
                  ...List.generate(3, (index) => Column(
                    children: [
                      Container(
                        height: 60.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      SizedBox(height: 12.h),
                    ],
                  )),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
