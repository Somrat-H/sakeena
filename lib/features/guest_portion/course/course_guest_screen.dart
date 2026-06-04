import 'dart:async'; // Required for Timer (Debouncer)
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/features/guest_portion/home/provider/home_guest_provider.dart';
import 'package:sakeena/route/teachers_routes.dart';
import 'package:sakeena/widgets/course_card.dart';

class CourseGuestScreen extends StatefulWidget {
  const CourseGuestScreen({super.key});

  @override
  State<CourseGuestScreen> createState() => _CourseGuestScreenState();
}

class _CourseGuestScreenState extends State<CourseGuestScreen> {
  // Local state managers for filters
  String selectedType = "All";
  String selectedInstructor = "All";

  // Search Controller and Debouncer
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  // Dynamic Network Page Tracking
  int currentPage = 1;

  // Filter configuration tracks matching image_0ab1a2.png layout rules
  final List<String> courseTypes = ["All", "Recorded", "Running", "Upcoming"];

  @override
  void initState() {
    super.initState();
    // Pre-fetch the first page over the network immediately when the layout mounts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeGuestProvider>().getCourseByFilter("page", "1");
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  // Centralized method to trigger pagination requests cleanly
  void _changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
    context.read<HomeGuestProvider>().getCourseByFilter(
      "page",
      newPage.toString(),
    );
  }

  // Debounced search handler to prevent spamming backend requests
  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      // Whenever searching, reset pagination back to page 1
      setState(() {
        currentPage = 1;
      });

      // Hit backend API: /courses/?search=query_text
      context.read<HomeGuestProvider>().getCourseByFilter("search", query);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Brand design color guidelines matching image_0ab1a2.png
    const Color headerColor = Color(0xFF2C7A7B);
    const Color backgroundColor = Color(0xFFFAF6EE);
    const Color titleDark = Color(0xFF111827);
    const Color descTextColor = Color(0xFF4B5563);

    final controller = context.watch<HomeGuestProvider>();
    final serverCourses = controller.course.results ?? [];

    // Read total pages directly from backend response model
    final int totalPages = controller.course.totalPages ?? 1;

