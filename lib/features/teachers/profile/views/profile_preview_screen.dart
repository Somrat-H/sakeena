import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena/model/course_model.dart';
import 'package:sakeena/route/go_route.dart';
import 'package:sakeena/widgets/achievement_section.dart';
import 'package:sakeena/widgets/booking_dialog_box.dart';
import 'package:sakeena/widgets/course_card.dart';
import 'package:sakeena/widgets/course_taught_card.dart';
import 'package:sakeena/widgets/custom_app_bar.dart';
import 'package:sakeena/widgets/custom_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sakeena/widgets/education_section_card.dart';

class CounselorPreviewPage extends StatelessWidget {
  final String counselorId;

  CounselorPreviewPage({super.key, required this.counselorId});

  final List<Map<String, dynamic>> taughtCourses = [
    {
      'title': 'Islamic Marriage Counseling Essentials',
      'type': 'Live Course',
      'color': Colors.red,
      'rating': 4.9,
      'students': 432,
    },
    {
      'title': 'Spiritual Healing Through Dhikr',
      'type': 'Recorded',
      'color': Colors.blue,
      'rating': 4.7,
      'students': 891,
    },
    {
      'title': 'Youth Islamic Mentorship',
      'type': 'Live Course',
      'color': Colors.red,
      'rating': 4.8,
      'students': 500,
    },
  ];

  final List<Map<String, dynamic>> courses = [
    {
      'title': 'Tafsir Al-Quran: Understanding Deeply',
      'instructor': 'Dr. Ahmed Hassan',
      'lessons': '24 Lessons',
      'weeks': '12 weeks',
      'duration': '1.5 hrs',
      'sessionDuration': 'Weekly',
      'price': '\$99',
      'image': 'assets/images/quran_image.png',
      'isUpcoming': true,
    },
    {
      'title': 'Islamic Mental Health & Wellbeing',
      'instructor': 'Dr. Fatima Rahman',
      'lessons': '18 Lessons',
      'weeks': '8 weeks',
      'duration': '1 hr',
      'sessionDuration': 'Weekly',
      'price': '\$79',
      'image': 'assets/images/quran_recite_image.png',
      'isUpcoming': false,
    },
  ];

  Map<String, dynamic> _getCounselorData() {
    final counselorsData = {
      '1': {
        'name': 'Dr. Fatima Rahman',
        'title': 'Clinical Psychologist & Islamic Scholar',
        'imagePath': 'assets/images/teacher_screen_image.png',
        'availability': 'Available',
        'email': 'fatima@sakeena.com',
        'location': 'London, UK',
        'rating': 4.9,
        'students': 2456,
        'courses': 8,
        'specialties': [
          'Islamic Psychology',
          'Anxiety Management',
          'Mindfulness',
          'Trauma-Informed Care',
          'CBT',
        ],
        'about':
            'Dr. Fatima Rahman is a board-certified clinical psychologist with over 15 years of experience integrating Islamic principles with evidence-based psychological treatments.',
      },
    };
    return counselorsData[counselorId]!;
  }

  final List<EducationItemModel> educationList = [
    EducationItemModel(
      degree: 'PhD in Clinical Psychology',
      institute: 'University of Cambridge',
      year: '2008',
    ),
    EducationItemModel(
      degree: 'MA in Islamic Studies',
      institute: 'Al-Azhar University',
      year: '2005',
    ),
    EducationItemModel(
      degree: 'BA in Psychology',
      institute: 'University of London',
      year: '2003',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const teal = Color(0xFF2C7A7B);
    final data = _getCounselorData();

    return Scaffold(
      appBar: CustomAppBar(),
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Colors.black),
      //     onPressed: () => context.pop(),
      //   ),
      //   title: const Text(
      //     'Back to Teachers',
      //     style: TextStyle(
      //       color: Colors.black,
      //       fontSize: 14,
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  Text(
                    'Back to Teachers',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              /// ================= PROFILE SECTION (NO WHITE BG) =================
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50.r,
                      backgroundImage: AssetImage(data['imagePath']),
                    ),
                    SizedBox(height: 12.h),

                    // Availability Badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8FFF0),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: const Color(0xFFC3FFCA)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/circle_check_Icon_green.svg',
                            width: 14.sp,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            data['availability'],
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF008236),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),

