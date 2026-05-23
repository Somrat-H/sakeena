import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/features/teachers/content/controller/content_controller.dart';
import 'package:sakeena/features/teachers/content/upload_content/widget/content_details_shimmer.dart';
import 'package:sakeena/features/teachers/content/model/content_details_response.dart';

class BlogDetailsScreen extends StatelessWidget {
  final String slug;
  const BlogDetailsScreen({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    const Color primaryTeal = Color(0xFF00796B);
    // Use select to avoid unnecessary rebuilds if other parts of the controller change
    final controller = context.read<ContentController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder(
        future: controller.getContentDetails(slug),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const BlogDetailsShimmer();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Reference the data from the controller
          final data = controller.contentDetailsResponse;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // 1. Background Banner Image
                    Container(
                      height: 220,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(data.coverImage ?? 'https://via.placeholder.com/800x400'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // 2. Overlapping Author Card
                    Positioned(
                      top: 150,
                      left: 20,
                      right: 20,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F9F8),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.title ?? "No Title",
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            _buildAuthorRow(data, primaryTeal),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 130), // Adjusted for the overlap

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 4. Blog Body Content
                      HtmlWidget(
                        data.content ?? "<p>No content available.</p>",
                        textStyle: const TextStyle(fontSize: 16, height: 1.6),
                      ),
                      const SizedBox(height: 20),

                      // Tags
                      if (data.tags != null && data.tags!.isNotEmpty)
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: data.tags!.map((tag) => _buildTag("#$tag")).toList(),
                        ),

                      const SizedBox(height: 40),
                      
                      // Related Articles Section
                      if (data.relatedBlogs != null && data.relatedBlogs!.isNotEmpty) ...[
                        const Text(
                          "Related Articles",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.relatedBlogs!.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final related = data.relatedBlogs![index];
                            return _buildRelatedArticleCard(related);
                          },
                        ),
                      ],
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAuthorRow(ContentDetailsResponse data, Color primaryColor) {
    final author = data.authorDetail;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(author?.profilePicture ?? 'https://via.placeholder.com/150'),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                author?.fullName ?? "Anonymous",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                author?.professionalTitle ?? "Contributor",
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _iconInfo(Icons.calendar_today_outlined, data.publishedAt ?? "N/A"),
                    const SizedBox(width: 12),
                    _iconInfo(Icons.access_time, "${data.readingTime ?? 0} min read"),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              if (data.category != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    data.category?.name ?? "",
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _iconInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
    );
  }

  Widget _buildRelatedArticleCard(RelatedBlogs blog) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              blog.coverImage ?? 'https://upload.wikimedia.org/wikipedia/commons/d/d1/Image_not_available.png',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 80,
                height: 80,
                color: Colors.grey.shade200,
                child: const Icon(Icons.broken_image, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  "${blog.readingTime} min read • ${blog.category?.name}",
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}