    // Extract dynamic unique instructor lists from server records if available
    final List<String> instructorDropdownItems = ["All"];
    for (var course in serverCourses) {
      if (course.teacher?.user != null) {
        final fullName =
            "${course.teacher!.user!.firstName ?? ''} ${course.teacher!.user!.lastName ?? ''}"
                .trim();
        if (fullName.isNotEmpty &&
            !instructorDropdownItems.contains(fullName)) {
          instructorDropdownItems.add(fullName);
        }
      }
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. DYNAMIC GRADIENT HEADER BANNER ---
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(24.w, 60.h, 24.w, 40.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [headerColor, headerColor.withOpacity(0.85)],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      "Knowledge & Insights",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Our Courses",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "A collection of upcoming live programs and recorded learning experiences in Islamic psychology, emotional healing and mental well-being.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 13.sp,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Search bar container calling server-side filters
                  Container(
                    height: 46.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.25),
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintText:
                            "Search by name, expertise, or scholar type...",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 13.sp,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white.withOpacity(0.7),
                          size: 20.r,
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  _searchController.clear();
                                  _onSearchChanged("");
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.white.withOpacity(0.7),
                                  size: 18.r,
                                ),
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 11.h),
                      ),
                      onChanged:
                          _onSearchChanged, // Hook to debounced network caller
                    ),
                  ),
                ],
              ),
            ),

            // --- 2. INTERACTIVE CONTROLS & FILTER ROW TRACKS ---
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Instructor: ",
                        style: TextStyle(color: descTextColor, fontSize: 13.sp),
                      ),
                      // Container(
                      //   padding: EdgeInsets.symmetric(horizontal: 12.w),
                      //   height: 32.h,
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(16.r),
                      //     border: Border.all(color: Colors.black12),
                      //   ),
                      //   child: DropdownButtonHideUnderline(
                      //     child: DropdownButton<String>(
                      //       value: selectedInstructor,
                      //       icon: Icon(Icons.keyboard_arrow_down, size: 16.r, color: descTextColor),
                      //       style: TextStyle(color: titleDark, fontSize: 12.sp, fontWeight: FontWeight.w500),
                      //       onChanged: (String? newValue) {
                      //         if (newValue != null) {
                      //           setState(() {
                      //             selectedInstructor = newValue;
                      //           });
                      //         }
                      //       },
                      //       items: instructorDropdownItems.map<DropdownMenuItem<String>>((String value) {
                      //         return DropdownMenuItem<String>(
                      //           value: value,
                      //           child: Text(value),
                      //         );
                      //       }).toList(),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: courseTypes.map((type) {
                    final bool isSelected = selectedType == type;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedType = type;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? headerColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Text(
                          type,
                          style: TextStyle(
                            color: isSelected ? Colors.white : descTextColor,
                            fontSize: 12.sp,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // --- 3. VERTICAL COURSES LISTVIEW BUILDER (SERVER-PAGINATED & SEARCHED ARRAY) ---
            SizedBox(height: 20.h),
            controller.isDoorsLoading
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 60.h),
                    child: const Center(
                      child: CircularProgressIndicator(color: headerColor),
                    ),
                  )
                : serverCourses.isEmpty
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: const Center(
                      child: Text(
                        "No courses found matching your query.",
                        style: TextStyle(
                          color: descTextColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: serverCourses.length,
                    itemBuilder: (context, index) {
                      final course = serverCourses[index];
                      return CourseCardTeacher(
                        imageUrl:
                            course.thumbnail ??
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9ClZ-sWSzj1r9lMta57sD-X_zuxkbo_1kWw&s",
                        category: course.category?.name ?? 'Uncategorized',
                        title: course.title ?? 'Untitled Course',
                        instructor:
                            "${course.teacher?.user?.firstName ?? ''} ${course.teacher?.user?.lastName ?? ''}"
                                .trim(),
                        lessons: course.totalLessons ?? 0,
                        weeks: course.durationInWeeks ?? 0,
                        totalHours:
                            double.tryParse(course.totalHours ?? '0') ?? 0.0,
                        hoursPerSession:
                            double.tryParse(course.hoursPerSession ?? '0') ??
                            0.0,
                        price: course.price ?? "0.0",
                        status: course.status ?? 'Uncategorized',
                        onViewDetails: () async {
                          if (course.id == null) return;

                          try {
                            // 1. Await the API response safely
                            await controller.getCourseReview(course.id!);

                            // 2. Ensure context is still alive after the async network call
                            if (!context.mounted) return;

                            // 3. Route to the detail page passing the necessary identifier
                            context.push(
                              TeachersRoutes.courseDetail,
                              extra: course.id,
                            );
                          } catch (error) {
                            // 4. Clean fallback safety catch to prevent unhandled background rejections
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Failed to load course details. Please try again. ($error)",
                                  ),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                            }
                          }
                        },
                      );
                    },
                  ),

            // ─── 4. DYNAMIC PAGINATION ROW COMPONENT ───
            if (!controller.isDoorsLoading && totalPages > 1) ...[
              SizedBox(height: 30.h),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildArrowButton(
                        icon: Icons.chevron_left,
                        isEnabled: currentPage > 1,
                        onPressed: () => _changePage(currentPage - 1),
                      ),
                      SizedBox(width: 8.w),

                      ...List.generate(totalPages, (index) {
                        final pageNum = index + 1;
                        final bool isActive = pageNum == currentPage;

                        return GestureDetector(
                          onTap: () => _changePage(pageNum),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: EdgeInsets.symmetric(horizontal: 6.w),
                            height: 38.r,
                            width: 38.r,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? headerColor
                                  : const Color(0xFFF1F5F9),
                              shape: BoxShape.circle,
                              boxShadow: isActive
                                  ? [
                                      BoxShadow(
                                        color: headerColor.withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                "$pageNum",
                                style: TextStyle(
                                  color: isActive
                                      ? Colors.white
                                      : const Color(0xFF334155),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),

                      SizedBox(width: 8.w),
                      _buildArrowButton(
                        icon: Icons.chevron_right,
                        isEnabled: currentPage < totalPages,
                        onPressed: () => _changePage(currentPage + 1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildArrowButton({
    required IconData icon,
    required bool isEnabled,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: Container(
        height: 38.r,
        width: 38.r,
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC).withOpacity(isEnabled ? 1.0 : 0.5),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
        ),
        child: Icon(
          icon,
          size: 18.r,
          color: isEnabled ? const Color(0xFF94A3B8) : const Color(0xFFCBD5E1),
        ),
      ),
    );
  }
}
