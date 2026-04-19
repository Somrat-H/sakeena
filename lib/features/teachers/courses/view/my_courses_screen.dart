import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/features/teachers/course_detail/course_detail_screen.dart';
import 'package:sakeena/features/teachers/courses/controller/teacher_course_controller.dart';
import 'package:sakeena/features/teachers/courses/view/widget/course_shimmer_card.dart';
import 'package:sakeena/features/teachers/courses/view/widget/category_shimmer_button.dart';
import 'package:sakeena/route/go_route.dart';
import 'package:sakeena/widgets/category_filter_button.dart';
import 'package:sakeena/widgets/course_card.dart';
import 'package:sakeena/widgets/custom_app_bar.dart';
import 'package:sakeena/widgets/view_only_access_card.dart';
import '../../../../core/app_theme.dart';
import '../../_old_course_detail/course_detail.model.dart';

class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TeacherCourseController>();
   
    final dynamicCategories = ['All'] + (controller.courseCategroyResponse.results?.map((e) => e.name ?? '').toList() ?? []);
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                'My Assigned Courses',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryColor,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'View your teaching assignments and course details',
                style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade600),
              ),
              SizedBox(height: 16.h),
              const ViewOnlyAccessCard(),
              SizedBox(height: 20.h),
              Text(
                'Category',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 12.h),
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
                'My Courses',
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
              controller.isLoading
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3, // Show 3 shimmer cards while loading
                      itemBuilder: (context, index) =>
                          const CourseCardShimmer(),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.selectedCategory == 'All'
                          ? controller.teacherCoruseResponse.results!.length
                          : controller.teacherCoruseResponse.results!
                              .where((course) => course.category!.name == controller.selectedCategory)
                              .length,
                      itemBuilder: (context, index) {
                        final filteredCourses = controller.selectedCategory == 'All'
                            ? controller.teacherCoruseResponse.results!
                            : controller.teacherCoruseResponse.results!
                                .where((course) => course.category!.name == controller.selectedCategory)
                                .toList();
                        final course = filteredCourses[index];
                        return CourseCardTeacher(
                          imageUrl:
                              course.thumbnail ??
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9ClZ-sWSzj1r9lMta57sD-X_zuxkbo_1kWw&s",
                          category: course.category!.name!,
                          title: course.title!,
                          instructor:
                              "${course.teacher!.user!.firstName!} ${course.teacher!.user!.lastName}",
                          lessons: course.totalLessons!,
                          weeks: course.durationInWeeks!,
                          totalHours: double.parse(course.totalHours!),
                          hoursPerSession: double.parse(
                            course.hoursPerSession!,
                          ),
                          price: course.price!,
                          status: course.category!.name!,
                          onViewDetails: () async{
                            if (course.status == 'upcoming') {
                              // Show popup dialog for Upcoming courses
                              showDialog(
                                context: context,
                                builder: (_) => CourseDetailDialog(
                                  course: CourseDetailModelOld(
                                    courseTitle: course.title!,
                                    instructor:
                                        "${course.teacher!.user!.firstName!} ${course.teacher!.user!.lastName}",
                                    category: course.category!.name!,
                                    status: course.status!,
                                    price: course.price!,
                                    duration: '${course.durationInWeeks} weeks',
                                    totalLessons: course.totalLessons!,
                                    rating: 4.5,
                                    totalEnrolled: 120,
                                    students: [
                                      {
                                        'name': 'Emma Wilson',
                                        'email': 'emma.w@email.com',
                                      },
                                      {
                                        'name': 'Michael Chen',
                                        'email': 'michael.c@email.com',
                                      },
                                      // Add more students dynamically
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) => const Center(child: CircularProgressIndicator()),
                              );
                              await controller.getCourseDetails(course.id!);
                              if (context.mounted) {
                                
                                context.push(AppRoutes.courseDetails);
                              }
                            }
                          },

                          // onViewDetails: () {
                          //   print("Navigating to detail...");
                          //   context.push(
                          //     // TeachersRoutes.courseDetail,
                          //     AppRoutes.courseDetails,
                          //     extra: CourseDetailModelOld(
                          //       courseTitle: course['title'],
                          //       instructor: course['instructor'],
                          //       category: course['category'],
                          //       status: course['status'],
                          //       price: course['price'],
                          //       duration: '${course['weeks']} weeks',
                          //       totalLessons: course['lessons'],
                          //       rating: 4.5,
                          //       totalEnrolled: 120,
                          //       students: [],
                          //     ),
                          //   );
                          // },
                        );
                      },
                    ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
