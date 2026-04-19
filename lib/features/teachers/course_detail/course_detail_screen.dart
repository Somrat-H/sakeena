import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena/widgets/custom_button.dart';
import '../../../core/app_theme.dart';
import '../_old_course_detail/course_detail.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena/core/app_theme.dart';
class CourseDetailDialog extends StatelessWidget {
  final CourseDetailModelOld course;

  const CourseDetailDialog({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Course Details',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close, size: 24.sp),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                'Complete information about the course',
                style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade600),
              ),
              SizedBox(height: 16.h),

              // Add Student Button
              // ElevatedButton.icon(
              //   onPressed: () {
              //     // TODO: implement add student functionality
              //   },
              //   icon: const Icon(Icons.add),
              //   label: const Text('Add Student'),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: AppTheme.primaryColor,
              //     padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(8.r),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 16.h),

              // Course Details Form (Read Only)
              _buildReadOnlyField('Course Title', course.courseTitle),
              _buildReadOnlyField('Instructor', course.instructor),
              _buildReadOnlyField('Category', course.category),
              _buildReadOnlyField('Status', course.status, statusBadge: true),
              _buildReadOnlyField('Price', '\$${course.price}'),
              _buildReadOnlyField('Duration', course.duration),
              _buildReadOnlyField(
                'Total Lessons',
                '${course.totalLessons} Lessons',
              ),
              _buildReadOnlyField('Rating', '⭐ ${course.rating}/5.0'),
              SizedBox(height: 16.h),

              // Total Enrolled
              Text(
                'Total Enrolled',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '${course.totalEnrolled} students',
                style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade700),
              ),
              SizedBox(height: 16.h),

              // Students Table
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Student Name')),
                    DataColumn(label: Text('Email')),
                  ],
                  rows: course.students.map((student) {
                    return DataRow(
                      cells: [
                        DataCell(Text(student['name'] ?? '')),
                        DataCell(Text(student['email'] ?? '')),
                      ],
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: 24.h),
              // Close Button
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 12.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(
    String label,
    String value, {
    bool statusBadge = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: statusBadge
                ? Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: value.toLowerCase() == 'live'
                          ? Colors.red.shade200
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.red.shade800,
                      ),
                    ),
                  )
                : Text(
                    value,
                    style: TextStyle(fontSize: 13.sp, color: Colors.black),
                  ),
          ),
        ],
      ),
    );
  }
}




class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({super.key});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<bool> _expandedModules = [true, false, false, false, false];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Back to Courses',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppTheme.primaryColor,
              labelColor: AppTheme.primaryColor,
              unselectedLabelColor: Colors.grey.shade600,
              labelStyle: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
              ),
              tabs: const [
                Tab(text: 'Overview'),
                Tab(text: 'Curriculum'),
                Tab(text: 'Reviews'),
              ],
            ),
          ),
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Overview Tab
                _buildOverviewTab(),
                // Curriculum Tab
                _buildCurriculumTab(),
                // Reviews Tab
                _buildReviewsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course Image with Play Button
          Stack(
            children: [
              Image.network(
                'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=500&h=300&fit=crop',
                height: 250.h,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 250.h,
                    color: Colors.grey.shade300,
                  );
                },
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 28.sp,
                  ),
                ),
              ),
            ],
          ),
          // Course Title and Description
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  '40 Days Towards Change \'Faith-centered emotional healing journey\'',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 12.h),
                // Description
                Text(
                  'This comprehensive healing program integrates Islamic spiritual practices with modern-based psychological approaches. Through 5 carefully designed modules over 6 weeks (40 Days), you will learn tools and insights to overcome stress, build emotional resilience, and cultivate lasting behavior change.\n\nThe course combines video lessons, guided exercises, daily routines, and community support to give you lasting healing healing and practical skills practices noted in Islamic teachings. Each session is 2 hours, designed to give you deep understanding and practical application.',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade700,
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 24.h),
                // What You'll Learn
                Text(
                  'What You\'ll Learn',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 12.h),
                ..._buildLearningOutcomes(),
                SizedBox(height: 24.h),
                // Course Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=500&h=300&fit=crop',
                    height: 200.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200.h,
                        color: Colors.grey.shade300,
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.h),
                // Status Badge and Price
                Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: AppTheme.successColor,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Text(
                        'Upcoming',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                // Title
                Text(
                  'Mindfulness in Islam',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 12.h),
                // Price and Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$99',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                      ),
                      child: Text(
                        'Enrolled',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
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
    );
  }

  Widget _buildCurriculumTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Curriculum Header
            Text(
              'Course Curriculum',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '22 lessons • 3 weeks',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 16.h),
            // Modules
            ..._buildCurriculumModules(),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsTab() {
    return Center(
      child: Text(
        'No reviews yet',
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }

  List<Widget> _buildLearningOutcomes() {
    final outcomes = [
      'Understanding anxiety from both Islamic and psychological perspectives',
      'Integrate dhikr and mindfulness techniques for anxiety relief',
      'Apply cognitive behavioral strategies noted in Islamic teachings',
      'Build lasting emotional resilience through faith practices',
      'Recognizing triggers and developing coping mechanisms',
    ];

    return outcomes
        .map(
          (outcome) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.radio_button_unchecked,
                  size: 16.sp,
                  color: Colors.grey.shade600,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    outcome,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  List<Widget> _buildCurriculumModules() {
    final modules = [
      {
        'title': 'Module 1: Understanding Anxiety',
        'duration': '4 lessons • 52 min',
        'lessons': [
          'Introduction to the Course',
          'What is Anxiety?',
          'Islamic Perspective on Anxiety',
          'Types of Anxiety Disorders',
        ],
      },
      {
        'title': 'Module 2: Dhikr & Mindfulness',
        'duration': '4 lessons • 48 min',
        'lessons': [
          'Introduction to Dhikr',
          'Mindfulness Practices',
          'Combining Dhikr and Mindfulness',
        ],
      },
      {
        'title': 'Module 3: Cognitive Approaches',
        'duration': '4 lessons • 56 min',
        'lessons': [
          'Cognitive Behavioral Therapy Basics',
          'Identifying Negative Thoughts',
        ],
      },
      {
        'title': 'Module 4: Tawakkul & Trust',
        'duration': '5 lessons • 62 min',
        'lessons': [
          'Understanding Tawakkul',
          'Building Trust in Allah',
        ],
      },
      {
        'title': 'Module 5: Building Resilience',
        'duration': '3 lessons • 54 min',
        'lessons': [
          'Creating Resilience Plans',
          'Long-term Strategies',
        ],
      },
    ];

    return List.generate(
      modules.length,
      (index) => _buildModuleCard(
        index,
        modules[index]['title'] as String,
        modules[index]['duration'] as String,
        modules[index]['lessons'] as List<String>,
      ),
    );
  }

  Widget _buildModuleCard(
    int index,
    String title,
    String duration,
    List<String> lessons,
  ) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ExpansionTile(
        initiallyExpanded: _expandedModules[index],
        onExpansionChanged: (expanded) {
          setState(() {
            _expandedModules[index] = expanded;
          });
        },
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              duration,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        children: lessons
            .map(
              (lesson) => Padding(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
                child: Row(
                  children: [
                    Icon(
                      Icons.radio_button_unchecked,
                      size: 16.sp,
                      color: Colors.grey.shade400,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        lesson,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}