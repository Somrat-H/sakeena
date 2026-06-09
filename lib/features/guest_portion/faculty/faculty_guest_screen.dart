import 'dart:async'; // Required for Timer (Debouncer)
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/features/guest_portion/home/provider/home_guest_provider.dart';
import 'package:sakeena/route/go_route.dart';

import '../home/model/faculty_model.dart';
import '../home/view/widget/faculty_card.dart';

class FacultyGuestScreen extends StatefulWidget {
  const FacultyGuestScreen({super.key});

  @override
  State<FacultyGuestScreen> createState() => _FacultyGuestScreenState();
}

class _FacultyGuestScreenState extends State<FacultyGuestScreen> {
  // Search Controller and Debouncer instances
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  // Dynamic Network Page Tracking State
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    // Fetch initial first page profile data when screen mounts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeGuestProvider>().getFacultyFilter("page", "1");
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  // Handles dynamic network pagination changes
  void _changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
    // Triggers endpoint: /teacher-profiles/page=X
    context.read<HomeGuestProvider>().getFacultyFilter(
      "page",
      newPage.toString(),
    );
  }

  // Delays data fetching while typing to avoid spamming network queries
  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        currentPage = 1; // Direct search resets to initial page block
      });
      // Triggers endpoint: /teacher-profiles/search=query_text
      context.read<HomeGuestProvider>().getFacultyFilter("search", query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeGuestProvider>();
    final facultyList = controller.facultyModel.results ?? [];

    // Dynamically query total page variables from response payload; defaults to 1
    final int totalPages = controller.facultyModel.totalPages ?? 1;

    // Brand color tokens synced from design specs
    const Color headerColor = Color(0xFF2C7A7B);
    const Color backgroundColor = Color(0xFFF9FAFB);
    const Color descTextColor = Color(0xFF4B5563);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- 1. Dynamic Gradient Header Banner ---
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
                    // Over-title pill chip indicator
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: Icon(Icons.arrow_back),
                        ),
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
                            "Meet Our Experts",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Main section heading title text
                    Text(
                      "Our Faculty",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Subtitle structural explanation line
                    Text(
                      "Learn from certified Islamic scholars and licensed mental health professionals",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 13.sp,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Customized search bar container connecting to backend query method
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
                        onChanged: _onSearchChanged,
                      ),
                    ),
                  ],
                ),
              ),

              // --- 2. Featured Instructors Header Label ---
              SizedBox(height: 24.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "Featured Instructors",
                  style: TextStyle(
                    color: const Color(0xFF111827),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 14.h),

              // --- 3. Dynamic Rendering & View Layout Validation Engine ---
              controller.isDoorsLoading
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 80.h),
                      child: const Center(
                        child: CircularProgressIndicator(color: headerColor),
                      ),
                    )
                  : facultyList.isEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 60.h),
                      child: const Center(
                        child: Text(
                          "No instructors match your search criteria.",
                          style: TextStyle(
                            color: descTextColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 355.h, // Explicit height container matches FacultyCard boundaries safely
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: facultyList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 14.w),
                            child: FacultyCard(
                              faculty: facultyList[index],
                              onViewProfile: () {
                                controller.getFacultyDetails(
                                  facultyList[index].id!.toInt(),
                                );

                                context.push(AppRoutes.facultyDetails);
                              },
                            ),
                          );
                        },
                      ),
                    ),

              // ─── 4. High Fidelity Navigation Pagination Controller Row (image_00d7da.png) ───
              if (!controller.isDoorsLoading && totalPages > 1) ...[
                SizedBox(height: 40.h),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Arrow Left Back Page Navigation Toggle Button
                        _buildArrowButton(
                          icon: Icons.chevron_left,
                          isEnabled: currentPage > 1,
                          onPressed: () => _changePage(currentPage - 1),
                        ),
                        SizedBox(width: 8.w),

                        // Numerical Page Circle Indexing Row Loop Tracker
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
                        // Arrow Right Next Page Navigation Toggle Button
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
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  // Visual helper method creating matching outer circle borders matching image_00d7da.png layout guidelines
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
