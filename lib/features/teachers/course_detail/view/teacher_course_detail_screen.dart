import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/core/app_theme.dart';
import 'package:sakeena/core/storage/token_manager.dart';
import 'package:sakeena/features/guest_portion/home/model/course_review_model.dart';
import 'package:sakeena/features/guest_portion/home/provider/home_guest_provider.dart';
import 'package:sakeena/features/teachers/course_detail/controller/teacher_course_details_controller.dart';
import 'package:sakeena/features/teachers/course_detail/model/course_details_response.dart';
import 'package:sakeena/features/teachers/course_detail/repository/teacher_course_details_repository.dart';
import 'package:sakeena/features/teachers/course_detail/view/payment.dart';
import 'package:sakeena/features/teachers/course_detail/view/widget/write_review_dialog.dart';
import 'package:sakeena/features/teachers/earnings/earnings_screen.dart';
import 'package:sakeena/route/teachers_routes.dart';
import 'package:sakeena/widgets/course_card.dart';
import 'package:sakeena/widgets/stat_box.dart';
import 'package:shimmer/shimmer.dart';

class TeacherCourseDetails extends StatelessWidget {
  final int courseId;

  const TeacherCourseDetails({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text("Course Details"), elevation: 0),
        body: FutureBuilder<CouseDeatilsResponse?>(
          // We must explicitly return the value 'courseData' at the end of the chain!
          future: TeacherCourseDetailsRepository().getCourseDetails(courseId).then((courseData) {
            // Trigger the provider review call in the background frame lifecycle
            if (courseData.id != null) {
              if(context.mounted){
                 context.read<HomeGuestProvider>().getCourseReview(courseId);
              }
             
            }
            return courseData; 
          }),
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
                _buildCourseHeader(context, course),
                const SizedBox(height: 20),

                // --- Instructor ---
                _buildTeacherTile(course.teacher),
                const SizedBox(height: 16),

                _buildCourseDetailsCard(course),

                const SizedBox(height: 20),

                // --- Tab Bar ---
                TabBar(
                  isScrollable: true,
                  labelColor: const Color(0xFF00796B),
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: const Color(0xFF00796B),
                  indicatorSize: TabBarIndicatorSize.tab,
                  physics:
                      const BouncingScrollPhysics(), // Added for clean horizontal scrolling
                  tabs: [
                    _buildRowTab(
                      text: "Course Curriculum",
                      iconAsset: "assets/icons/open-book.svg",
                    ),
                    _buildRowTab(
                      text: "Course Overview",
                      iconAsset: "assets/icons/open-book.svg",
                    ),
                    _buildRowTab(
                      text: "Reviews",
                      iconAsset: "assets/icons/open-book.svg",
                    ),
                    _buildRowTab(
                      text: "Certificate",
                      iconAsset: "assets/icons/open-book.svg",
                    ),
                    _buildRowTab(
                      text: "Scholarship",
                      iconAsset: "assets/icons/open-book.svg",
                    ),
                  ],
                ),

                const SizedBox(height: 20),
       
                    const SizedBox(height: 20),
                _buildTabContent( context.watch<HomeGuestProvider>(), course),
                    
                    // const SizedBox(height: 20),
                    //          Text("Related Courses", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                    //   child: SizedBox(
                    //     height: 535,
                    //     child: ListView.builder(
                    //       scrollDirection: Axis.horizontal,
                    //       physics: const BouncingScrollPhysics(),
                    //       itemCount: course.relatedCourses?.length ?? 0,
                    //       itemBuilder: (context, index) {
                    //         final data = course.relatedCourses![index];
                    //         return Padding(
                    //           padding: const EdgeInsets.only(
                    //             left: 16.0,
                    //             right: 4.0,
                    //           ),
                    //           child: SizedBox(
                    //             width: 350,
                    //             child: Column(
                    //               mainAxisSize: MainAxisSize.min,
                    //               children: [
                    //                 Expanded(
                    //                   child: CourseCardTeacher(
                    //                     imageUrl:
                    //                         data.thumbnail ??
                    //                         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9ClZ-sWSzj1r9lMta57sD-X_zuxkbo_1kWw&s",
                    //                     category: data.category == null
                    //                         ? 'Uncategorized'
                    //                         : data.category!.name ??
                    //                               'Uncategorized',
                    //                     title:
                    //                         data.title ?? 'Untitled Course',
                    //                     instructor:
                    //                         "${data.teacher?.user?.firstName ?? ''} ${data.teacher?.user?.lastName ?? ''}",
                    //                     lessons: data.totalLessons ?? 0,
                    //                     weeks: data.durationInWeeks ?? 0,
                    //                     totalHours:
                    //                         double.tryParse(
                    //                           data.totalHours ?? '0',
                    //                         ) ??
                    //                         0.0,
                    //                     hoursPerSession:
                    //                         double.tryParse(
                    //                           data.hoursPerSession ?? '0',
                    //                         ) ??
                    //                         0.0,
                    //                     price: course.price ?? "0.0",
                    //                     status:
                    //                         course.status ?? 'Uncategorized',
                    //                     onViewDetails: () async {
                    //                       if (course.id != null) {
                    //                         context.push(
                    //                           TeachersRoutes.courseDetail,
                    //                           extra: data.id,
                    //                         );
                    //                       }
                    //                     },
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //   ),
                    // ),
              
              
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRowTab({required String text, required String iconAsset}) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconAsset,
            height: 18.0,
            width: 18.0,
            // Colors the asset vector dynamically based on the current active tab accent color
            theme: const SvgTheme(currentColor: Colors.transparent),
          ),
          const SizedBox(
            width: 8.0,
          ), // Consistent horizontal spacing between icon and text
          Text(
            text,
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // Helper to switch content based on the active tab
  // Since we are in a StatelessWidget and using DefaultTabController,
  // you can either use a TabBarView (requires fixed height) or a custom Builder.
Widget _buildTabContent(HomeGuestProvider provider, CouseDeatilsResponse course) {
  return Builder(
    builder: (context) {
      final tabController = DefaultTabController.of(context);
      return AnimatedBuilder(
        animation: tabController,
        builder: (context, child) {
          final currentIndex = tabController.index;
          
          // 👈 Guard rail: If index drifts beyond bounds during rapid navigation changes, return fallback immediately
          if (currentIndex >= tabController.length) {
            return const SizedBox.shrink();
          }

          switch (currentIndex) {
            case 0:
              return _curriculumLessionSection(course, context);
            case 1:
              return _overviewSection(course);
            case 2:
              return _buildStudentReviewsCard(context, course, provider.courseReviewModel);
            case 3:
              return _buildCertificateLockedCard(context);
            case 4:
              return _buildScholarshipCard(context, course);
            default:
              return const SizedBox.shrink();
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
          Text(
            course.title ?? "",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            course.subtitle ?? "",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          Html(data: course.description ?? "<p>No description.</p>"),
        ],
      ),
    );
  }


Widget _buildCourseHeader(BuildContext context, CouseDeatilsResponse course) {
  const Color tealBrand = Color(0xFF2C7A7B);
  const Color textPrimary = Color(0xFF111827);
  const Color textSecondary = Color(0xFF4B5563);
  const Color badgeBlue = Color(0xFF3B82F6);

  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.black.withOpacity(0.06)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // --- 1. DYNAMIC COURSE BANNER / THUMBNAIL AREA ---
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          child: Image.network(
            course.thumbnail ?? "",
            width: double.infinity,
            height:
                220, // Clean, baseline default proportional landscape height
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 220,
              color: const Color(
                0xFFDDD6CE,
              ), // Warm fallback color context matching the image
              child: const Center(
                child: Icon(Icons.menu_book, size: 40, color: textSecondary),
              ),
            ),
          ),
        ),

        // --- 2. DETAILS & ACTION CONTROLS CONTENT BLOCK ---
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 'Recorded' Pill Badge Indicator
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: badgeBlue,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: const Text(
                  "Recorded",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 14.0),

              // Title Header
              Text(
                course.title ?? "Course Title",
                style: const TextStyle(
                  color: textPrimary,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),

              // Subtitle (If applicable, showing here clean line separation spacing)
              if (course.subtitle != null && course.subtitle!.isNotEmpty) ...[
                const SizedBox(height: 8.0),
                Text(
                  course.subtitle!,
                  style: const TextStyle(
                    color: textSecondary,
                    fontSize: 13.0,
                    height: 1.4,
                  ),
                ),
              ],
              const SizedBox(height: 24.0),

              // --- PRICE & ACTION BUTTONS ROW ---
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      course.price != null ? "\$${course.price}" : "\$60.00",
                      style: const TextStyle(
                        color: tealBrand,
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    flex: 4,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tealBrand,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      child: const Text(
                        "Enroll Now",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    flex: 4,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tealBrand,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      child: const Text(
                        "Add to Cart",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28.0),

              // --- SHARE ACTIONS BLOCK ---
              const Text(
                "Share this course",
                style: TextStyle(
                  color: textPrimary,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12.0),
              Row(
                children: [
                  _buildSocialIcon(
                    Icons.phone_android,
                    const Color(0xFF25D366),
                  ), // WhatsApp Color placeholder
                  const SizedBox(width: 10.0),
                  _buildSocialIcon(
                    Icons.facebook,
                    const Color(0xFF1877F2),
                  ), // Facebook Color
                  const SizedBox(width: 10.0),
                  _buildSocialIcon(
                    Icons.close,
                    Colors.black,
                  ), // X / Twitter Alternative
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper widget to cleanly generate standard square rounded social button anchors
Widget _buildSocialIcon(IconData icon, Color bg) {
  return Container(
    height: 36.0,
    width: 36.0,
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Icon(icon, color: Colors.white, size: 20.0),
  );
}

Widget _buildStudentReviewsCard(BuildContext context, CouseDeatilsResponse course, CourseReviewModel reviews) {
  const Color textPrimary = Color(0xFF0F172A); // Dark Slate/Blue
  const Color textSecondary = Color(0xFF64748B); // Muted Gray
  const Color starColor = Color(0xFFF59E0B); // Vibrant Orange Star Tint
  const Color buttonBorderColor = Color(0xFFE2E8F0); // Subtle Border Grey

  // Safely fallback parameters based on empty or zero database configurations
  final String ratingAvg = "N/A";
  final int reviewsCount = 0;

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.black.withOpacity(0.06), width: 1),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.02),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // --- 1. HEADER ROW (TITLE & RATING METADATA) ---
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Student Reviews",
              style: TextStyle(
                color: textPrimary,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, color: starColor, size: 18.0),
                const SizedBox(width: 6.0),
                Text(
                  ratingAvg,
                  style: const TextStyle(
                    color: textPrimary,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4.0),
                Text(
                  "($reviewsCount reviews)",
                  style: const TextStyle(
                    color: textSecondary,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20.0),

        // --- 2. EMPTY STATE SUBTEXT INDICATOR ---
   // --- 2. REVIEW STATE BRANCHING ---
reviews.results == null || reviews.results!.isEmpty
    ? const Text(
        "No reviews yet. Be the first to write one.",
        style: TextStyle(
          color: textSecondary,
          fontSize: 13.0,
          fontWeight: FontWeight.w400,
        ),
      )
    : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ...reviews.results!.map((review) => _buildIndividualReviewTile(review)),
        ],
      ),
        const SizedBox(height: 20.0),

        // --- 3. OUTLINED ACTION BUTTON ---
        OutlinedButton(
         onPressed: () async {
  // 1. Await the asynchronous access token check
  final String? accessToken = await TokenStorage.getAccessToken();

  // 2. Ensure context is still alive after the async file/secure storage check
  if (!context.mounted) return;

  // 3. Evaluate your token condition safely
  if (accessToken != null && accessToken.isNotEmpty) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => WriteReviewDialog(courseId: course.id!),
    );
  } else {
    // 4. Fallback: Prompt user to login if they are unauthenticated
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please sign in to write a review."),
        backgroundColor: Colors.orangeAccent,
      ),
    );
    // Optional: Route to your login path here
    // context.push(TeachersRoutes.login);
  }
},
          style: OutlinedButton.styleFrom(
            // Setting double.infinity here forces full horizontal growth internally
            minimumSize: const Size(double.infinity, 48.0),
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            side: const BorderSide(color: buttonBorderColor, width: 1.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          child: const Text(
            "Write a Review",
            style: TextStyle(
              color: textPrimary,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildIndividualReviewTile(Results review) {
  const Color textPrimary = Color(0xFF0F172A);
  const Color textSecondary = Color(0xFF64748B);
  const Color starColor = Color(0xFFF59E0B);
  const Color cardBorderColor = Color(0xFFE2E8F0);

  // Parse out a clean human-readable short date (e.g., "Jun 2026") from your ISO string
  String formattedDate = "";
  if (review.createdAt != null && review.createdAt!.isNotEmpty) {
    try {
      final DateTime parsedDate = DateTime.parse(review.createdAt!);
      const List<String> months = [
        "Jan", "Feb", "Mar", "Apr", "May", "Jun", 
        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
      ];
      formattedDate = "${months[parsedDate.month - 1]} ${parsedDate.year}";
    } catch (_) {
      formattedDate = "Jun 2026"; // Consistent placeholder fallback
    }
  }

  // Extracts the single first letter fallback string for the user initial avatar container
  String initialLetter = "U";
  if (review.userName != null && review.userName!.trim().isNotEmpty) {
    initialLetter = review.userName!.trim().substring(0, 1).toUpperCase();
  }

  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFF8FAFC), // Subtle light tint layout box container shading background
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: cardBorderColor, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- AVATAR CHIP WITH USER INITIAL ---
        CircleAvatar(
          radius: 20.0,
          backgroundColor: const Color(0xFFE2E8F0),
          child: Text(
            initialLetter,
            style: const TextStyle(
              color: textSecondary,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 14.0),

        // --- CONTENT SECTION AREA ---
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Name & Timestamp Line
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    review.userName ?? "Anonymous User",
                    style: const TextStyle(
                      color: textPrimary,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      color: textSecondary,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),

              // Dynamic Star Generator Loop mapping out review ratings
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  5,
                  (index) => Icon(
                    Icons.star,
                    size: 14.0,
                    color: index < (review.rating ?? 5)
                        ? starColor
                        : Colors.grey.shade300,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),

              // Comment Body Area Wrap
              Text(
                review.comment ?? "",
                style: const TextStyle(
                  color: textPrimary,
                  fontSize: 13.0,
                  height: 1.4,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildCertificateLockedCard(BuildContext context) {
  const Color textPrimary = Color(0xFF003B46); // Dark Deep Teal/Slate
  const Color textSecondary = Color(0xFF64748B); // Muted Gray
  const Color tealBrand = Color(0xFF2C7A7B); // Sakeena Teal Accent
  const Color containerBg = Color(0xFFEBF4F6); // Light tint behind lock icon

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(
        24.0,
      ), // Noticeably smoother, rounder edges
      border: Border.all(color: Colors.black.withOpacity(0.04), width: 1),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // --- 1. LAYERED BADGE ICON HEADER (STACK) ---
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // The Main Soft Light Teal Foundation Box
            Container(
              height: 72.0,
              width: 72.0,
              decoration: BoxDecoration(
                color: containerBg,
                borderRadius: BorderRadius.circular(18.0),
              ),
              alignment: Alignment.center,
              child: Container(
                height: 54.0,
                width: 54.0,
                decoration: BoxDecoration(
                  color: tealBrand,
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: const Icon(
                  Icons.lock_outline,
                  color: Colors.white,
                  size: 26.0,
                ),
              ),
            ),
            // The Mini Absolute Overlay Badge (Bottom Right Side)
            Positioned(
              bottom: -4,
              right: -4,
              child: Container(
                padding: const EdgeInsets.all(6.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons
                      .card_membership_outlined, // Certificate/Ribbon vector icon
                  color: tealBrand,
                  size: 16.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24.0),

        // --- 2. HEADER TYPOGRAPHY ---
        const Text(
          "Unlock Your\nProfessional Certificate",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textPrimary,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 14.0),

        // --- 3. SUBTEXT BODY ---
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Complete all course modules to earn your verified certificate and showcase your achievement.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textSecondary,
              fontSize: 13.0,
              height: 1.5,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 28.0),

        // --- 4. EXPANDED ELEVATED ACTION BUTTON ---
        ElevatedButton(
          onPressed: () {
            // Action to navigate back to dynamic course layout engine lists
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: tealBrand,
            foregroundColor: Colors.white,
            minimumSize: const Size(
              double.infinity,
              48.0,
            ), // Forces perfect full-width alignment mapping
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                24.0,
              ), // Matches image capsule profile pill styling
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_open, size: 16.0),
              SizedBox(width: 8.0),
              Text(
                "Go Back to Lectures",
                style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _curriculumLessionSection(
  CouseDeatilsResponse course,
  BuildContext context,
) {
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
        // Text(
        //   "${course.totalLessons} lessons • ${_parseHtmlString(course.description ?? '12 weeks')}",
        //   style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        // ),
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
            Padding(
              padding: const EdgeInsets.only(bottom : 8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Theme(
                  // Removes the default border lines of ExpansionTile
                  data: Theme.of(
                    context,
                  ).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    initiallyExpanded: false,
                    title: Text(
                      module.title ?? "Module ${index + 1}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      "${module.totalLessons} lessons • ${module.totalDuration} hours",
                      style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                    ),
                    children:  course.hasAccess! ?  
                    
                    List.generate(module.lessons?.length ?? 0, (index) {
                      final data = module.lessons?[index];
                      if (data == null) return const SizedBox.shrink();
              
                      switch (data.contentType) {
                        case "video":
                          return _buildLessonRow(
                            Icons
                                .play_circle_outline_rounded, // Perfect for video streaming lessons
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
                            Icons
                                .description_outlined, // Perfect file/PDF document icon
                            data.title ?? "Untitled Document",
                            "Document", // Fixed fallback subtitle
                            isAssignment:
                                false, // Changed to false unless it grades like an assignment
                          );
              
                        case "quiz":
                          return _buildLessonRow(
                            Icons
                                .quiz_outlined, // Perfect dedicated question/quiz icon
                            data.title ?? "Untitled Quiz",
                            "Quiz Assessment", // Fixed fallback subtitle
                            isAssignment:
                                true, // Typically acts as an assessment block
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
                 
                 : 
                    List.generate(module.lessons?.length ?? 0, (index) {
                      final data = module.lessons?[index];
                      if (data == null) return const SizedBox.shrink();
              
                      switch (data.contentType) {
                        case "video":
                          return _buildLessonRow(
                           Icons.lock, // Perfect for video streaming lessons
                            data.title ?? "Untitled Video",
                            "${data.durationInMinutes ?? "0"} mins",
                          );
              
                        case "assignment":
                          return _buildLessonRow(
                             Icons.lock, // Standard assignment icon
                            data.title ?? "Untitled Assignment",
                            "Assignment",
                            isAssignment: true,
                          );
              
                        case "document":
                          return _buildLessonRow(
                              Icons.lock,// Perfect file/PDF document icon
                            data.title ?? "Untitled Document",
                            "Document", // Fixed fallback subtitle
                            isAssignment:
                                false, // Changed to false unless it grades like an assignment
                          );
              
                        case "quiz":
                          return _buildLessonRow(
                             Icons.lock,// Perfect dedicated question/quiz icon
                            data.title ?? "Untitled Quiz",
                            "Quiz Assessment", // Fixed fallback subtitle
                            isAssignment:
                                true, // Typically acts as an assessment block
                          );
              
                        default:
                          // Catch-all fallback for any unhandled media categories
                          return _buildLessonRow( 
                              Icons.lock,
                            data.title ?? "Lesson Extra",
                            "Attachment",
                          );
                      }
                    }),
                 
                 
                  ),
                ),
              ),
            );

            ;
          },
        ),
      ],
    ),
  );
}

Widget _buildLessonRow(
  IconData icon,
  String title,
  String trailing, {
  bool isAssignment = false,
}) {
  // Matching your dashboard design language
  final Color activeTeal = const Color(0xFF2C7A7B);
  final Color accentOrange = const Color(0xFFE67E22);

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isAssignment
              ? accentOrange.withOpacity(0.15)
              : Colors.grey.shade100,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Dynamic Leading Icon
          Icon(icon, size: 18, color: isAssignment ? accentOrange : activeTeal),
          const SizedBox(width: 12),

          // 2. Expandable Title Context
          Expanded(
            child: Text(
              title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
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
  const Color textPrimary = Color(0xFF111827); // Dark Slate
  const Color textSecondary = Color(0xFF6B7280); // Muted Grey
  const Color cardBg = Colors.white;

  return Container(
    width: double.infinity,
    // Using standard Flutter edge paddings for clean across-the-board density rendering
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: cardBg,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.black.withOpacity(0.06), width: 1),
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
      mainAxisSize:
          MainAxisSize.min, // Ensures card tight-fits its contents dynamically
      children: [
        // 1. SECTION TITLE
        const Text(
          "Instructor",
          style: TextStyle(
            color: textPrimary,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16.0),

        // 2. AVATAR & PROFESSIONAL METADATA ROW
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 28.0, // Fixed logical layout profile avatar diameter base
              backgroundColor: Colors.grey.shade200,
              backgroundImage:
                  teacher?.profilePicture != null &&
                      teacher!.profilePicture!.isNotEmpty
                  ? NetworkImage(teacher.profilePicture!)
                  : null,
              child:
                  teacher?.profilePicture == null ||
                      teacher!.profilePicture!.isEmpty
                  ? const Icon(Icons.person, size: 28.0, color: textSecondary)
                  : null,
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${teacher?.user?.firstName ?? ''} ${teacher?.user?.lastName ?? ''}"
                            .trim()
                            .isNotEmpty
                        ? "${teacher?.user?.firstName} ${teacher?.user?.lastName}"
                        : "Expert Instructor",
                    style: const TextStyle(
                      color: textPrimary,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    teacher?.professionalTitle ?? "Faculty Member",
                    style: const TextStyle(
                      color: textSecondary,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (teacher?.location != null &&
                      teacher!.location!.isNotEmpty) ...[
                    const SizedBox(height: 4.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 12.0,
                          color: Color(0xFFD53F8C), // Rose/Pink Location Pin
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          teacher!.location!,
                          style: TextStyle(
                            color: textSecondary.withOpacity(0.8),
                            fontSize: 11.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),

        // 3. BIOGRAPHY SECTION
        if (teacher?.about != null && teacher!.about!.isNotEmpty) ...[
          const SizedBox(height: 16.0),
          Text(
            teacher!.about!,
            style: TextStyle(
              color: textSecondary.withOpacity(0.9),
              fontSize: 13.0,
              height:
                  1.5, // Native proportional line-height for seamless text layout
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ],
    ),
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

Widget _buildCourseDetailsCard(CouseDeatilsResponse course) {
  const Color textPrimary = Color(0xFF0F172A); // Dark Blue/Slate
  const Color textSecondary = Color(0xFF64748B); // Muted Slate Gray
  const Color badgeGreenBg = Color(0xFFE2F5F3); // Pale Teal/Green
  const Color badgeGreenText = Color(0xFF2C7A7B); // Deep Sakeena Teal
  const Color badgeOrangeBg = Color(0xFFFFF2E8); // Soft Peach/Orange
  const Color badgeOrangeText = Color(0xFFB45309); // Deep Amber/Orange

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.black.withOpacity(0.06), width: 1),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.02),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // --- SECTION HEADER ---
        const Text(
          "Course Details",
          style: TextStyle(
            color: textPrimary,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20.0),

        // --- 1. LEVEL METADATA ROW ---
        _buildDetailsRow(
          label: "Level",
          valueWidget: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: badgeGreenBg,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              (course.level ?? "beginner").toLowerCase(),
              style: const TextStyle(
                color: badgeGreenText,
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        // --- 2. DURATION ROW ---
        _buildDetailsRow(
          label: "Duration",
          valueText: "${course.totalHours} hours (${course.durationInWeeks})",
        ),

        // --- 3. HOURS PER SESSION ROW ---
        _buildDetailsRow(
          label: "Hours per Session",
          valueText: course.hoursPerSession ?? "1.50 hrs",
        ),

        // --- 4. LESSONS ROW ---
        _buildDetailsRow(
          label: "Lessons",
          valueText: course.totalLessons?.toString() ?? "18",
        ),

        // --- 5. MODULES ROW ---
        _buildDetailsRow(
          label: "Modules",
          valueText: course.modules!.length.toString() ?? "6",
        ),

        // --- 6. START DATE ROW ---
        _buildDetailsRow(
          label: "Start Date",
          valueText: course.startDate ?? "Not specified",
        ),

        // --- 7. CATEGORY ROW ---
        _buildDetailsRow(
          label: "Category",
          valueText: course.category!.name ?? "Islam",
        ),

        // --- 8. STATUS METADATA ROW ---
        _buildDetailsRow(
          label: "Status",
          isLast: true, // Drops bottom padding
          valueWidget: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: badgeOrangeBg,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              course.status ?? "Recorded",
              style: const TextStyle(
                color: badgeOrangeText,
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}


Widget _buildScholarshipCard(BuildContext context, CouseDeatilsResponse course) {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  // Design Theme Palette matching your screens
  const Color tealBrand = Color(0xFF2C7A7B);
  const Color textPrimary = Color(0xFF0F172A);
  const Color textSecondary = Color(0xFF64748B);
  const Color errorRed = Color(0xFFEF4444);
  const Color inputBgColor = Color(0xFFF8FAFC);
  const Color fieldBorderColor = Color(0xFFE2E8F0);

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.black.withOpacity(0.05)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.02),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // --- 1. HEADER PORTION ---
          Text(
            "APPLY NOW FOR OUR EDUCATION SUPPORT\nSCHOLARSHIP.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textPrimary,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            "Course: ${course?.title ?? 'From Doubt to Certainty: Tawakkul and Certainty Islam Course'}",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: textSecondary,
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 32.0),

          // --- 2. INPUT GRID LAYOUT FIELDS ---
          
          // Row 1: Name & Email
          _buildResponsiveRow(
            child1: _buildInputField(
              label: "Name",
              isRequired: true,
              hint: "Full Name",
              labelColor: textSecondary,
            ),
            child2: _buildInputField(
              label: "Email",
              isRequired: true,
              hint: "Email",
              labelColor: textSecondary,
            ),
          ),
          const SizedBox(height: 16.0),

          // Row 2: Phone Number & Address
          _buildResponsiveRow(
            child1: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFieldLabel("Phone Number", isRequired: true, labelColor: textSecondary),
                Row(
                  children: [
                    // Mock Country Dropdown Selector Container
                    Container(
                      height: 48.0,
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: inputBgColor,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: fieldBorderColor),
                      ),
                      child: Row(
                        children: [
                          Text("AE +971", style: TextStyle(color: textPrimary, fontSize: 13.0)),
                          const Icon(Icons.arrow_drop_down, color: textSecondary, size: 20.0),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    // Main Phone Input Target
                    Expanded(
                      child: _buildBaseTextField(hint: "Enter phone number", inputBg: inputBgColor, borderCol: fieldBorderColor),
                    ),
                  ],
                ),
              ],
            ),
            child2: _buildInputField(
              label: "Address",
              hint: "City/Country",
              labelColor: textSecondary,
            ),
          ),
          const SizedBox(height: 16.0),

          // Row 3: Current Level of Study & Field of Study / Major
          _buildResponsiveRow(
            child1: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFieldLabel("Current Level of Study", isRequired: true, labelColor: textSecondary),
                Container(
                  height: 48.0,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: inputBgColor,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: fieldBorderColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Select level", style: TextStyle(color: textSecondary.withOpacity(0.7), fontSize: 14.0)),
                      const Icon(Icons.keyboard_arrow_down, color: textSecondary, size: 18.0),
                    ],
                  ),
                ),
              ],
            ),
            child2: _buildInputField(
              label: "Field of Study / Major",
              isRequired: true,
              hint: "Provide Your Qualifications and Interests In Detail",
              labelColor: textSecondary,
            ),
          ),
          const SizedBox(height: 16.0),

          // Row 4: Textarea Question 1
          _buildInputField(
            label: "Why are you applying for this scholarship?",
            isRequired: true,
            hint: "Write a brief explanation of your need and motivation",
            maxLines: 4,
            labelColor: textSecondary,
          ),
          const SizedBox(height: 16.0),

          // Row 5: Textarea Question 2
          _buildInputField(
            label: "How will this scholarship help you achieve your goals?",
            isRequired: true,
            hint: "Explain your career goals and how this support helps",
            maxLines: 4,
            labelColor: textSecondary,
          ),
          const SizedBox(height: 16.0),

          // Row 6: Upload Asset Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFieldLabel("Upload Personal Statement or Motivation Letter", labelColor: textSecondary),
              Container(
                height: 48.0,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: inputBgColor,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: fieldBorderColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Choose Files", style: TextStyle(color: textSecondary.withOpacity(0.7), fontSize: 14.0)),
                    const Icon(Icons.upload_file_outlined, color: textSecondary, size: 18.0),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),

          // --- 3. PRIVACY CHECKBOX AGREEMENT ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 24.0,
                width: 24.0,
                child: Checkbox(
                  value: false,
                  onChanged: (val) {},
                  activeColor: tealBrand,
                  side: const BorderSide(color: fieldBorderColor, width: 1.5),
                ),
              ),
              const SizedBox(width: 10.0),
              const Expanded(
                child: Text(
                  "I agree to be contacted for further discussion and opportunities.",
                  style: TextStyle(
                    color: textSecondary,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32.0),

          // --- 4. ACTION SUBMIT CONTROL FOOTER BUTTONS ---
          Row(
  children: [
    // --- 1. CANCEL BUTTON ---
    Expanded(
      child: OutlinedButton(
        onPressed: () {
          // Handle cancellation action or view pop
        },
        style: OutlinedButton.styleFrom(
          // Reduced horizontal padding to allow more layout space for the text itself
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
          side: const BorderSide(color: fieldBorderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
        child: const Text(
          "Cancel",
          style: TextStyle(
            color: textPrimary,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    
    // Clean structural separation gap between action targets
    const SizedBox(width: 16.0),
    
    // --- 2. SUBMIT APPLICATION BUTTON ---
    Expanded(
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState?.validate() ?? false) {
            // Execute Submit Application Pipeline
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: tealBrand,
          foregroundColor: Colors.white,
          // Reduced horizontal padding prevents text from breaking into two lines or overflowing on small screens
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
        child: const Text(
          "Send Application",
          maxLines: 1, // Guarantees the button label doesn't wrap weirdly
          overflow: TextOverflow.ellipsis, // Clean fallback safety layer
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ],
)
        ],
      ),
    ),
  );
}

// Layout helper that adapts elements gracefully side-by-side
Widget _buildResponsiveRow({required Widget child1, required Widget child2}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth > 500) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: child1),
            const SizedBox(width: 16.0),
            Expanded(child: child2),
          ],
        );
      } else {
        return Column(
          children: [
            child1,
            const SizedBox(height: 16.0),
            child2,
          ],
        );
      }
    },
  );
}

// Modular Input Construction Wrapper Block
Widget _buildInputField({
  required String label,
  required String hint,
  bool isRequired = false,
  int maxLines = 1,
  required Color labelColor,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildFieldLabel(label, isRequired: isRequired, labelColor: labelColor),
      _buildBaseTextField(hint: hint, maxLines: maxLines, inputBg: const Color(0xFFF8FAFC), borderCol: const Color(0xFFE2E8F0)),
    ],
  );
}

Widget _buildFieldLabel(String label, {bool isRequired = false, required Color labelColor}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: SizedBox(
      width: double.infinity, // Ensures the layout block fills the input container's bounds
      child: RichText(
        text: TextSpan(
          text: label,
          style: TextStyle(
            color: labelColor,
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            fontFamily: '', // Inherits your default application text font style cleanly
          ),
          children: [
            if (isRequired)
              const TextSpan(
                text: " *", // Adds clean inline spacing right before the red asterisk
                style: TextStyle(
                  color: Color(0xFFEF4444), // Vibrant error red asterisk color indicator
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildBaseTextField({required String hint, int maxLines = 1, required Color inputBg, required Color borderCol}) {
  return TextFormField(
    maxLines: maxLines,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0x9464748B), fontSize: 14.0),
      fillColor: inputBg,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: borderCol, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Color(0xFF2C7A7B), width: 1.5),
      ),
    ),
  );
}
// --- HELPER METADATA ROW GENERATOR ---
Widget _buildDetailsRow({
  required String label,
  String? valueText,
  Widget? valueWidget,
  bool isLast = false,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: isLast ? 0.0 : 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Column Label
        Text(
          label,
          style: const TextStyle(
            color: Color(
              0xFF64748B,
            ), // Custom structural secondary text grey color
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),

        // Right Column Target Data
        valueWidget ??
            Text(
              valueText ?? "",
              style: const TextStyle(
                color: Color(
                  0xFF0F172A,
                ), // Dark value context color matching layout
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
      ],
    ),
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
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
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
