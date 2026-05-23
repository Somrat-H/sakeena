import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCourseCard extends StatelessWidget {
  final String imageUrl;
  final String statusText; // e.g., "Running"
  final String courseTitle; // e.g., "(Test) Course"
  final String instructorName; // e.g., "Dr. Zaheer Ahmad"
  final int lessonsCount;
  final int weeksCount;
  final int hoursCount;
  final String paceType; // e.g., "Self paced"
  final VoidCallback? onTap;

  const MyCourseCard({
    super.key,
    required this.imageUrl,
    required this.statusText,
    required this.courseTitle,
    required this.instructorName,
    required this.lessonsCount,
    required this.weeksCount,
    required this.hoursCount,
    required this.paceType,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Shared color constants
    const Color primaryTeal = Color(0xFF2C7A7B);
    const Color statusRed = Color(0xFFB71C1C);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 320.w, // Fixed responsive width for list view grids
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. Course Banner Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              child: Image.network(
                imageUrl,
                height: 180.h,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 180.h,
                  color: Colors.grey.shade200,
                  child: const Center(child: Icon(Icons.image_not_supported_outlined)),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. Status Badge ("Running")
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: statusRed,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6.w,
                          height: 6.w,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          statusText,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // 3. Course Title
                  Text(
                    courseTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Arimo',
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // 4. Instructor info
                  Row(
                    children: [
                      Icon(Icons.person_outline, size: 16.sp, color: primaryTeal),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          instructorName,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 12.h),
                  Divider(color: Colors.grey.shade100, height: 1),
                  SizedBox(height: 12.h),

                  // 5. Info Grid Metrics (Lessons, Weeks, Hours, Pace)
                  GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3.5,
                      mainAxisSpacing: 4.h,
                      crossAxisSpacing: 8.w,
                    ),
                    children: [
                      _buildMetricItem(Icons.menu_book_outlined, "$lessonsCount Lessons"),
                      _buildMetricItem(Icons.calendar_today_outlined, "$weeksCount weeks"),
                      _buildMetricItem(Icons.access_time, "$hoursCount hr"),
                      _buildMetricItem(Icons.safety_check ?? Icons.speed, paceType), 
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

  // Helper builder for individual grid details icons
  Widget _buildMetricItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15.sp, color: const Color(0xFF557A7A)),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey.shade700,
              fontFamily: 'Arimo',
            ),
          ),
        ),
      ],
    );
  }
}