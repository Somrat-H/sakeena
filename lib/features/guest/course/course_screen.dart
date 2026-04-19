import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena/core/app_theme.dart';
import 'package:sakeena/features/guest/course/course_details_screen.dart';
import 'package:sakeena/model/course_details_model.dart';
import 'package:sakeena/model/course_model.dart';
import 'package:sakeena/model/course_module_model.dart';
import 'package:sakeena/model/instructior_data_model.dart';
import 'package:sakeena/widgets/course_card.dart';
import 'package:sakeena/widgets/custom_app_bar.dart';
import 'package:sakeena/widgets/filter_section.dart';

// ============ SAMPLE COURSES DATA ============
class CoursesDataHelper {
  static final List<CourseData> allCourses = [
    CourseData(
      title: 'Mindfulness in Islam',
      imageAsset: 'assets/images/quran_recite_image.png',
      price: '\$99',
      courseStatus: CourseStatus.live,
      enrollmentStatus: EnrollmentStatus.notEnrolled,
      description:
          'This comprehensive healing program integrates Islamic spiritual practices with modern-based psychological approaches. Through 5 carefully designed modules over 6 weeks (40 Days), you will learn tools and insights to overcome stress, build emotional resilience, and cultivate lasting behavior change.',
      outcomes: const [
        'Understanding anxiety from both Islamic and psychological perspectives',
        'Integrate dhikr and mindfulness techniques for anxiety relief',
        'Apply cognitive behavioral strategies noted in Islamic teachings',
        'Build lasting emotional resilience through faith practices',
        'Recognizing triggers and developing coping mechanisms',
      ],
      modules: const [
        CourseModule(
          title: 'Module 1: Understanding Anxiety',
          duration: '4 lessons • 52 min',
          lessons: [
            CourseLessonItem(
              title: 'Introduction to the Course',
              duration: '0:00',
            ),
            CourseLessonItem(title: 'What is Anxiety?', duration: '12:43'),
            CourseLessonItem(
              title: 'Islamic Perspective on Anxiety',
              duration: '15:00',
            ),
            CourseLessonItem(
              title: 'Types of Anxiety Disorders',
              duration: '11:32',
            ),
          ],
        ),
        CourseModule(
          title: 'Module 2: Dhikr & Mindfulness',
          duration: '4 lessons • 48 min',
          lessons: [
            CourseLessonItem(title: 'Introduction to Dhikr', duration: '10:15'),
            CourseLessonItem(title: 'Mindfulness Practices', duration: '12:30'),
            CourseLessonItem(
              title: 'Combining Dhikr and Mindfulness',
              duration: '25:15',
            ),
          ],
        ),
        CourseModule(
          title: 'Module 3: Cognitive Approaches',
          duration: '4 lessons • 56 min',
          lessons: [
            CourseLessonItem(
              title: 'Cognitive Behavioral Therapy Basics',
              duration: '18:00',
            ),
            CourseLessonItem(
              title: 'Identifying Negative Thoughts',
              duration: '15:30',
            ),
          ],
        ),
      ],
      courseDetails: const CourseDetails(
        level: 'Beginner',
        duration: '12 weeks',
        lessons: 24,
        modules: 5,
      ),
      instructor: const InstructorData(
        name: 'Sheikh Omar Ibrahim',
        title: 'Islamic Scholar & Wellness Expert',
        bio:
            'Content will always be kept fresh! Our team will be helping guide the course forward.',
        studentCount: 2450,
        courseCount: 8,
      ),
      requirements: const [
        'Open mind and willingness to learn',
        'Basic understanding of Islam',
        'Notebook for exercises',
        'Commitment to daily practice',
      ],
    ),
    CourseData(
      title: 'Islamic Psychology Basics',
      imageAsset: 'assets/images/quran_image.png',
      price: '\$79',
      courseStatus: CourseStatus.upcoming,
      enrollmentStatus: EnrollmentStatus.notEnrolled,
      description:
          'Learn the fundamentals of Islamic psychology and how Islamic principles can be applied to modern psychological challenges.',
      outcomes: const [
        'Understand core concepts of Islamic psychology',
        'Learn how to apply Islamic principles to mental health',
        'Develop emotional intelligence through Islamic lens',
        'Master techniques for anxiety and stress management',
      ],
      modules: const [
        CourseModule(
          title: 'Module 1: Introduction to Islamic Psychology',
          duration: '3 lessons • 45 min',
          lessons: [
            CourseLessonItem(title: 'Welcome & Overview', duration: '8:00'),
            CourseLessonItem(title: 'Historical Context', duration: '12:30'),
            CourseLessonItem(title: 'Core Principles', duration: '15:00'),
          ],
        ),
        CourseModule(
          title: 'Module 2: Mental Health in Islam',
          duration: '4 lessons • 60 min',
          lessons: [
            CourseLessonItem(
              title: 'Islamic Perspective on Mental Health',
              duration: '15:00',
            ),
            CourseLessonItem(title: 'Quranic Guidance', duration: '18:00'),
          ],
        ),
      ],
      courseDetails: const CourseDetails(
        level: 'Beginner',
        duration: '8 weeks',
        lessons: 16,
        modules: 4,
      ),
      instructor: const InstructorData(
        name: 'Dr. Aisha Khan',
        title: 'Clinical Psychologist & Islamic Counselor',
        bio: 'Expert in bridging Islamic teachings with modern psychology.',
        studentCount: 1850,
        courseCount: 5,
      ),
      requirements: const [
        'No prerequisites required',
        'Basic understanding of Islam helpful',
        'Commitment to weekly lessons',
      ],
    ),
    CourseData(
      title: 'Quran & Mental Wellness',
      imageAsset: 'assets/images/quran_recite_image.png',
      price: '\$89',
      courseStatus: CourseStatus.live,
      enrollmentStatus: EnrollmentStatus.notEnrolled,
      description:
          'Discover how Quranic teachings provide guidance for mental and emotional wellness in the modern world.',
      outcomes: const [
        'Learn key Quranic verses for mental wellness',
        'Understand spiritual healing practices',
        'Develop resilience through Quranic wisdom',
        'Practice mindfulness rooted in Islamic tradition',
      ],
      modules: const [
        CourseModule(
          title: 'Module 1: Quranic Wisdom for Well-being',
          duration: '5 lessons • 70 min',
          lessons: [
            CourseLessonItem(
              title: 'Introduction to Quranic Healing',
              duration: '10:00',
            ),
            CourseLessonItem(
              title: 'Key Verses for Wellness',
              duration: '18:00',
            ),
          ],
        ),
      ],
      courseDetails: const CourseDetails(
        level: 'Intermediate',
        duration: '10 weeks',
        lessons: 20,
        modules: 4,
      ),
      instructor: const InstructorData(
        name: 'Prof. Ahmed Hassan',
        title: 'Quran Scholar & Wellness Coach',
        bio:
            'Passionate about connecting spiritual wisdom with modern wellness practices.',
        studentCount: 3200,
        courseCount: 12,
      ),
      requirements: const [
        'Basic Arabic knowledge preferred',
        'Familiarity with Quran',
        'Interest in wellness practices',
      ],
    ),
  ];

