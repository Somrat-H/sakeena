import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena/core/app_theme.dart';
import 'package:sakeena/model/course_model.dart';
import 'package:sakeena/route/go_route.dart';
import 'package:sakeena/widgets/custom_button.dart';

class CourseCard extends StatelessWidget {
  final CourseData course;
  final bool isSvgImage;

  const CourseCard({super.key, required this.course, this.isSvgImage = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.w,
      margin: EdgeInsets.only(right: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          /// 🔹 Image
          Padding(
            padding: EdgeInsets.all(12.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: SizedBox(
                height: 140.h,
                width: double.infinity,
                child: isSvgImage
                    ? SvgPicture.asset(
                        course.imageAsset,
                        fit: BoxFit.cover,
                        placeholderBuilder: (_) => _placeholder(),
                      )
                    : Image.asset(
                        course.imageAsset,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _error(),
                      ),
              ),
            ),
          ),

          /// 🔹 Content (scroll-safe)
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Status
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C7A7B).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      course.courseStatus.label,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2C7A7B),
                      ),
                    ),
                  ),

                  SizedBox(height: 6.h),

                  /// Title
                  Text(
                    course.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 6.h),

                  /// Instructor
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/healthicons_doctor-male.svg',
                        width: 14.sp,
                        height: 14.sp,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          course.instructor.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 13.sp),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 6.h),

                  /// Lessons & Duration
                  Row(
                    children: [
                      Icon(Icons.menu_book, size: 14.sp),
                      SizedBox(width: 4.w),
                      Text(
                        '${course.courseDetails.lessons} Lessons',
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      SizedBox(width: 8.w),
                      Icon(Icons.calendar_month, size: 14.sp),
                      SizedBox(width: 4.w),
                      Text(
                        course.courseDetails.duration,
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ],
                  ),

                  SizedBox(height: 6.h),

                  /// Duration
                  Row(
                    children: [
                      Icon(Icons.schedule, size: 14.sp),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          course.courseDetails.duration,
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  /// Price + Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        course.price,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2C7A7B),
                        ),
                      ),
                      CustomButton(
                        text: 'View Details',
                        height: 32,
                        width: 110.w,
                        isGradient: true,
                        textColor: Colors.white,
                        onPressed: () {
                          context.push(AppRoutes.courseDetails, extra: course);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: Colors.grey.shade200,
      child: Center(child: Icon(Icons.book, size: 40.sp)),
    );
  }

  Widget _error() {
    return Container(
      color: Colors.grey.shade300,
      child: Center(child: Icon(Icons.broken_image, size: 40.sp)),
    );
  }
}

/// Extension for status label
extension CourseStatusText on CourseStatus {
  String get label {
    switch (this) {
      case CourseStatus.upcoming:
        return 'Upcoming';
      case CourseStatus.live:
        return 'Live';
      case CourseStatus.recorded:
        return 'Recorded';
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sakeena/route/go_route.dart';
// import 'package:sakeena/core/app_theme.dart';

class CourseCardTeacher extends StatelessWidget {
  final String imageUrl;
  final String category;
  final String title;
  final String instructor;
  final int lessons;
  final int weeks;
  final double totalHours;
  final double hoursPerSession;
  final String price;
  final VoidCallback onViewDetails;
  final String status;

  const CourseCardTeacher({
    super.key,
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.instructor,
    required this.lessons,
    required this.weeks,
    required this.totalHours,
    required this.hoursPerSession,
    required this.price,
    required this.onViewDetails,
    this.status = 'Upcoming',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8.r,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 180.h,
                    // width: double.infinity,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 180.h,
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: Icon(Icons.image_not_supported),
                        ),
                      );
                    },
                  ),
                ),
                // Positioned(
                //   top: 12.h,
                //   right: 12.w,
                //   child: Container(
                //     padding: EdgeInsets.symmetric(
                //       horizontal: 12.w,
                //       vertical: 6.h,
                //     ),
                //     decoration: BoxDecoration(
                //       color: const Color(0xFFEBEBEB),
                //       borderRadius: BorderRadius.circular(16.r),
                //     ),
                //     child: Text(
                //       category,
                //       style: TextStyle(
                //         fontSize: 11.sp,
                //         fontWeight: FontWeight.w600,
                //         color: Colors.black,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            // Status Badge
            Padding(
              padding: EdgeInsets.only(left: 16.w, top: 12.h),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  color: status == 'upcoming'
                      ? AppTheme.successColor
                      : status == 'running'
                      ? Colors.red
                      : status == "recorded"
                      ? Colors.blue
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  // Instructor
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 16.sp,
                        color: Colors.grey.shade600,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        instructor,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  // Course Details Grid
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Lessons
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.book_outlined,
                              size: 14.sp,
                              color: Colors.grey.shade600,
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Text(
                                '$lessons Lessons',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Weeks
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 14.sp,
                              color: Colors.grey.shade600,
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Text(
                                '$weeks weeks',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Total Hours
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              size: 14.sp,
                              color: Colors.grey.shade600,
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Text(
                                '$totalHours hr',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Hours per Session
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.schedule_outlined,
                              size: 14.sp,
                              color: Colors.grey.shade600,
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Text(
                                '${hoursPerSession}hr/session',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  // Price and Eye Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     price != '0.00' ?  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                            '\$$price',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                           Text(
                        'One time payment',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryColor,
                        ),
                      )
                       ],
                     ) :   Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                            'Free',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          Text(
                        'One time payment',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryColor,
                        ),
                      )
                       ],
                     ),
                      ElevatedButton(
                        
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFF317773,
                          ), // Brand teal color matching the UI asset
                          foregroundColor:
                              Colors.white, // Crisp white text color
                          elevation: 0, // Flat styling layout design
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              8,
                            ), // Subtle soft border radius corner cut
                          ),
                        ),
                        onPressed: () {
                          onViewDetails();
                        },
                        child: Text(
                          status == "upcoming"
                              ? "Join waitlist"
                              : status == "recorded"
                              ? "Start Learning"
                              : status == "running"
                              ? "Join Class"
                              : "N/A",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
