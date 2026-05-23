import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/features/teachers/content/controller/content_controller.dart';
import 'package:sakeena/route/teachers_routes.dart';
import 'package:sakeena/widgets/custom_app_bar.dart';
import 'package:shimmer/shimmer.dart';

class ContentHomePage extends StatelessWidget {
  const ContentHomePage({super.key});

  // Custom Colors from designs
  static const Color primaryTeal = Color(0xFF2D7A7B);
  static const Color accentGold = Color(0xFFD49726);
  static const Color lightGrayBg = Color(0xFFF3F4F6);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ContentController>();
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Upload Content",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: primaryTeal,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Add materials, videos, and resources for your courses",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 24),

              // Toggle Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 1. Title with Icon instead of a button
                  Row(
                    children: [
                      Icon(
                        Icons.article_outlined,
                        color: primaryTeal,
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "My Content",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),

                  // 2. Upload Button as an Icon Button or Small Outlined Button
                  OutlinedButton.icon(
                    onPressed: () {
                      context.push(TeachersRoutes.uploadNewContent);
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 18,
                      color: Colors.black54,
                    ),
                    label: const Text(
                      "Upload",
                      style: TextStyle(color: Colors.black54, fontSize: 13),
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: BorderSide(color: Colors.grey.shade300),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Content Cards List
              controller.isLoading
                  ? _buildShimmerCard()
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.contentResponse.results!.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        final content =
                            controller.contentResponse.results![index];
                        return InkWell(
                          onTap: () => context.push(
                            TeachersRoutes.contentDetails,
                            extra: content.slug,
                          ),
                          child: _buildContentCard(
                            author:
                                content.authorDetail!.fullName ??
                                "Unknown Author",
                            title: content.title ?? "Untitled",
                            subTitle:
                                content.excerpt ?? "No excerpt available.",
                            publishedDate: content.publishedAt != null
                                ? DateTime.parse(
                                    content.publishedAt!,
                                  ).toLocal().toString().split(' ')[0]
                                : "Unknown date",
                            readingTime: content.readingTime != null
                                ? content.readingTime.toString()
                                : "N/A",
                            category: content.category?.name ?? "Uncategorized",

                            imageUrl: content.coverImage == null
                                ? "https://upload.wikimedia.org/wikipedia/commons/d/d1/Image_not_available.png"
                                : content.coverImage!,
                            status: content.status == "published"
                                ? "Published"
                                : "Pending",
                            statusColor: content.status == "published"
                                ? Colors.green
                                : Colors.orange,
                          ),
                        );
                      },
                    ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentCard({
    required String imageUrl,
    required String status,
    required Color statusColor,
    required String title,
    required String subTitle,
    required String publishedDate,
    required String readingTime,
    required String category,
    required String author,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/d/d1/Image_not_available.png",
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Meta Info
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 4),
                    Text(
                      publishedDate,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(width: 12),
                    Icon(Icons.access_time, size: 14, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      "$readingTime min read",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Tag
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: primaryTeal.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: primaryTeal,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subTitle,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),

                // Author and Action
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 16,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 4),
                        Text(
                          author,
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: statusColor,
                        elevation: 0,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                      ),
                      child: Text(
                        status,
                        style: const TextStyle(color: Colors.white),
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

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Shimmer
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Meta Info Shimmer (Date & Time)
                  Row(
                    children: [
                      Container(width: 80, height: 12, color: Colors.white),
                      const SizedBox(width: 12),
                      Container(width: 60, height: 12, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Category Tag Shimmer
                  Container(
                    width: 70,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Title Shimmer (Two lines)
                  Container(
                    width: double.infinity,
                    height: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 6),
                  Container(width: 150, height: 16, color: Colors.white),
                  const SizedBox(height: 12),

                  // Subtitle Shimmer
                  Container(
                    width: double.infinity,
                    height: 12,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),

                  // Author & Button Shimmer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(width: 100, height: 14, color: Colors.white),
                      Container(
                        width: 90,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ],
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
