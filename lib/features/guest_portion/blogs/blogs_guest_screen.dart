import 'dart:async'; // Required for Timer processing
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/features/guest_portion/home/provider/guest_navbar_provider.dart';
import 'package:sakeena/features/guest_portion/home/provider/home_guest_provider.dart';
import 'package:sakeena/features/guest_portion/home/view/widget/blog_card.dart';
import 'package:sakeena/route/go_route.dart';

class BlogsGuestScreen extends StatefulWidget {
  const BlogsGuestScreen({super.key});

  @override
  State<BlogsGuestScreen> createState() => _BlogsGuestScreenState();
}

class _BlogsGuestScreenState extends State<BlogsGuestScreen> {
  String selectedCategory = "All";
  final TextEditingController _searchController = TextEditingController();
  
  // --- DEBOUNCE TIMER OBJECT ---
  Timer? _debounceTimer;

  final List<String> categories = [
    "All", "Identity", "Islam", "Islamic Psychology", "Marriage",
    "Mental Health", "Muslim Youth", "Parents", "Quran", "Ruqyah", "Trauma"
  ];

  @override
  void initState() {
    super.initState();
    // Fetch initial records cleanly when screen loads
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.read<HomeGuestProvider>().getBlogByFilter("page", "1");
    // });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel(); // Critical: Destroys active async timer threads to stop memory leaks
    super.dispose();
  }

  // --- TIMER-DRIVEN DEBOUNCE SEARCH ACTION HANDLER ---
  void _onSearchChanged(String value) {
    // Drop execution context tracking if a running thread is currently active
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    // Start a fresh 500ms delay countdown window
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      final query = value.trim();
      if (query.isNotEmpty) {
        setState(() {
          selectedCategory = ""; // Remove active category highlight during live typing search
        });
        context.read<HomeGuestProvider>().getBlogByFilter("search", query);
      } else {
        // If the query is completely backspaced, reset to baseline layout
        setState(() {
          selectedCategory = "All";
        });
        context.read<HomeGuestProvider>().getBlogByFilter("page", "1");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color headerTeal = Color(0xFF2C7A7B);
    const Color canvasWarmBg = Color(0xFFFAF6EE);
    const Color textSecondary = Color(0xFF4B5563);
    
    final controller = context.watch<HomeGuestProvider>();

    return Scaffold(
      backgroundColor: canvasWarmBg,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. SAKEENA INSTITUTE BRAND TEAL HEADER BANNER ---
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(24.w, 60.h, 24.w, 40.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [headerTeal, headerTeal.withOpacity(0.85)],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
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
                    "Sakeena Institute Blog",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "Explore articles on Islamic psychology, mental wellness, and spiritual growth",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 13.sp,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  
                  // --- DEBOUNCED LIVE TEXT INPUT ---
                  Container(
                    height: 46.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(color: Colors.white.withOpacity(0.25), width: 1),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      textInputAction: TextInputAction.search,
                      onChanged: _onSearchChanged, // Fires dynamic debounce checking sequence
                      decoration: InputDecoration(
                        hintText: "Search articles...",
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13.sp),
                        prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(0.7), size: 20.r),
                        suffixIcon: ValueListenableBuilder<TextEditingValue>(
                          valueListenable: _searchController,
                          builder: (context, textValue, _) {
                            return textValue.text.isNotEmpty 
                              ? IconButton(
                                  icon: Icon(Icons.clear, color: Colors.white.withOpacity(0.7), size: 18.r),
                                  onPressed: () {
                                    _searchController.clear();
                                    _debounceTimer?.cancel(); // Instantly kill typing trackers
                                    setState(() {
                                      selectedCategory = "All";
                                    });
                                    context.read<HomeGuestProvider>().getBlogByFilter("page", "1");
                                  },
                                )
                              : const SizedBox.shrink();
                          },
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 11.h),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- 2. MULTI-LINE FILTER CATEGORIES WRAP ---
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                     
                        Text(
                          "Category",
                          style: TextStyle(color: textSecondary, fontSize: 13.sp, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                 Expanded(
  child: SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    physics: const BouncingScrollPhysics(),
    child: Row(
      children: categories.map((cat) {
        final bool isSelected = selectedCategory == cat;
        return Padding(
          // Provides consistent spacing between your horizontal items
          padding: EdgeInsets.only(right: 8.w),
          child: GestureDetector(
            onTap: () {
              if (selectedCategory == cat) return;
              
              // Reset search components cleanly when switching filters
              _searchController.clear();
              _debounceTimer?.cancel();
              
              setState(() {
                selectedCategory = cat;
              });

              if (cat == "All") {
                context.read<HomeGuestProvider>().getBlogByFilter("page", "1");
              } else {
                context.read<HomeGuestProvider>().getBlogByFilter("category_slug", cat);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: isSelected ? headerTeal : Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: isSelected ? Colors.transparent : Colors.black.withOpacity(0.05),
                ),
              ),
              child: Text(
                cat,
                style: TextStyle(
                  color: isSelected ? Colors.white : textSecondary,
                  fontSize: 12.sp,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  ),
),
                ],
              ),
            ),

            // --- 3. PROVIDER STATE DRIVEN DATA VIEWER ---
            SizedBox(height: 24.h),
            
            if (controller.isDoorsLoading)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 60.h),
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(headerTeal),
                  ),
                ),
              )
            else if (controller.blogModel?.results == null || controller.blogModel!.results!.isEmpty)
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 60.h),
                  child: Text("No articles found.", style: TextStyle(color: textSecondary, fontSize: 14.sp)),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), 
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: controller.blogModel?.results?.length ?? 0, 
                itemBuilder: (context, index) {
                  final article = controller.blogModel!.results![index];
                  return BlogCard(
                    blog: article,
                    onReadMore: () {
                 

                                  context.push(
                                  AppRoutes.blogDetails,
                                  extra: article.slug,
                                );
                    },
                  );
                },
              ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}