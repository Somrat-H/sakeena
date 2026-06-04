import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../model/faculty_model.dart';


class FacultyCard extends StatelessWidget {
  final Results faculty;
  final VoidCallback? onViewProfile;

  const FacultyCard({
    super.key,
    required this.faculty,
    this.onViewProfile,
  });

  @override
  Widget build(BuildContext context) {
    // Brand color guidelines matched to your design assets
    const Color titleColor = Color(0xFF111827);
    const Color subTitleColor = Color(0xFF4B5563);
    const Color bodyTextColor = Color(0xFF6B7280);
    const Color tealPrimary = Color(0xFF317773); // Custom brand teal
    const Color chipBgColor = Color(0xFFF3F4F6);

    // Combine First Name and Last Name safely
    final String fullName = "${faculty.user?.firstName ?? ''} ${faculty.user?.lastName ?? ''}".trim();
    final String displayName = fullName.isNotEmpty ? fullName : "Faculty Member";

    return Container(
      width: 240, // Perfect card horizontal track width layout budget
      height: 380, // Enforces strict alignment limits for horizontal rows
      padding: const EdgeInsets.all(16.0),
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
        children: [
          // --- 1. UPPER VARIABLE CONTENT AREA ---
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  // Centered Circular Profile Avatar
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(48),
                      child: CachedNetworkImage(
                        imageUrl: faculty.profilePicture ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJhvWpQrh3nIxmjLBQSyH5uu7OKpprR2b4-g&s",
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: chipBgColor,
                          child: const Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, color: tealPrimary),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: chipBgColor,
                          child: const Icon(Icons.person_outline, size: 40, color: bodyTextColor),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Faculty Full Name Header Text
                  Text(
                    displayName,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: titleColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Professional Title Subtitle Line
                  Text(
                    faculty.professionalTitle ?? 'Faculty Member',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: subTitleColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // About Abstract Block Text
                  Text(
                    faculty.about ?? '',
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: bodyTextColor,
                      fontSize: 11,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Education Degree Capsule Tag
                  if (faculty.education != null && faculty.education!.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: chipBgColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black.withOpacity(0.05), width: 0.5),
                      ),
                      child: Text(
                        faculty.education!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: subTitleColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // --- 2. FIXED BOTTOM ALIGNMENT BLOCK ---
          const SizedBox(height: 12),
          
          // "View Profile" Outlined Action Button
          SizedBox(
            width: double.infinity,
            height: 38,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: tealPrimary,
                side: const BorderSide(color: Color(0xFFE5E7EB), width: 1.2), // Light layout stroke border
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
              ),
              onPressed: onViewProfile,
              child: const Text(
                "View Profile",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}