  static List<CourseData> getCourses() => allCourses;

  static List<CourseData> getFilteredCourses({
    required String category,
    required String courseType,
  }) {
    List<CourseData> filtered = allCourses;

    if (category != 'All') {}

    // Filter by course type
    if (courseType != 'All') {
      filtered = filtered.where((course) {
        if (courseType == 'Live') {
          return course.courseStatus == CourseStatus.live;
        }
        if (courseType == 'Recorded') {
          return course.courseStatus == CourseStatus.recorded;
        }
        if (courseType == 'Upcoming') {
          return course.courseStatus == CourseStatus.upcoming;
        }
        return true;
      }).toList();
    }

    return filtered;
  }

  static CourseData? getCourseByTitle(String title) {
    try {
      return allCourses.firstWhere((course) => course.title == title);
    } catch (e) {
      return null;
    }
  }
}

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  String selectedCategory = 'All';
  String selectedCourseType = 'All';

  @override
  Widget build(BuildContext context) {
    const categories = ['All', 'Mental Health', 'Spiritual Growth'];
    const courseTypes = ['All', 'Live', 'Recorded', 'Upcoming'];

    final filteredCourses = CoursesDataHelper.getFilteredCourses(
      category: selectedCategory,
      courseType: selectedCourseType,
    );

    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      SizedBox(
                        width: 40.w,
                        child: Navigator.of(context).canPop()
                            ? IconButton(
                                onPressed: () {
                                  if (context.canPop()) {
                                    context.pop();
                                  }
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              )
                            : null,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0x33FFFFFF),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: Colors.white70),
                        ),
                        child: Text(
                          'Explore Our Courses',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 40.w),
                    ],
                  ),

                  SizedBox(height: 14.h),
                  Text(
                    'Learn, Grow, Heal',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Arimo",
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      'Discover courses that integrate Islamic wisdom with modern psychology',
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
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Filter
                  FilterSection(
                    title: 'Category',
                    items: categories,
                    selectedItem: selectedCategory,
                    onSelected: (v) => setState(() => selectedCategory = v),
                    isHorizontal: true,
                  ),
                  SizedBox(height: 20.h),

                  // Course Type Filter
                  FilterSection(
                    title: 'Course Type',
                    items: courseTypes,
                    selectedItem: selectedCourseType,
                    onSelected: (v) => setState(() => selectedCourseType = v),
                    isHorizontal: true,
                  ),
                  SizedBox(height: 24.h),

                  // Courses Grid
                  if (filteredCourses.isEmpty)
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 32.h),
                        child: Text(
                          'No courses found',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    )
                  else
                    Column(
                      children: List.generate(filteredCourses.length, (index) {
                        final course = filteredCourses[index];
                        return Column(
                          children: [
                            _CenteredCourseCard(
                              onTap: () {
                                // Navigate to course detail screen
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //         CourseDetailScreen(courseData: course),
                                //   ),
                                // );
                              },
                              child: CourseCard(course: CourseData.mock()),
                            ),
                            if (index < filteredCourses.length - 1)
                              SizedBox(height: 16.h)
                            else
                              SizedBox(height: 24.h),
                          ],
                        );
                      }),
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

// ============ CENTERED COURSE CARD WITH TAP ============
class _CenteredCourseCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const _CenteredCourseCard({required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 0.95.sw,
        height: 332.h,
        child: GestureDetector(onTap: onTap, child: child),
      ),
    );
  }
}