                    Text(
                      data['name'],
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        data['title'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Contact Info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.email_outlined, size: 14.sp),
                        SizedBox(width: 6.w),
                        Text(data['email'], style: TextStyle(fontSize: 11.sp)),
                        SizedBox(width: 12.w),
                        Icon(Icons.location_on_outlined, size: 14.sp),
                        SizedBox(width: 6.w),
                        Text(
                          data['location'],
                          style: TextStyle(fontSize: 11.sp),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Stats
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        _StatBadge(
                          svgPath: 'assets/icons/star_icon.svg',
                          value: '4.9',
                          label: 'Rating',
                        ),
                        SizedBox(width: 24),
                        _StatBadge(
                          svgPath: 'assets/icons/book_icon.svg',
                          value: '8',
                          label: 'Courses',
                        ),
                        SizedBox(width: 24),
                        _StatBadge(
                          icon: Icons.people,
                          value: '2456',
                          label: 'Students',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// ================= SPECIALTIES =================
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: (data['specialties'] as List<String>)
                      .map(
                        (s) => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(color: teal.withOpacity(0.3)),
                          ),
                          child: Text(
                            s,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: teal,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),

              SizedBox(height: 20.h),

              /// ================= BUTTONS =================
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    CustomButton(
                      icon: Icon(
                        Icons.calendar_month_outlined,
                        size: 16.sp,
                        color: Colors.white,
                      ),
                      text: 'Book Consultation',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return BookingDialog(
                              counselorName: 'Dr. Fatima Rahman',
                              counselorTitle: 'Clinical Psychologist',
                              counselorImage:
                                  'assets/images/teacher_screen_image.png',
                              price: 50.00,
                            );
                          },
                        );
                      },
                      isGradient: true,
                      textColor: Colors.white,
                    ),
                    SizedBox(height: 12.h),
                    CustomButton(
                      text: 'View Courses',
                      onPressed: () => context.go(AppRoutes.coursesScreen),
                      isGradient: true,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              /// ================= ABOUT (WHITE BACKGROUND ONLY) =================
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      data['about'],
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade700,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              EducationSection(educationList: educationList),

              SizedBox(height: 24.h),

              /// ================= COURSES SECTION =================
              Container(
                width: double.infinity,
                // color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Showing ${courses.length} courses',
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Arimo',
                            ),
                          ),
                          CustomButton(
                            text: 'View all',
                            onPressed: () {
                              context.push('/courses_screen');
                            },
                            isGradient: true,
                            textColor: Colors.white,
                            height: 32.h,
                            width: 80.w,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // SizedBox(
                    //   height: 400.h,
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     padding: EdgeInsets.only(left: 16.w),
                    //     itemCount: courses.length,
                    //     itemBuilder: (context, index) {
                    //       final course = courses[index];
                    //       return CourseCard(course: CourseData.mock());
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Courses Taught',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    ...taughtCourses.map(
                      (course) => CourseTaughtCard(
                        title: course['title'],
                        type: course['type'],
                        typeColor: course['color'],
                        rating: course['rating'],
                        students: course['students'],
                      ),
                    ),
                  ],
                ),
              ),

              AchievementSection(
                achievements: [
                  'Counseled over 1000 families',
                  'Imam and counselor at major Islamic center',
                  'Regular contributor to Islamic counseling publications',
                  'Founded Islamic Youth Mentorship Program',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ================= STAT BADGE =================
class _StatBadge extends StatelessWidget {
  final IconData? icon;
  final String? svgPath;
  final String value;
  final String label;

  const _StatBadge({
    this.icon,
    this.svgPath,
    required this.value,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const teal = Color(0xFF2C7A7B);

    return Column(
      children: [
        Row(
          children: [
            if (svgPath != null)
              SvgPicture.asset(
                svgPath!,
                width: 16.sp,
                colorFilter: const ColorFilter.mode(teal, BlendMode.srcIn),
              )
            else
              Icon(icon, size: 16.sp, color: teal),
            SizedBox(width: 4.w),
            Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: teal,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(label, style: TextStyle(fontSize: 10.sp)),
      ],
    );
  }
}
