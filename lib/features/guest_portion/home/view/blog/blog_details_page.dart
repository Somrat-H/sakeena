import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/features/guest_portion/home/provider/home_guest_provider.dart';
import 'package:sakeena/features/guest_portion/home/view/blog/widget/blog_details_shimmer.dart';
import 'package:sakeena/features/guest_portion/home/view/widget/blog_card.dart';
import 'package:sakeena/route/go_route.dart';


class BlogDetailsScreen extends StatelessWidget {
  final String slug;

  const BlogDetailsScreen({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeGuestProvider>();
    const Color tealColor = Color(0xFF2C7A7B);
    const Color warmBackground = Color(0xFFFDFBF7);

    // If loading flag is true, display the shimmer layout immediately
    if (provider.isDetailsLaoding) {
      return const Scaffold(
        backgroundColor: warmBackground,
        body: SafeArea(child: BlogDetailsShimmer()),
      );
    }

    final blog = provider.blogDetailsModel;

    // Date Format Parser conversion logic
    String formattedDate = "N/A";
    if (blog.publishedAt != null) {
      try {
        DateTime parsedDate = DateTime.parse(blog.publishedAt!);
        formattedDate = DateFormat("MMMM d, yyyy").format(parsedDate);
      } catch (_) {
        formattedDate = blog.publishedAt!;
      }
    }

    return Scaffold(
      backgroundColor: warmBackground,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: CircleAvatar(
          backgroundColor: Colors.black.withOpacity(0.4),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── STACKED BACKGROUND BANNER LAYER (image_014bc0.jpg) ──────────
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 250.h,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Color(0xFF2A4D4E)),
                  child: blog.coverImage != null && blog.coverImage!.isNotEmpty
                      ? Image.network(blog.coverImage!, fit: BoxFit.fill)
                      : const SizedBox(),
                ),
                // Layered Card Card Container matching design format
                Positioned(
                  top: 180.h,
                  left: 20.w,
                  right: 20.w,
                  child: Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          blog.title ?? "When the World Pauses: The Hidden Gift of Salah",
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F172A),
                            height: 1.3,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 18.r,
                              backgroundColor: Colors.grey.shade200,
                              backgroundImage: blog.authorDetail?.profilePicture != null
                                  ? NetworkImage(blog.authorDetail!.profilePicture!)
                                  : null,
                              child: blog.authorDetail?.profilePicture == null
                                  ? Icon(Icons.person, size: 18.sp, color: Colors.grey)
                                  : null,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    blog.authorDetail?.fullName ?? "Sakeena Institute",
                                    style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1A202C)),
                                  ),
                                  Text(
                                    blog.authorDetail?.professionalTitle ?? "Sakeena Press",
                                    style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade500),
                                  ),
                                ],
                              ),
                            ),
                            if (blog.category != null)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: tealColor.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Text(
                                  blog.category!.name!.toUpperCase(),
                                  style: TextStyle(color: tealColor, fontSize: 10.sp, fontWeight: FontWeight.bold),
                                ),
                              ),
                          ],
                        ),
                        const Divider(height: 24, color: Color(0xFFE2E8F0)),
                        Row(
                          children: [
                            Icon(Icons.person_outline, size: 14.sp, color: Colors.grey),
                            SizedBox(width: 4.w),
                            Text(blog.authorDetail?.fullName ?? "Author", style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade600)),
                            SizedBox(width: 14.w),
                            Icon(Icons.calendar_today_outlined, size: 14.sp, color: Colors.grey),
                            SizedBox(width: 4.w),
                            Text(formattedDate, style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade600)),
                            SizedBox(width: 14.w),
                            Icon(Icons.access_time, size: 14.sp, color: Colors.grey),
                            SizedBox(width: 4.w),
                            Text("${blog.readingTime ?? 5} min read", style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade600)),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),

            // Spacing element block offsets the positioned card body height overlay safely
            SizedBox(height: 150.h),

            // ─── TAG HORIZONTAL LIST SECTION ────────────────────────────────
            if (blog.tags != null && blog.tags!.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: blog.tags!.map((tag) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(fontSize: 11.sp, color: const Color(0xFF4A5568)),
                    ),
                  )).toList(),
                ),
              ),

            SizedBox(height: 20.h),

            // ─── HTML RAW CONTENT BODY RENDERING ────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Html(
                data: blog.content ?? "<p>No written copy is found for this blog node content structure.</p>",
                
              ),
            ),
            SizedBox(height: 40.h),
            // Text("Related Airtcles"),
            // SizedBox(
            //           height: 455,
            //           child: ListView.builder(
            //             controller: provider.blogScrollController,
            //             scrollDirection: Axis.horizontal,
            //             physics: const BouncingScrollPhysics(),
            //             padding: const EdgeInsets.symmetric(horizontal: 16),
            //             itemCount: blog.relatedBlogs!.length,
            //             itemBuilder: (context, index) {
            //               final article = provider.blogModel!.results![index];
            //               return Padding(
            //                 padding: const EdgeInsets.only(
            //                   right: 16.0,
            //                   top: 4.0,
            //                   bottom: 4.0,
            //                 ),
            //                 child: BlogCard(
            //                   blog: article,
            //                   onReadMore: () {
            //                     context.push(
            //                       AppRoutes.blogDetails,
            //                       extra: article.slug,
            //                     );
            //                   },
            //                 ),
            //               );
            //             },
            //           ),
            //         ),
          ],
        ),
      ),
    );
  }
}