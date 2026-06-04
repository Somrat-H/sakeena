import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import '../../model/blog_model.dart';
// Make sure this matches your data model file location

class BlogCard extends StatelessWidget {
  final Results blog;
  final VoidCallback? onReadMore;

  const BlogCard({
    super.key,
    required this.blog,
    this.onReadMore,
  });

  @override
  Widget build(BuildContext context) {
    // Exact UI color specifications matching your style guide
    const Color titleColor = Color(0xFF111827);
    const Color bodyTextColor = Color(0xFF4B5563);
    const Color grayMetaColor = Color(0xFF6B7280);
    const Color tealPrimary = Color(0xFF2C7A7B);
    const Color chipBgColor = Color(0xFFF3F4F6);

    // --- Dynamic Date Parsing Execution ---
    String formattedDate = 'N/A';
    if (blog.publishedAt != null || blog.createdAt != null) {
      try {
        final rawDate = blog.publishedAt ?? blog.createdAt!;
        DateTime parsedDate = DateTime.parse(rawDate).toLocal();
        formattedDate = DateFormat('MMM dd, yyyy').format(parsedDate);
      } catch (_) {}
    }

    return Container(
      width: 350, // Perfect sizing for list layouts
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // --- 1. Top Cover Image Banner Block ---
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: AspectRatio(
              aspectRatio: 16 / 9, // Wide landscape presentation ratio
              child: CachedNetworkImage(
                imageUrl: blog.coverImage ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[100],
                  child: const Center(
                    child: CircularProgressIndicator(color: tealPrimary, strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: const Color(0xFFE2E8F0),
                  child: const Icon(Icons.image_outlined, color: Colors.grey, size: 40),
                ),
              ),
            ),
          ),

          // --- 2. Descriptive Body Text Layout Context ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Metadata Row: Calendar Date & Reading Duration
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined, size: 14, color: grayMetaColor),
                    const SizedBox(width: 6),
                    Text(
                      formattedDate,
                      style: const TextStyle(color: grayMetaColor, fontSize: 12),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.access_time_outlined, size: 14, color: grayMetaColor),
                    const SizedBox(width: 6),
                    Text(
                      "${blog.readingTime ?? 5} min read", // Dynamic fallback tracking minutes
                      style: const TextStyle(color: grayMetaColor, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Category Capsule Tag Badge
                if (blog.category?.name != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: chipBgColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      blog.category!.name!,
                      style: const TextStyle(
                        color: tealPrimary,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],

                // Main Article Heading Title
                Text(
                  blog.title ?? 'Untitled Post',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: titleColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 8),

                // Excerpt Brief Block
                Text(
                  blog.excerpt ?? blog.content ?? '',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: bodyTextColor,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                
                const Divider(height: 1, color: Color(0xFFE5E7EB)),
                const SizedBox(height: 12),

                // --- 3. Footer Control Navigation Track ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Author Association Profile
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: chipBgColor,
                          backgroundImage: blog.authorDetail?.profilePicture != null
                              ? NetworkImage(blog.authorDetail!.profilePicture!)
                              : null,
                          child: blog.authorDetail?.profilePicture == null
                              ? const Icon(Icons.person_outline, size: 12, color: tealPrimary)
                              : null,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          blog.authorDetail?.fullName ?? 'Sakeena Institute',
                          style: const TextStyle(
                            color: titleColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    // "Read More" Interactive Arrow Link
                    InkWell(
                      onTap: onReadMore,
                      borderRadius: BorderRadius.circular(4),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Read More",
                              style: TextStyle(
                                color: tealPrimary,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.arrow_forward, size: 14, color: tealPrimary),
                          ],
                        ),
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
}