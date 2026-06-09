import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/features/guest_portion/home/model/faculty_details_model.dart';
import 'package:sakeena/features/guest_portion/home/provider/home_guest_provider.dart';

class FacultyDetailsScreen extends StatelessWidget {
  const FacultyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeGuestProvider>();

    final String name =
        "${provider.facultyDetailsModel.user!.firstName} ${provider.facultyDetailsModel.user!.firstName}";
    final String designation =
        provider.facultyDetailsModel.professionalTitle ??
        "Assistant Professor, Department of Linguistics";

    final String email =
        provider.facultyDetailsModel.user!.email ??
        "zaheer@sakeenainstitute.com";
    final String profileImage =
        provider.facultyDetailsModel.profilePicture ?? "";
    final String aboutText =
        provider.facultyDetailsModel.about ??
        "No professional biography provided yet.";

    // Extracted dynamic courses array list data
    // final List<dynamic> courses = details?.courses ?? [];

    // Global Screen Design Tokens
    const Color bgSurfaceBeige = Color(0xFFF7F5F0);
    const Color textPrimaryDark = Color(0xFF1E293B);
    const Color textSecondarySlate = Color(0xFF64748B);
    const Color tealBrandAccent = Color(0xFF2E6F6F);

    return Scaffold(
      backgroundColor: bgSurfaceBeige,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 140,
        leading: TextButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 14.0,
            color: textSecondarySlate,
          ),
          label: const Text(
            "Back to Faculty",
            style: TextStyle(
              color: textSecondarySlate,
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),

      body: provider.isDetailsLaoding
          ? const Center(child: CircularProgressIndicator(color: Colors.teal))
          // 2. Handle Empty or Missing Object Payload Bound Guards
          : (provider.facultyDetailsModel == null ||
                provider.facultyDetailsModel!.id == null)
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  "Profile data is currently unavailable. Please verify connection bounds and retry.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF64748B), fontSize: 14.0),
                ),
              ),
            )
          // 3. Render Profile Content flawlessly with normal scrolling physics
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- 2. HEADER PROFILE OVERVIEW CARD BLOCK ---
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Avatar Frame
                            CircleAvatar(
                              radius: 40.0,
                              backgroundColor: const Color(0xFFEDF2F7),
                              backgroundImage: profileImage.isNotEmpty
                                  ? NetworkImage(profileImage)
                                  : null,
                              child: profileImage.isEmpty
                                  ? const Icon(
                                      Icons.person_outline,
                                      size: 40.0,
                                      color: textSecondarySlate,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 16.0),
                            // Text Identifiers Layout Block
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: const TextStyle(
                                      color: textPrimaryDark,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    "$designation",
                                    style: const TextStyle(
                                      color: textSecondarySlate,
                                      fontSize: 13.0,
                                      height: 1.4,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  // Email Row Layout Line
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.mail_outline_rounded,
                                        size: 14.0,
                                        color: textSecondarySlate,
                                      ),
                                      const SizedBox(width: 6.0),
                                      Expanded(
                                        child: Text(
                                          email,
                                          style: const TextStyle(
                                            color: textSecondarySlate,
                                            fontSize: 12.5,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        // "View all Courses" Multi-Action Action Button
                        SizedBox(
                          width: double.infinity,
                          height: 44.0,
                          child: ElevatedButton(
                            onPressed:
                                () {}, // Action to auto-scroll down to courses section anchor
                            style: ElevatedButton.styleFrom(
                              backgroundColor: tealBrandAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              "View all Courses",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // --- 3. TWO-COLUMN SPLIT GRID (ABOUT & ACHIEVEMENTS LAYER) ---
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Column Left Block Frame: Professional Biography About Summary
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "About",
                                style: TextStyle(
                                  color: textPrimaryDark,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                aboutText,
                                style: const TextStyle(
                                  color: textPrimaryDark,
                                  fontSize: 13.0,
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                   provider
                                  .facultyDetailsModel
                                  .achievements!.isEmpty ? SizedBox() :    Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Achievements",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Html(
                              data: provider
                                  .facultyDetailsModel
                                  .achievements!
                                  .first!,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),

                  // --- 4. EDUCATION CARD DATA ROW OVERLAY ---
                  // --- FIX: Empty/Null Guard Check Grid Parameter ---
                  if (provider.facultyDetailsModel?.education != null &&
                      provider.facultyDetailsModel.education!.isNotEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Education",
                            style: TextStyle(
                              color: textPrimaryDark,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          ...((provider.facultyDetailsModel.education as List)
                              .map((edu) {
                                return Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFEBF6F6),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.school_outlined,
                                        color: tealBrandAccent,
                                        size: 20.0,
                                      ),
                                    ),
                                    const SizedBox(width: 12.0),
                                    Expanded(
                                      child: Text(
                                        edu.toString(),
                                        style: const TextStyle(
                                          color: textPrimaryDark,
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              })),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24.0),
                  ],

                  Text(
                    "Showing ${provider.facultyDetailsModel.courses!.length} courses",
                    style: const TextStyle(
                      color: textPrimaryDark,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // Dual Grid Layout Feed Setup Matrix Frame
                  provider.facultyDetailsModel.courses!.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            "No courses assigned to this faculty member yet.",
                            style: TextStyle(color: textSecondarySlate),
                          ),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16.0,
                                mainAxisSpacing: 16.0,
                                childAspectRatio:
                                    0.72, // Adjusts sizing layout footprints beautifully
                              ),
                          itemCount:
                              provider.facultyDetailsModel.courses!.length,
                          itemBuilder: (context, index) {
                            final course =
                                provider.facultyDetailsModel.courses![index];
                            return _buildCourseCard(
                              course,
                              textPrimaryDark,
                              textSecondarySlate,
                              tealBrandAccent,
                            );
                          },
                        ),
                ],
              ),
            ),
    );
  }

  // --- 6. COURSE CARD ITEM LAYOUT COMPONENT ---
  Widget _buildCourseCard(
    Courses course,
    Color textPrimary,
    Color textSecondary,
    Color accentColor,
  ) {
    final String title = course.title ?? "Course Title Reference Mapping";
    final String thumbnail = course.thumbnail ?? "";
    final int duration = course.durationInWeeks ?? 0;
    final int lessons = course.totalLessons ?? 0;
    final String price = course.price ?? "Free";

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Upper Visual Assets Image Space
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              color: const Color(0xFFEDF2F7),
              child: thumbnail.isNotEmpty
                  ? Image.network(thumbnail, fit: BoxFit.cover)
                  : const Icon(
                      Icons.menu_book_outlined,
                      size: 36.0,
                      color: Color(0xFFCBD5E1),
                    ),
            ),
          ),

          // Bottom Descriptions Metadata Stack Wrapper
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 4.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.book_outlined,
                            size: 12.0,
                            color: textSecondary,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            lessons.toString(),
                            style: TextStyle(
                              color: textSecondary,
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 12.0,
                            color: textSecondary,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            duration.toString(),
                            style: TextStyle(
                              color: textSecondary,
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  const Divider(color: Color(0xFFF1F5F9), height: 1.0),
                  const SizedBox(height: 8.0),
                  // Price Tag and Button Row block
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: accentColor,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: const Text(
                          "Explore",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
