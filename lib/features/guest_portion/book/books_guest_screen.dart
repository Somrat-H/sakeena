import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/features/guest_portion/home/provider/home_guest_provider.dart';
import 'package:sakeena/features/guest_portion/home/view/widget/book_card.dart';
import 'package:sakeena/route/go_route.dart';

class BooksGuestScreen extends StatefulWidget {
  const BooksGuestScreen({super.key});

  @override
  State<BooksGuestScreen> createState() => _BooksGuestScreenState();
}

class _BooksGuestScreenState extends State<BooksGuestScreen> {
  // Local state properties for selected filters
  String selectedCategory = "All";
  String selectedFormat = "All";
  
  final List<String> formatTypes = ["All", "Digital", "Physical"];

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeGuestProvider>();
    
    // Synchronized brand color standards matching design layout
    const Color headerTeal = Color(0xFF2C7A7B); 
    const Color canvasWarmBg = Color(0xFFFAF6EE); // Warm background color from screen canvas
    const Color textPrimary = Color(0xFF111827);
    const Color textSecondary = Color(0xFF4B5563);

    return Scaffold(
      backgroundColor: canvasWarmBg,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. BRAND TEAL GRADIENT HEADER BANNER ---
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
                  // Upper over-title layout pill label
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      "Sakeena Press",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Main View Title Heading
                  Text(
                    "Our Book Collection",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Header Subtitle Text Description Line
                  Text(
                    "Discover insightful books on Islamic psychology, mental health, and spiritual growth",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 13.sp,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Custom text entry search container
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
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintText: "Search by title, author, or category...",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 13.sp,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white.withOpacity(0.7),
                          size: 20.r,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 11.h),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- 2. CONTROL SUB-TRACK INTERACTIVE ROW FILTERS ---
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Filter Category Row Groupings
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         
                         
                          
                          // "All" filter badge indicator
                          GestureDetector(
                            onTap: () {
                              setState(() => selectedCategory = "All");
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: selectedCategory == "All" ? headerTeal : Colors.white,
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: selectedCategory == "All" ? Colors.transparent : Colors.black.withOpacity(0.05),
                                ),
                              ),
                              child: Text(
                                "All",
                                style: TextStyle(
                                  color: selectedCategory == "All" ? Colors.white : textSecondary, 
                                  fontSize: 12.sp, 
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          
                          // "nice-book-category" unselected category container track
                          GestureDetector(
                            onTap: () {
                              setState(() => selectedCategory = "nice-book-category");
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: selectedCategory == "nice-book-category" ? headerTeal : Colors.white,
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: selectedCategory == "nice-book-category" ? Colors.transparent : Colors.black.withOpacity(0.05),
                                ),
                              ),
                              child: Text(
                                "nice-book-category",
                                style: TextStyle(
                                  color: selectedCategory == "nice-book-category" ? Colors.white : textSecondary, 
                                  fontSize: 12.sp,
                                  fontWeight: selectedCategory == "nice-book-category" ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),

                           Container(
                    padding: EdgeInsets.all(3.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: Colors.black.withOpacity(0.05)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: formatTypes.map((type) {
                        final bool isSelected = selectedFormat == type;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedFormat = type;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
                            decoration: BoxDecoration(
                              color: isSelected ? headerTeal : Colors.transparent,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Text(
                              type,
                              style: TextStyle(
                                color: isSelected ? Colors.white : textSecondary,
                                fontSize: 11.sp,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(width: 8.w),

                  // Format Type Selection Pill Segment (All, Digital, Physical)
                
                ],
              ),
            ),
 
            // --- 3. DYNAMIC BOOK CARD SELECTION GRID TRACK ---
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // Passes context up to parent viewport safely
                itemCount: controller.booksModel?.results?.length ?? 0, 
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Double-column list layout track
                  crossAxisSpacing: 14.w,
                  mainAxisSpacing: 16.h,
                  mainAxisExtent: 340.h, // Fixed layout card ceiling to ensure strict 1:1 row alignment
                ),
                itemBuilder: (context, index) {
                  final singleBook = controller.booksModel!.results![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 4,
                    ),
                    child: BookCard(
                      book: singleBook,
                      onViewDetails: () {
                        context.push(
                                  AppRoutes.bookDetails,
                                  extra: singleBook.slug,
                                );
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}