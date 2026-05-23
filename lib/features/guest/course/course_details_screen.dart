import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena/core/app_theme.dart';
import 'package:sakeena/features/guest/course/assignment_dialog.dart';
import 'package:sakeena/features/guest/course/quiz_result_dialog.dart';
import 'package:sakeena/features/guest/course/review_card.dart';
import 'package:sakeena/features/guest/course/review_dialog.dart';
import 'package:sakeena/features/guest/course/show_quiz_dialog_box.dart';
import 'package:sakeena/model/course_details_model.dart';
import 'package:sakeena/model/course_model.dart';
import 'package:sakeena/model/course_module_model.dart';
import 'package:sakeena/model/course_review_model.dart';
import 'package:sakeena/model/instructior_data_model.dart';
import 'package:sakeena/model/quiz_question_model.dart';
import 'package:sakeena/route/go_route.dart';
import 'package:sakeena/widgets/custom_app_bar.dart';
import 'package:sakeena/widgets/custom_button.dart';
import 'package:sakeena/widgets/custom_text_field.dart';

extension CourseStatusExt on CourseStatus {
  String get label {
    switch (this) {
      case CourseStatus.upcoming:
        return 'Upcoming';
      case CourseStatus.live:
        return 'Live';
      case CourseStatus.recorded:
        return 'Recorded';
    }
  }

  Color get badgeColor {
    switch (this) {
      case CourseStatus.upcoming:
        return AppTheme.successColor;
      case CourseStatus.live:
        return Colors.red;
      case CourseStatus.recorded:
        return Colors.blue;
    }
  }
}

extension EnrollmentStatusExt on EnrollmentStatus {
  String get buttonLabel {
    switch (this) {
      case EnrollmentStatus.notEnrolled:
        return 'Register';
      case EnrollmentStatus.enrolled:
        return 'Enrolled';
      case EnrollmentStatus.completed:
        return 'Completed';
    }
  }

  bool get isOutlined {
    return this != EnrollmentStatus.notEnrolled;
  }

  bool get isGradient {
    return this == EnrollmentStatus.notEnrolled;
  }

  Color get textColor {
    switch (this) {
      case EnrollmentStatus.notEnrolled:
        return Colors.white;
      case EnrollmentStatus.enrolled:
        return Colors.black;
      case EnrollmentStatus.completed:
        return Colors.black;
    }
  }
}

class CourseLessonItem {
  final String title;
  final String duration;

  const CourseLessonItem({required this.title, required this.duration});
}

class TeacherCourseDetails extends StatefulWidget {
  final CourseData courseData;

  const TeacherCourseDetails({super.key, CourseData? courseData})
    : courseData =
          courseData ??
          const CourseData(
            reviews: [],
            title: '',
            imageAsset: '',
            price: '',
            courseStatus: CourseStatus.upcoming,
            enrollmentStatus: EnrollmentStatus.notEnrolled,
            description: '',
            outcomes: [],
            modules: [],
            courseDetails: CourseDetails(
              level: '',
              duration: '',
              lessons: 0,
              modules: 0,
            ),
            instructor: InstructorData(
              name: '',
              title: '',
              bio: '',
              studentCount: 0,
              courseCount: 0,
            ),
            requirements: [],
          );

  @override
  State<TeacherCourseDetails> createState() => _TeacherCourseDetailsState();
}

