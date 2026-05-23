import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/core/constant/app_colors.dart';
import 'package:intl/intl.dart';

import 'package:sakeena/features/student/home/next_live_class_card.dart';
import 'package:sakeena/features/student/home/provider/student_dashboard_provider.dart';
import 'package:sakeena/features/student/home/stat_card.dart';
import 'package:sakeena/features/student/home/widget/my_course_card.dart';
import 'package:sakeena/features/student/home/widget/my_ordercard.dart';
import 'package:sakeena/features/student/home/widget/session_card.dart';
import 'package:sakeena/widgets/custom_app_bar.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<StudentDashboardProvider>();
    return Scaffold(
      appBar: CustomAppBar(),
      body: controller.isLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 150.h,
                      child: Stack(
                        children: [
                          // 1. The Background SVG
                          Positioned.fill(
                            child: SvgPicture.asset(
                              'assets/images/background.svg',
                              fit: BoxFit.cover,
                            ),
                          ),

                          // 2. Centered Text Overlay
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Column(
                                mainAxisSize: MainAxisSize
                                    .min, // Keeps the column tightly wrapped around text
                                children: [
                                  Text(
                                    "Welcome to your dashboard",
                                    style: TextStyle(
                                      color: Color(
                                        0xFF205A60,
                                      ), // Change color based on your SVG background contrast
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ), // Spacing between the two lines
                                  Text(
                                    "Access your learning space",
                                    style: TextStyle(
                                      color: Color(0xFF205A60),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 12.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StatCard(
                            title: 'Active Courses',
                            value:
                                controller
                                    .studentDashboardResponse
                                    .stats
                                    ?.totalActiveCourses
                                    ?.toString() ??
                                '0',
                            icon: Icons.menu_book_outlined,
                          ),
                          12.verticalSpace,

                          StatCard(
                            title: "Your Book",
                            value:
                                controller
                                    .studentDashboardResponse
                                    .stats
                                    ?.totalBooks
                                    ?.toString() ??
                                "0",
                            icon: Icons
                                .menu_book_outlined, // Consider changing to Icons.book_outlined if you want a distinct icon
                          ),
                          12.verticalSpace,

                          StatCard(
                            title: "Your Order",
                            value:
                                controller
                                    .studentDashboardResponse
                                    .stats
                                    ?.totalOrders
                                    ?.toString() ??
                                "0",
                            icon: Icons
                                .menu_book_outlined, // Consider changing to Icons.shopping_bag_outlined if you want a distinct icon
                          ),

                          12.verticalSpace,

                          Text(
                            "Upcoming session",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          12.verticalSpace,
                          SessionConsultationCard(
                            teacherName: controller
                                .studentDashboardResponse
                                .upcomingSessions!
                                .first
                                .consultationDetails!
                                .teacher!
                                .fullName
                                .toString(),
                            dateTimeText: formatSessionDateTime(
                              controller
                                  .studentDashboardResponse
                                  .upcomingSessions!
                                  .first
                                  .scheduledStart!,
                            ),
                            consultationType: controller
                                .studentDashboardResponse
                                .upcomingSessions!
                                .first
                                .consultationDetails!
                                .title!,
                            onReschedule: () {
                              print("Reschedule tapped!");
                            },
                            onJoinSession: () {
                              print("Opening live session view...");
                            },
                          ),
                          12.verticalSpace,
                          NextLiveClassCard(
                            title: 'Next Live Class',
                            courseName: controller
                                .studentDashboardResponse
                                .nextLiveClass!
                                .title!,
                            instructor: 'John Doe',
                            dateTime: formatSessionDateTime(
                              controller
                                  .studentDashboardResponse
                                  .nextLiveClass!
                                  .scheduledAt
                                  .toString(),
                            ),
                            onJoin: () {},
                          ),
                          12.verticalSpace,
                          Text(
                            "My Courses",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          12.verticalSpace,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics:
                                const BouncingScrollPhysics(), // Provides a smooth native scrolling feel
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                controller
                                        .studentDashboardResponse
                                        .myCourses
                                        ?.length ??
                                    0,
                                (index) {
                                  final courseItem = controller
                                      .studentDashboardResponse
                                      .myCourses?[index];
                                  final courseDetails = courseItem?.course;

                                  return Padding(
                                    padding: EdgeInsets.only(
                                      right: 12
                                          .w, // Dynamic spacing between card elements
                                      left: index == 0
                                          ? 4.w
                                          : 0, // Slight indentation for the first card
                                    ),
                                    child: MyCourseCard(
                                      imageUrl:
                                          courseDetails?.thumbnail
                                              ?.toString() ??
                                          '',
                                      statusText:
                                          courseDetails?.status ?? 'Unknown',
                                      courseTitle:
                                          courseDetails?.title ??
                                          'Untitled Course',
                                      instructorName:
                                          courseDetails?.teacher?.fullName ??
                                          'Instructor',
                                      lessonsCount: 0,
                                      weeksCount: 0,
                                      hoursCount: 0,
                                      paceType: "Self paced",
                                      onTap: () {
                                        // Navigate to course detail views or dashboard tabs
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          12.verticalSpace,
                          Text(
                            "My Orders",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          12.verticalSpace,

                          Column(
                            children: List.generate(
                              controller
                                  .studentDashboardResponse
                                  .myOrders!
                                  .length,
                              (index) {
                                final myOrder = controller
                                    .studentDashboardResponse
                                    .myOrders![index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom :8.0),
                                  child: MyOrderCard(
                                    statusText: myOrder.status!,
                                    orderTitle: "Order #${myOrder.id}",
                                    itemCount: myOrder.items!.length,
                                    dateText: formatSessionDateTime(
                                      myOrder.createdAt.toString(),
                                    ),
                                    totalAmount: 150.00,
                                    onViewDetails: () {
                                      // Navigate to full invoice breakdown or order profile tracking
                                    },
                                  ),
                                );
                              },
                            ),
                          ),

                          40.verticalSpace,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

String formatSessionDateTime(String isoString) {
  try {
    // 1. Parse the ISO timestamp into a DateTime object
    DateTime dateTime = DateTime.parse(isoString).toLocal();

    // 2. Format using the pattern: Day Month Year, Hour:Minute
    // 'd' = day, 'MMM' = short month name, 'y' = year, 'HH:mm' = 24-hour time
    String formattedDate = DateFormat("d MMM y, HH:mm").format(dateTime);

    return formattedDate;
  } catch (e) {
    // Fallback if the input string format is corrupted
    return isoString;
  }
}
