import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/core/app_theme.dart';
import 'package:sakeena/features/teachers/course_detail/controller/teacher_course_details_controller.dart';
import 'package:sakeena/features/teachers/course_detail/model/course_details_response.dart';
import 'package:sakeena/features/teachers/course_detail/repository/teacher_course_details_repository.dart';
import 'package:sakeena/features/teachers/course_detail/view/payment.dart';
import 'package:shimmer/shimmer.dart';

class TeacherCourseDetails extends StatelessWidget {
  final int courseId;

  const TeacherCourseDetails({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Course Details"),
          elevation: 0,
        ),
        body: FutureBuilder<CouseDeatilsResponse?>(
          future: TeacherCourseDetailsRepository().getCourseDetails(courseId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const _LoadingShimmer();
            } else if (snapshot.hasError || snapshot.data == null) {
              return const Center(child: Text("Error loading course details."));
            }

            final data = snapshot.data!;
            return _buildMainContent(context, data);
          },
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, CouseDeatilsResponse course) {
  // Matching your custom UI teal color scheme
  const Color tealColor = Color(0xFF2C7A7B);

  return Column(
    children: [
      Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Title & Banner ---
              Text(
                course.title ?? "",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  course.thumbnail ?? "",
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(color: Colors.grey[200], height: 200),
                ),
              ),
              const SizedBox(height: 20),

              // --- Instructor ---
              const Text("Instructor", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildTeacherTile(course.teacher),
              const SizedBox(height: 16),

              // --- Conditional Button Layout System ---
            if (course.isEnrolled ?? false) ...[
  // Displayed if the user is already enrolled
  Row(
    children: [
      Expanded(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade200,
            foregroundColor: Colors.grey.shade600,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            elevation: 0,
          ),
          onPressed: null, // Null disables the button visually and functionally
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline, size: 18),
              SizedBox(width: 6),
              Text(
                "Enrolled",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
] else ...[
  // Fallback action options displayed if not enrolled
  Row(
    children: [
      Expanded(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: tealColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            elevation: 0,
          ),
          onPressed: () async{
            // Handle enrollment action sequence
            final url = await context.read<TeacherCourseDetailsController>().getDriectEnroll({
  "item_type": "course",
  "object_id": course.id,
  "coupon_code": ""
});
if (url.isNotEmpty && context.mounted) {
                  // Navigate to your custom webview screen component
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentWebViewScreen(checkoutUrl: url),
                    ),
                  );
                }

          },
          child: const Text(
            "Enroll Now",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: tealColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            elevation: 0,
          ),
          onPressed: () {
            // Handle add to e-commerce cart pipeline
          },
          child: const Text(
            "Add to Cart",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    ],
  ),
],

              const Divider(height: 40),

              // --- Stats ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _infoTile(Icons.menu_book, "${course.totalLessons}", "Lessons"),
                  _infoTile(Icons.timer, course.totalHours ?? "0", "Hours"),
                  _infoTile(Icons.bar_chart, course.level ?? "All", "Level"),
                ],
              ),
              
              const SizedBox(height: 20),

              // --- Tab Bar ---
              const TabBar(
                isScrollable: true,
                labelColor: Color(0xFF00796B),
                unselectedLabelColor: Colors.grey,
                indicatorColor: Color(0xFF00796B),
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(text: "Course Overview"),
                  Tab(text: "Course Curriculum"),
                  Tab(text: "Course Reviews"),
                  Tab(text: "Course Community"),
                ],
              ),

              const SizedBox(height: 20),
              _buildTabContent(course),
            ],
          ),
        ),
      ),
    ],
  );
}

  // Helper to switch content based on the active tab
  // Since we are in a StatelessWidget and using DefaultTabController, 
  // you can either use a TabBarView (requires fixed height) or a custom Builder.
  Widget _buildTabContent(CouseDeatilsResponse course) {
    return Builder(
      builder: (context) {
        final tabController = DefaultTabController.of(context);
        return AnimatedBuilder(
          animation: tabController,
          builder: (context, child) {
            switch (tabController.index) {
              case 0:
                return _overviewSection(course);
              case 1:
                return _curriculumLessionSection(course, context);
              case 2:
                return const Center(child: Text("Reviews List Here"));
              case 3:
                return const Center(child: Text("Community Chat Here"));
              default:
                return const SizedBox();
            }
          },
        );
      },
    );
  }

  Widget _overviewSection(CouseDeatilsResponse course) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(course.title ?? "", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
           Text(course.subtitle ?? "", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text( _parseHtmlString(course.description ?? "No description available."), style: TextStyle(color: Colors.grey.shade700)),
          
          
        ],
      ),
    );
  }

  // ... (Your existing _buildTeacherTile and _infoTile methods)
}


 
String _parseHtmlString(String htmlString) {
  final RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  return htmlString.replaceAll(exp, '');
}

