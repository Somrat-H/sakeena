import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena/features/guest/video/related_video_section.dart';
import 'package:sakeena/features/guest/video/video_details_section.dart';
import 'package:sakeena/widgets/custom_app_bar.dart';
import 'package:sakeena/widgets/filter_section.dart';

class VideoDescriptionScreen extends StatelessWidget {
  const VideoDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const categories = ['All', 'Introduction', 'Methodology'];

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: context.pop,
                    icon: Icon(Icons.arrow_back, color: Color(0xFF205A60)),
                  ),
                  Text(
                    "Back",
                    style: TextStyle(
                      fontFamily: 'Arimo',
                      color: Color(0xFF205A60),
                    ),
                  ),
                ],
              ),
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
                    Text(
                      'Video Library',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Arimo",
                        color: Colors.white,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        'Watch our collection of educational videos on Islamic psychology, mental wellness, and spiritual growth',
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

              SizedBox(height: 10.h),
              const VideoDetailsSection(),

              SizedBox(height: 10.h),
              RelatedVideosSection(),

              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
