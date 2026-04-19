import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena/widgets/custom_app_bar.dart';

import 'package:sakeena/widgets/profile_header.dart';
import 'package:sakeena/widgets/book_card.dart';
import 'package:sakeena/widgets/profile_page_book_card.dart';
import 'package:sakeena/widgets/profile_page_consultation_card.dart';
import 'package:sakeena/widgets/profile_page_course_card.dart';
import 'package:sakeena/widgets/profile_page_tab_selector.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileHeader(),
            SizedBox(height: 16.h),

            /// 🔥 Clickable Tabs
            TabSelector(
              selectedIndex: selectedTab,
              onChanged: (index) {
                setState(() {
                  selectedTab = index;
                });
              },
            ),

            SizedBox(height: 16.h),

            /// 🔁 TAB CONTENT
            if (selectedTab == 0) ...[
              CourseProgressCard(
                title: 'Stress Management Fundamentals',
                instructor: 'Sarah Johnson',
                category: 'Stress',
                progress: 0.65,
                courseThumbImage: 'assets/images/course_thumb_Image.png',
              ),
              SizedBox(height: 8.h),
              CourseProgressCard(
                title: 'Stress Management Fundamentals',
                instructor: 'Sarah Johnson',
                category: 'Stress',
                progress: 0.65,
                courseThumbImage: 'assets/images/course_thumb_Image.png',
              ),
              SizedBox(height: 8.h),
              CourseProgressCard(
                title: 'Stress Management Fundamentals',
                instructor: 'Sarah Johnson',
                category: 'Stress',
                progress: 0.65,
                courseThumbImage: 'assets/images/course_thumb_Image.png',
              ),
              SizedBox(height: 8.h),
              CourseProgressCard(
                title: 'Stress Management Fundamentals',
                instructor: 'Sarah Johnson',
                category: 'Stress',
                progress: 0.65,
                courseThumbImage: 'assets/images/course_thumb_Image.png',
              ),
            ] else if (selectedTab == 1) ...[
              ProfilePageBookCard(
                title: 'The Power of Mindfulness',
                author: 'Jon Kabat-Zinn',
                imagePath: 'assets/images/book_1.png',
                description:
                    'Evidence-based strategies to overcome anxiety and live a fuller life',
                category: 'Anxiety',
              ),
              SizedBox(height: 8.h),
              ProfilePageBookCard(
                title: 'The Power of Mindfulness',
                author: 'Jon Kabat-Zinn',
                imagePath: 'assets/images/book_1.png',
                description:
                    'Evidence-based strategies to overcome anxiety and live a fuller life',
                category: 'Anxiety',
              ),
              SizedBox(height: 8.h),
              ProfilePageBookCard(
                title: 'The Power of Mindfulness',
                author: 'Jon Kabat-Zinn',
                imagePath: 'assets/images/book_1.png',
                description:
                    'Evidence-based strategies to overcome anxiety and live a fuller life',
                category: 'Anxiety',
              ),
            ] else ...[
              ProfilePageConsultationCard(
                doctorName: 'Dr. Ayesha Rahman',
                date: 'December 15, 2024',
                category: 'Stress Management',
                notes: 'Discussed work-life balance strategies',
                tag: 'Stress Management',
              ),
              SizedBox(height: 8.h),
              ProfilePageConsultationCard(
                doctorName: 'Dr. Ayesha Rahman',
                date: 'December 15, 2024',
                category: 'Stress Management',
                notes: 'Discussed work-life balance strategies',
                tag: 'Stress Management',
              ),
              SizedBox(height: 8.h),
              ProfilePageConsultationCard(
                doctorName: 'Dr. Ayesha Rahman',
                date: 'December 15, 2024',
                category: 'Stress Management',
                notes: 'Discussed work-life balance strategies',
                tag: 'Stress Management',
              ),
              SizedBox(height: 8.h),
              SafeArea(
                child: ProfilePageConsultationCard(
                  doctorName: 'Dr. Ayesha Rahman',
                  date: 'December 15, 2024',
                  category: 'Stress Management',
                  notes: 'Discussed work-life balance strategies',
                  tag: 'Stress Management',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