class _TeacherCourseDetailsState extends State<TeacherCourseDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<bool> _expandedModules;
  late CourseData _courseData;

  @override
  void initState() {
    super.initState();
    _courseData = widget.courseData.title.isEmpty
        ? CourseData.mock()
        : widget.courseData;
    _tabController = TabController(length: 5, vsync: this);
    _expandedModules = List<bool>.filled(_courseData.modules.length, false);
    if (_courseData.modules.isNotEmpty) _expandedModules[0] = true;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildOverview(),
                  _buildCurriculum(),
                  _buildReviews(),
                  _buildCertificate(),
                  _buildScholarship(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() => Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: context.pop,
            icon: const Icon(Icons.arrow_back, color: AppTheme.primaryColor),
            padding: EdgeInsets.symmetric(horizontal: 8.w),
          ),
          Text(
            "Back to Courses",
            style: TextStyle(color: AppTheme.primaryColor, fontSize: 12.sp),
          ),
        ],
      ),
      Material(
        color: Colors.white,
        child: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: AppTheme.primaryColor,
          labelColor: AppTheme.primaryColor,
          unselectedLabelColor: Colors.grey.shade600,
          labelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
          unselectedLabelStyle: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
          ),
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Curriculum'),
            Tab(text: 'Reviews'),
            Tab(text: 'Certificate'),
            Tab(text: 'Scholarship'),
          ],
        ),
      ),
    ],
  );

  Widget _buildOverview() => SingleChildScrollView(
    padding: EdgeInsets.all(16.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImageWithOverlay(),
        SizedBox(height: 16.h),
        _buildTitlePriceBadge(),
        SizedBox(height: 12.h),
        _buildShareButtons(),
        SizedBox(height: 16.h),
        _buildDivider(),
        SizedBox(height: 16.h),
        _buildDescriptionAndOutcomes(),
        SizedBox(height: 16.h),
        _buildDivider(),
        SizedBox(height: 16.h),
        _buildCourseDetailsCard(),
        SizedBox(height: 16.h),
        _buildDivider(),
        SizedBox(height: 16.h),
        _buildInstructorCard(),
        SizedBox(height: 16.h),
        _buildDivider(),
        SizedBox(height: 16.h),
        _buildRequirementsCard(),
        SizedBox(height: 16.h),
        _buildDivider(),
        SizedBox(height: 16.h),
        _buildCommunityChat(),
        SizedBox(height: 24.h),
      ],
    ),
  );

  Widget _buildImageWithOverlay() => Stack(
    alignment: Alignment.center,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Image.asset(
          _courseData.imageAsset,
          height: 200.h,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
      Icon(
        Icons.play_circle_filled,
        size: 56.sp,
        color: Colors.white.withOpacity(0.9),
      ),
    ],
  );

  Widget _buildTitlePriceBadge() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: _courseData.courseStatus.badgeColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          _courseData.courseStatus.label,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      SizedBox(height: 12.h),
      Text(
        _courseData.title,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 16.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _courseData.price,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppTheme.primaryColor,
            ),
          ),
          CustomButton(
            text: _courseData.enrollmentStatus.buttonLabel,
            onPressed: () {
              if (_courseData.enrollmentStatus ==
                  EnrollmentStatus.notEnrolled) {
                context.push(AppRoutes.LiveCourseRegistrationScreen);
                //   SnackBar(
                //     content: Text('Registering for ${_courseData.title}'),
                //   ),
                // );
              }
            },
            height: 32.h,
            width: 110.w,
            isGradient: _courseData.enrollmentStatus.isGradient,
            isOutlined: _courseData.enrollmentStatus.isOutlined,
            textColor: _courseData.enrollmentStatus.textColor,
          ),
        ],
      ),
    ],
  );

  Widget _buildShareButtons() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Share this course',
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade700,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildShareIcon(FontAwesomeIcons.whatsapp, Colors.green),
          SizedBox(width: 8.w),
          _buildShareIcon(
            FontAwesomeIcons.squareLinkedin,
            Colors.lightBlue[900],
          ),
          SizedBox(width: 8.w),
          _buildShareIcon(
            FontAwesomeIcons.facebook,
            const Color.fromARGB(255, 2, 133, 194),
          ),
          SizedBox(width: 8.w),
          _buildShareIcon(FontAwesomeIcons.xTwitter, Colors.black),
        ],
      ),
    ],
  );

  Widget _buildShareIcon(IconData icon, color) => Container(
    padding: EdgeInsets.all(6.w),
    // decoration: BoxDecoration(
    //   color: Colors.grey.shade100,
    //   shape: BoxShape.circle,
    // ),
    child: Icon(icon, size: 20.sp, color: color),
  );

  Widget _buildDescriptionAndOutcomes() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        _courseData.description,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: Colors.grey.shade700,
          height: 1.6,
        ),
      ),
      SizedBox(height: 24.h),
      Text(
        'What You\'ll Learn',
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 12.h),
      ..._courseData.outcomes
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
          .toList(),
    ],
  );

  Widget _buildCourseDetailsCard() => Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Course Details',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 8.h),
        _buildDivider(),
        _buildDetailRow('Level', _courseData.courseDetails.level),
        _buildDivider(),
        _buildDetailRow('Duration', _courseData.courseDetails.duration),
        _buildDivider(),
        _buildDetailRow(
          'Lessons',
          _courseData.courseDetails.lessons.toString(),
        ),
        _buildDivider(),
        _buildDetailRow('Module', _courseData.courseDetails.modules.toString()),
      ],
    ),
  );

  Widget _buildDetailRow(String label, String value) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: Colors.grey.shade600,
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        child: Text(
          value,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    ],
  );

  Widget _buildInstructorCard() => Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Instructor',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 16.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 24.r, backgroundColor: Colors.grey.shade300),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _courseData.instructor.name,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _courseData.instructor.title,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          _courseData.instructor.bio,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade700,
            height: 1.5,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Icon(Icons.people, size: 16.sp, color: Colors.grey.shade600),
            SizedBox(width: 8.w),
            Text(
              '${_courseData.instructor.studentCount} students',
              style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade600),
            ),
            SizedBox(width: 16.w),
            Icon(
              Icons.video_camera_back,
              size: 16.sp,
              color: Colors.grey.shade600,
            ),
            SizedBox(width: 8.w),
            Text(
              '${_courseData.instructor.courseCount} courses',
              style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade600),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _buildRequirementsCard() => Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Requirements',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 12.h),
        ..._courseData.requirements
            .map(
              (requirement) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 16.sp,
                      color: Colors.grey.shade600,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        requirement,
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
      ],
    ),
  );

  Widget _buildCommunityChat() => Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: AppTheme.primaryColor.withOpacity(0.08),
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: AppTheme.primaryColor.withOpacity(0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.forum, size: 20.sp, color: AppTheme.primaryColor),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Community Chat',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        '24 online',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          'Connect with others on the same healing journey',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock, size: 16.sp, color: Colors.grey.shade600),
                SizedBox(width: 8.w),
                Text(
                  'Available after purchase',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildDivider() => Divider(color: Colors.grey.shade200, height: 1.h);

  Widget _buildCurriculum() => SingleChildScrollView(
    padding: EdgeInsets.all(16.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Course Curriculum',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 8.h),
        Text(
          '${_courseData.modules.fold(0, (sum, m) => sum + m.lessons.length)} lessons • 3 weeks',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 16.h),
        ..._courseData.modules
            .asMap()
            .entries
            .map((e) => _buildModuleCard(e.key, e.value))
            .toList(),
      ],
    ),
  );

  Widget _buildModuleCard(int index, CourseModule module) => Card(
    margin: EdgeInsets.only(bottom: 12.h),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.r),
      side: BorderSide(color: Colors.grey.shade200),
    ),
    child: ExpansionTile(
      initiallyExpanded: _expandedModules[index],
      onExpansionChanged: (expanded) =>
          setState(() => _expandedModules[index] = expanded),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            module.title.replaceAll('Module ', 'Module '),
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4.h),
          Text(
            module.duration,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
      children: [
        // Lessons
        ...module.lessons.map(
          (lesson) => Padding(
            padding: EdgeInsets.fromLTRB(24.w, 10.h, 16.w, 10.h),
            child: Row(
              children: [
                Icon(
                  Icons.circle_outlined,
                  size: 16.sp,
                  color: Colors.grey.shade500,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    lesson.title,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
                Text(
                  lesson.duration,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),

        // ── QUIZ SECTION ──
        if (module.quiz != null && module.quiz!.isNotEmpty)
          buildSubSectionTile(
            title: 'Quiz',
            icon: Icons.quiz_outlined,
            iconColor: Colors.grey,
            hasContent: true,
            onTap: () => showQuizDialog(context, module.title, module.quiz!),
          ),

        // ── ASSIGNMENT SECTION ──
        if (module.assignmentDescription != null &&
            module.assignmentDescription!.isNotEmpty)
          buildSubSectionTile(
            title: 'Assignment',
            icon: Icons.description_outlined,
            iconColor: Colors.grey,
            hasContent: true,
            onTap: () => showAssignmentDialog(
              context,
              module.title,
              module.assignmentDescription!,
            ),
          ),
      ],
    ),
  );

  Widget _buildReviews() => SingleChildScrollView(
    padding: EdgeInsets.all(16.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '4.7',
                    style: TextStyle(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(Icons.star, color: Colors.amber, size: 28.sp),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                '(245 reviews)',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),

        SizedBox(height: 24.h),
        ..._courseData.reviews.map((review) => buildReviewCard(review)),

        SizedBox(height: 32.h),
        Center(
          child: CustomButton(
            text: 'Write Review',
            onPressed: () => showWriteReviewDialog(context),
            height: 52.h,
            width: 220.w,
            isGradient: true,
            textColor: Colors.white,
          ),
        ),

        SizedBox(height: 40.h),
      ],
    ),
  );

  Widget _buildCertificate() => SingleChildScrollView(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 32.h),
    child: Column(
      children: [
        SizedBox(height: 40.h),

        Container(
          width: double.infinity,
          constraints: BoxConstraints(maxWidth: 500.w),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  SvgPicture.asset(
                    'assets/images/certificate_part.svg',
                    fit: BoxFit.cover,
                  ),
                  // Positioned button...
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 24.h),

        Positioned(
          bottom: 20.h,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomButton(
              text: 'Download Certificate',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Certificate download started...'),
                  ),
                );
              },
              height: 52.h,
              width: double.infinity,
              isGradient: true,
              textColor: Colors.white,
            ),
          ),
        ),

        SizedBox(height: 24.h),

        Text(
          "Download in PDF format and share with others",
          style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
        ),
        SizedBox(height: 40.h),
      ],
    ),
  );

  Widget _buildScholarship() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final addressController = TextEditingController();
    String? selectedLevel = 'High School';

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.h),
          Text(
            "APPLY NOW FOR OUR EDUCATION SUPPORT SCHOLARSHIP.",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2C7A7B),
            ),
          ),
          SizedBox(height: 28.h),

          CustomTextField(
            controller: nameController,
            labelText: "Name*",
            hintText: "Full Name",
          ),
          SizedBox(height: 16.h),

          CustomTextField(
            controller: emailController,
            labelText: "Email*",
            hintText: "Email",
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 16.h),

          CustomTextField(
            controller: phoneController,
            labelText: "Phone Number",
            hintText: "Phone Number",
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 16.h),

          CustomTextField(
            controller: addressController,
            labelText: "Address",
            hintText: "City/Country",
          ),
          SizedBox(height: 24.h),

          Text(
            "Current Level of Study",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: DropdownButton<String>(
              value: selectedLevel,
              isExpanded: true,
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(
                  value: "High School",
                  child: Text("High School"),
                ),
                DropdownMenuItem(
                  value: "Undergraduate",
                  child: Text("Undergraduate"),
                ),
                DropdownMenuItem(
                  value: "Postgraduate",
                  child: Text("Postgraduate"),
                ),
                DropdownMenuItem(value: "Other", child: Text("Other")),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedLevel = value);
                }
              },
            ),
          ),

          SizedBox(height: 24.h),

          CustomTextField(
            labelText: "Field of Study / Major",
            hintText: "Provide Qualifications and Interests in Detail",
            // maxLength:3, // Note: your CustomTextField supports maxLines via TextFormField
          ),

          SizedBox(height: 24.h),

          Text(
            "Why are you applying for this scholarship?",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            hintText:
                "Write a brief explanation of your need and motivation...",
            // maxLength: 4,
          ),

          SizedBox(height: 24.h),

          Text(
            "How will this scholarship help you achieve your goals?",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            hintText: "Explain your career goals and how this support helps...",
            // maxLength: 4,
          ),

          SizedBox(height: 24.h),

          Text(
            "Upload Personal Statement or Motivation Letter",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: () {
              // TODO: file picker logic
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.attach_file, color: const Color(0xFF2C7A7B)),
                  SizedBox(width: 12.w),
                  Text(
                    "Choose File",
                    style: TextStyle(
                      color: const Color(0xFF2C7A7B),
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 16.h),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(value: false, onChanged: (v) {}),
              Expanded(
                child: Text(
                  "I agree to be contacted for further discussion and opportunities.",
                  style: TextStyle(fontSize: 13.sp, height: 1.4),
                ),
              ),
            ],
          ),

          SizedBox(height: 40.h),

          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Cancel',
                  onPressed: () {},
                  isOutlined: true,
                  height: 52.h,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: CustomButton(
                  text: 'Send Application',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Application submitted (demo mode)'),
                      ),
                    );
                  },
                  isGradient: true,
                  height: 52.h,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),

          SizedBox(height: 60.h),
        ],
      ),
    );
  }
}