Widget _curriculumLessionSection(CouseDeatilsResponse course, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Course Curriculum",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            "${course.totalLessons} lessons • ${_parseHtmlString(course.description ?? '12 weeks')}",
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),
          const SizedBox(height: 16),
          ListView.builder(
      shrinkWrap: true, 
    
    // FIX 2: This prevents the ListView from trying to scroll independently 
    // inside the SingleChildScrollView
    physics: const NeverScrollableScrollPhysics(),
      itemCount: course.modules!.length,
      itemBuilder: (context, index) {
        final module = course.modules![index];
      return 
          // Section Card
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Theme(
              // Removes the default border lines of ExpansionTile
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                initiallyExpanded: true,
                title:  Text(
                  module.title ?? "Module ${index + 1}",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
                subtitle: Text(
                  "${module.totalLessons} lessons • ${module.totalDuration} hours",
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                ),
                children: List.generate(module.lessons?.length ?? 0, (index) {  
  final data = module.lessons?[index];
  if (data == null) return const SizedBox.shrink();

  switch (data.contentType) {
    case "video":
      return _buildLessonRow(
        Icons.play_circle_outline_rounded, // Perfect for video streaming lessons
        data.title ?? "Untitled Video", 
        "${data.durationInMinutes ?? "0"} mins",
      );
      
    case "assignment":
      return _buildLessonRow(
        Icons.assignment_outlined, // Standard assignment icon
        data.title ?? "Untitled Assignment", 
        "Assignment", 
        isAssignment: true,
      );
      
    case "document":
      return _buildLessonRow(
        Icons.description_outlined, // Perfect file/PDF document icon
        data.title ?? "Untitled Document", 
        "Document", // Fixed fallback subtitle
        isAssignment: false, // Changed to false unless it grades like an assignment
      );
      
    case "quiz":
      return _buildLessonRow(
        Icons.quiz_outlined, // Perfect dedicated question/quiz icon
        data.title ?? "Untitled Quiz", 
        "Quiz Assessment", // Fixed fallback subtitle
        isAssignment: true, // Typically acts as an assessment block
      );
      
    default:
      // Catch-all fallback for any unhandled media categories
      return _buildLessonRow(
        Icons.insert_drive_file_outlined, 
        data.title ?? "Lesson Extra", 
        "Attachment",
      );
  }
})
                  
                  ),
                

              ),
            );
          
        
        ;
    })
        ],
      ),
    );
  }




  // Widget _reviewsSection(CouseDeatilsResponse course) {
  //   // Assuming course.reviews is a list in your model. 
  //   // If it's null or empty, we show the empty state from your image.
  //   final hasReviews = course.reviews != null && course.reviews!.isNotEmpty;

  //   return Container(
  //     width: double.infinity,
  //     padding: const EdgeInsets.all(24),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       border: Border.all(color: Colors.grey.shade200),
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const Text(
  //           "Student Reviews",
  //           style: TextStyle(
  //             fontSize: 20, 
  //             fontWeight: FontWeight.bold, 
  //             color: Color(0xFF263238), // Dark slate color from image
  //           ),
  //         ),
  //         const SizedBox(height: 40),
  //         if (!hasReviews)
  //           Center(
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Icon(
  //                   Icons.star_border,
  //                   size: 60,
  //                   color: Colors.grey.shade300,
  //                 ),
  //                 const SizedBox(height: 8),
  //                 Text(
  //                   "No reviews yet.",
  //                   style: TextStyle(
  //                     color: Colors.grey.shade400,
  //                     fontSize: 14,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           )
  //         else
  //           // If you have reviews, you would map them here
  //           const Text("Display reviews list here..."),
  //         const SizedBox(height: 20),
  //       ],
  //     ),
  //   );
  // }
Widget _buildLessonRow(IconData icon, String title, String trailing, {bool isAssignment = false}) {
  // Matching your dashboard design language
  final Color activeTeal = const Color(0xFF2C7A7B);
  final Color accentOrange = const Color(0xFFE67E22);

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isAssignment ? accentOrange.withOpacity(0.15) : Colors.grey.shade100,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Dynamic Leading Icon
          Icon(
            icon, 
            size: 18, 
            color: isAssignment ? accentOrange : activeTeal,
          ),
          const SizedBox(width: 12),
          
          // 2. Expandable Title Context
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontFamily: 'Arimo',
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // 3. Status Badge / Trailing Component
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isAssignment ? 10 : 0, 
              vertical: isAssignment ? 4 : 0,
            ),
            decoration: isAssignment 
                ? BoxDecoration(
                    color: accentOrange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  )
                : null,
            child: Text(
              trailing,
              style: TextStyle(
                fontSize: 12, 
                color: isAssignment ? accentOrange : Colors.grey.shade500,
                fontWeight: isAssignment ? FontWeight.w600 : FontWeight.w400,
                fontFamily: 'Arimo',
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
  Widget _buildTeacherTile(Teacher? teacher) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(teacher?.profilePicture ?? ""),
      ),
      title: Text("${teacher?.user?.firstName} ${teacher?.user?.lastName}"),
      subtitle: Text(teacher?.professionalTitle ?? "Expert Instructor"),
    );
  }

  Widget _infoTile(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.accentColor),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }


// --- Shimmer Loading Widget ---
class _LoadingShimmer extends StatelessWidget {
  const _LoadingShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: 200, height: 24, color: Colors.white),
            const SizedBox(height: 16),
            Container(width: double.infinity, height: 200, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12))),
            const SizedBox(height: 24),
            Container(width: 120, height: 20, color: Colors.white),
            const SizedBox(height: 12),
            ListTile(
              leading: const CircleAvatar(backgroundColor: Colors.white),
              title: Container(width: 100, height: 15, color: Colors.white),
              subtitle: Container(width: 150, height: 12, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}