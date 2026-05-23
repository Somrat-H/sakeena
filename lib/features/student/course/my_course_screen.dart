import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/features/student/course/provider/student_course_provider.dart';
import 'package:sakeena/features/teachers/courses/view/widget/course_shimmer_card.dart';
import 'package:sakeena/features/teachers/courses/view/widget/category_shimmer_button.dart';
import 'package:sakeena/route/teachers_routes.dart';
import 'package:sakeena/widgets/category_filter_button.dart';
import 'package:sakeena/widgets/course_card.dart';
import 'package:sakeena/widgets/custom_app_bar.dart';
import '../../../../core/app_theme.dart';

class StudentCourseScreen extends StatelessWidget {
  const StudentCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<StudentCourseProvider>();
    
    final dynamicCategories = ['All'] +  ["Recoreded"] +  ["Running"] +  ["Upcoming"] +(controller.courseCategroyResponse.results?.map((e) => e.name ?? '').toList() ?? []);
    
    // Direct reference to the raw server results list
    final coursesList = controller.stundeProfileResponse.results ?? [];

    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Categories Filter Section ---
              controller.isCategoryLoading
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(3, (index) => Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: const CategoryFilterButtonShimmer(),
                        )),
                      ),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: dynamicCategories.map((category) {
                          return Padding(
                            padding: EdgeInsets.only(right: 8.w),
                            child: CategoryFilterButton(
                              label: category,
                              isSelected: controller.selectedCategory == category,
                              onTap: () {
                                controller.setSelectedCategory(category);
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
              SizedBox(height: 20.h),
              Text(
                'All Courses',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryColor,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Create and manage your course offerings',
                style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade600),
              ),
              SizedBox(height: 16.h),
              
              // --- Dynamic Shimmer Loading or Course Content Display ---
              controller.isLoading
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3, 
                      itemBuilder: (context, index) => const CourseCardShimmer(),
                    )
                  : Column(
                      children: [
                        // Safe fallback handling for empty states
                        if (coursesList.isEmpty)
                          Container(
                            height: 150.h,
                            alignment: Alignment.center,
                            child: Text(
                              "No courses found.",
                              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                            ),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: coursesList.length,
                            itemBuilder: (context, index) {
                              final course = coursesList[index];
                              
                              return CourseCardTeacher(
                                imageUrl: course.thumbnail ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9ClZ-sWSzj1r9lMta57sD-X_zuxkbo_1kWw&s",
                                category: course.category == null ? 'Uncategorized' : course.category!.name ?? 'Uncategorized',
                                title: course.title ?? 'Untitled Course',
                                instructor: "${course.teacher?.user?.firstName ?? ''} ${course.teacher?.user?.lastName ?? ''}",
                                lessons: course.totalLessons ?? 0,
                                weeks: course.durationInWeeks ?? 0,
                                totalHours: double.tryParse(course.totalHours ?? '0') ?? 0.0,
                                hoursPerSession: double.tryParse(course.hoursPerSession ?? '0') ?? 0.0,
                                price: course.price ?? "0.0",
                                status: course.status ?? 'Uncategorized',
                                onViewDetails: () async {
                                  if (course.id != null) {
                                    context.push(TeachersRoutes.courseDetail, extra: course.id);
                                  }
                                },
                              );
                            },
                          ),
                        
                        // --- Integrated Dynamic Footer Pagination ---
                        if (controller.totalPagesCount > 1) ...[
                          SizedBox(height: 24.h),
                          AppPaginationControls(
                            currentPage: controller.currentPage,
                            totalPages: controller.totalPagesCount,
                            onPageChanged: (page) => controller.changePage(page),
                          ),
                        ],
                      ],
                    ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Visual Pagination Widget Block ---
class AppPaginationControls extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;

  const AppPaginationControls({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    const Color activeTeal = Color(0xFF2C7A7B);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Left Chevron Arrow Button
        GestureDetector(
          onTap: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade50,
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Icon(
              Icons.chevron_left, 
              size: 18.sp, 
              color: currentPage > 1 ? Colors.grey.shade600 : Colors.grey.shade300,
            ),
          ),
        ),
        SizedBox(width: 8.w),

        // Generated Page Number Circles
        ...List.generate(totalPages, (index) {
          int pageNumber = index + 1;
          bool isActive = pageNumber == currentPage;

          return GestureDetector(
            onTap: () => onPageChanged(pageNumber),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? activeTeal : const Color(0xFFF4F6F8),
                boxShadow: isActive ? [
                  BoxShadow(
                    color: activeTeal.withOpacity(0.15),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ] : null,
              ),
              child: Center(
                child: Text(
                  pageNumber.toString(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: isActive ? Colors.white : Colors.grey.shade700,
                  ),
                ),
              ),
            ),
          );
        }),

        SizedBox(width: 8.w),
        
        // Right Chevron Arrow Button
        GestureDetector(
          onTap: currentPage < totalPages ? () => onPageChanged(currentPage + 1) : null,
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade50,
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Icon(
              Icons.chevron_right, 
              size: 18.sp, 
              color: currentPage < totalPages ? Colors.grey.shade600 : Colors.grey.shade300,
            ),
          ),
        ),
      ],
    );
  }
}