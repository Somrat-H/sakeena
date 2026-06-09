import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:sakeena/features/guest_portion/home/provider/guest_navbar_provider.dart';
import 'package:sakeena/features/guest_portion/home/provider/home_guest_provider.dart';
import 'package:sakeena/features/guest_portion/home/view/widget/blog_card.dart';
import 'package:sakeena/features/guest_portion/home/view/widget/book_card.dart';
import 'package:sakeena/features/guest_portion/home/view/widget/bundle_card.dart';
import 'package:sakeena/features/guest_portion/home/view/widget/healing_list_widget.dart';
import 'package:sakeena/features/guest_portion/home/view/widget/plan_card.dart';
import 'package:sakeena/network/app_url/app_urls.dart';
import 'package:sakeena/route/go_route.dart';
import 'package:sakeena/route/teachers_routes.dart';
import 'package:sakeena/widgets/course_card.dart';
import 'package:sakeena/widgets/custom_app_bar.dart';
import 'widget/scroll_widget.dart';

class GuestHomePage extends StatelessWidget {
  const GuestHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeGuestProvider>();
    const Color tealColor = Color(0xFF2C7A7B);

    return Scaffold(
      backgroundColor: const Color(
        0xFFFDFBF7,
      ), // Warm light background matching the image mockup
      appBar: CustomAppBar(
         onTapCart: () => context.push(AppRoutes.cart),
      ),
      body: SafeArea(
        child: controller.isDoorsLoading
            ? const Center(child: CircularProgressIndicator(color: tealColor))
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HealingDoorsCarouselSection(doors: controller.doorsModel),

                    // ─── 1. COURSES SECTION HEADER ───────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Our Courses",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: tealColor,
                                  fontFamily: 'Serif',
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Navigate to see all courses action
                                  context.read<GuestNavProvider>().updateIndex(
                                    1,
                                  );

                                  // 2. Clear out any active search strings or filter blocks if you want the user to see everything
                                  // context.read<HomeGuestProvider>().getCourseByFilter("page", "1");

                                  // 3. Navigate directly to the target guest course route layout path
                                  context.go(AppRoutes.courseGuest);
                                },
                                child: const Text(
                                  "See All",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'Serif',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Explore our carefully curated selection of Islamic education and psychological guidance courses",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Courses Carousel List
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SizedBox(
                        height: 535,
                        child: ListView.builder(
                          controller: controller.courseScrollController,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.course.results?.length ?? 0,
                          itemBuilder: (context, index) {
                            final course = controller.course.results![index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                left: 16.0,
                                right: 4.0,
                              ),
                              child: SizedBox(
                                width: 350,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: CourseCardTeacher(
                                        imageUrl:
                                            course.thumbnail ??
                                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9ClZ-sWSzj1r9lMta57sD-X_zuxkbo_1kWw&s",
                                        category: course.category == null
                                            ? 'Uncategorized'
                                            : course.category!.name ??
                                                  'Uncategorized',
                                        title:
                                            course.title ?? 'Untitled Course',
                                        instructor:
                                            "${course.teacher?.user?.firstName ?? ''} ${course.teacher?.user?.lastName ?? ''}",
                                        lessons: course.totalLessons ?? 0,
                                        weeks: course.durationInWeeks ?? 0,
                                        totalHours:
                                            double.tryParse(
                                              course.totalHours ?? '0',
                                            ) ??
                                            0.0,
                                        hoursPerSession:
                                            double.tryParse(
                                              course.hoursPerSession ?? '0',
                                            ) ??
                                            0.0,
                                        price: course.price ?? "0.0",
                                        status:
                                            course.status ?? 'Uncategorized',
                                        onViewDetails: () async {
                                          if (course.id != null) {
                                            context.push(
                                              TeachersRoutes.courseDetail,
                                              extra: course.id,
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // Course Page controls
                    // Course Page controls updated to use the custom widget
                    CarouselNavigationButtons(
                      onLeftTap: () => controller.scroll(
                        false,
                        controller.courseScrollController,
                      ),
                      onRightTap: () => controller.scroll(
                        true,
                        controller.courseScrollController,
                      ),
                    ),
                    const SizedBox(height: 24),

                    SubscriptionPlanCard(
                      onGetPremiumPressed: () => context.push(AppRoutes.login),
                    ),
                    const SizedBox(height: 24),
                    HorizontalBundlesSection(
                      bundles: controller.bundleModel?.results,
                    ),
                    const SizedBox(height: 24),

                    // ─── 2. BOOKS SECTION HEADER ─────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Books & Publications",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: tealColor,
                                  fontFamily: 'Serif',
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.read<GuestNavProvider>().updateIndex(
                                    2,
                                  );

                                  context.go(AppRoutes.bookGuest);
                                },
                                child: const Text(
                                  "See All",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'Serif',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Expand your knowledge with our curated Islamic mental health library",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Books Carousel List
                    SizedBox(
                      height: 385,
                      child: ListView.builder(
                        controller: controller.bookScrollController,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount: controller.booksModel?.results?.length ?? 0,
                        itemBuilder: (context, index) {
                          final singleBook =
                              controller.booksModel!.results![index];
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

                    // Course Page controls updated to use the custom widget
                    CarouselNavigationButtons(
                      onLeftTap: () => controller.scroll(
                        false,
                        controller.bookScrollController,
                      ),
                      onRightTap: () => controller.scroll(
                        true,
                        controller.bookScrollController,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ─── 3. BLOG SECTION HEADER ──────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Our Blog",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: tealColor,
                                  fontFamily: 'Serif',
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Navigate to see all blogs action
                                  context.read<GuestNavProvider>().updateIndex(
                                    4,
                                  );

                                  context.push(AppRoutes.blogsGuest);
                                },
                                child: const Text(
                                  "See All",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'Serif',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Discover insights on Islamic psychology, mental health, and spiritual growth from our expert contributors",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Blog Carousel List
                    SizedBox(
                      height: 455,
                      child: ListView.builder(
                        controller: controller.blogScrollController,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: controller.blogModel?.results?.length ?? 0,
                        itemBuilder: (context, index) {
                          final article = controller.blogModel!.results![index];
                          return Padding(
                            padding: const EdgeInsets.only(
                              right: 16.0,
                              top: 4.0,
                              bottom: 4.0,
                            ),
                            child: BlogCard(
                              blog: article,
                              onReadMore: () {
                                context.push(
                                  AppRoutes.blogDetails,
                                  extra: article.slug,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    // Course Page controls updated to use the custom widget
                    CarouselNavigationButtons(
                      onLeftTap: () => controller.scroll(
                        false,
                        controller.blogScrollController,
                      ),
                      onRightTap: () => controller.scroll(
                        true,
                        controller.blogScrollController,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
      ),
    );
  }
}

/// Utility function to parse and format timestamp elements cleanly across layouts
String formatSessionDateTime(String isoString) {
  try {
    DateTime dateTime = DateTime.parse(isoString).toLocal();
    String formattedDate = DateFormat("d MMM y, HH:mm").format(dateTime);
    return formattedDate;
  } catch (e) {
    return isoString;
  }
}
