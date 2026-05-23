import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena/core/app_theme.dart';
import 'package:sakeena/widgets/blog_card.dart';
import 'package:sakeena/widgets/custom_app_bar.dart';
import 'package:sakeena/widgets/custom_button.dart';
import 'package:sakeena/widgets/filter_section.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const categories = ['All', 'Mental Health', 'Spiritual Growth'];

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF7AA4A5), Color(0xFF205A60)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              size: 24.sp,
                              color: Colors.white,
                            ),
                            SizedBox(width: 60.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0x33FFFFFF),
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(color: Colors.white70),
                              ),
                              child: Text(
                                'Knowledge & Insights',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 14.h),

                  // Title
                  Text(
                    'Sakeena Institute Blog',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Arimo",
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // Subtitle
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      'Explore articles on Islamic psychology, mental wellness, and spiritual growth',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ),

                  SizedBox(height: 18.h),

                  // Search Field
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 13.sp,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white.withOpacity(0.8),
                        size: 20.sp,
                      ),
                      filled: true,
                      fillColor: Color(0x1AFFFFFF),
                      contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FilterSection(
            
                    items: categories,
                    selectedItem: 'All',
                    onSelected: (value) {
                      debugPrint('Selected category: $value');
                    },
                    isHorizontal: true,
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlogCard(
                    imagePath: 'assets/images/blog_one.png',
                    date: 'Dec 22, 2025',
                    readTime: '6 min read',
                    category: 'Relationships',
                    title:
                        'Building Healthy Relationships Through Islamic Values',
                    description:
                        'Learn how Islamic principles can strengthen your family bonds and improve communication.',
                    author: 'Dr. Sarah Ahmed',
                    onTap: () {
                      context.push('/blog/2');
                    },
                  ),
                  SizedBox(height: 8.h),
                  BlogCard(
                    imagePath: 'assets/images/blog_two.png',
                    date: 'Dec 20, 2025',
                    readTime: '8 min read',
                    category: 'Mental Health',
                    title: 'Healing Trauma with Faith and Professional Support',
                    description:
                        'Combining Islamic spiritual practices with evidence-based therapeutic approaches for trauma recovery.',
                    author: 'Dr. Ahmed Youssef',
                    onTap: () {
                      context.push('/blog/2');
                    },
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  text: 'View all',
                  textColor: Colors.white,
                  onPressed: () {},
                  isGradient: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
