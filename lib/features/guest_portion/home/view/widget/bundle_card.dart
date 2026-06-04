import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sakeena/features/guest_portion/home/model/bundle_model.dart';
import 'package:sakeena/features/guest_portion/home/view/widget/bundle_details_dialog.dart';
import 'package:sakeena/route/go_route.dart';

class BundleCard extends StatelessWidget {
  final Results bundle; 
  final VoidCallback? onViewDetails;

  const BundleCard({
    super.key,
    required this.bundle,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    // Brand design styling guidelines
    const Color titleColor = Color(0xFF111827);
    const Color descColor = Color(0xFF4B5563);
    const Color tealPrimary = Color(0xFF317773); // Synchronized brand teal
    const Color greenAccent = Color(0xFF10B981); // Modern emerald green
    const Color grayLightText = Color(0xFF9CA3AF);

    // Dynamic Discount Math Logic
    int savePercent = 0;
    final double currentPrice = double.tryParse(bundle.price ?? '0') ?? 0.0;
    final double originalPrice = (bundle.originalPrice ?? 0).toDouble();
    
    if (originalPrice > 0 && currentPrice < originalPrice) {
      savePercent = (((originalPrice - currentPrice) / originalPrice) * 100).round();
    }

    // Explicit Date String Parsing Sequence
    String formattedDate = 'N/A';
    if (bundle.createdAt != null) {
      try {
        DateTime parsedDate = DateTime.parse(bundle.createdAt!).toLocal();
        formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
      } catch (_) {}
    }

    final coursesList = bundle.coursesDetail ?? [];

    return Container(
      width: 340,
      // Fixed layout ceiling calculation height ensures all horizontal tracks match 1:1
      height: 480, 
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- A. UPPER SCROLLABLE/FLEXIBLE CONTENT AREA ---
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Bundle Display Title Header ---
                  Text(
                    bundle.name ?? 'Course Bundle',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: titleColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // --- Description Body Content ---
                  Text(
                    bundle.description ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: descColor,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // --- Pricing Layer Track ---
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        "\$${bundle.price ?? '0.00'}",
                        style: const TextStyle(
                          color: titleColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (originalPrice > 0) ...[
                        const SizedBox(width: 8),
                        Text(
                          "\$${originalPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                            color: grayLightText,
                            fontSize: 13,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),

                  // --- Interactive Save Percentage Badges ---
                  Row(
                    children: [
                      if (savePercent > 0) ...[
                        Text(
                          "Save $savePercent%",
                          style: const TextStyle(
                            color: greenAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "  •  ",
                          style: TextStyle(color: grayLightText.withOpacity(0.6)),
                        ),
                      ],
                      const Text(
                        "One-time lifetime access",
                        style: TextStyle(
                          color: descColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // --- Inner Nested Courses Metric Counter ---
                  Text(
                    "Includes ${coursesList.length} Courses:",
                    style: const TextStyle(
                      color: titleColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // --- Dynamic Type-Safe Course Detail Checklist Track ---
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: coursesList.length,
                    itemBuilder: (context, index) {
                      final course = coursesList[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 3.0),
                              child: Icon(
                                Icons.check,
                                color: tealPrimary,
                                size: 14,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    course.title ?? 'Untitled Course',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: titleColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    course.category?.name ?? 'Uncategorized',
                                    style: const TextStyle(
                                      color: grayLightText,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // --- B. FIXED BOTTOM BUTTON & FOOTER BLOCK ---
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFE5E7EB)),
          const SizedBox(height: 12),

          // --- Bottom Analytics Timeline Matrix ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Sales: 3", 
                style: TextStyle(color: descColor, fontSize: 11),
              ),
              Text(
                "Created: $formattedDate",
                style: const TextStyle(color: descColor, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // --- Core Elevated Redirection Action Button ---
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: tealPrimary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              onPressed: onViewDetails,
              child: const Text(
                "View Details",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Make sure to import your BundleCard widget path

class HorizontalBundlesSection extends StatelessWidget {
  final List<Results>? bundles;

  const HorizontalBundlesSection({
    super.key,
    required this.bundles,
  });

  @override
  Widget build(BuildContext context) {
    // Return an empty widget if the backend returns null or an empty list
    if (bundles == null || bundles!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Optional Section Header Title
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            "Featured Bundles",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
            ),
          ),
        ),

        // Horizontal Scroll Track Box
        SizedBox(
          // Set a safe height budget to comfortably accommodate your dynamic card content 
          // and checklist lines without creating vertical overflow constraints.
          height: 580, 
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // Enables horizontal slider scrolling track
            physics: const BouncingScrollPhysics(), // Premium smooth bounce scrolling feel
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: bundles!.length,
            itemBuilder: (context, index) {
              final currentBundle = bundles![index];

              return Padding(
                // Adds layout separation between cards so they do not touch while scrolling
                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
                child: BundleCard(
                  bundle: currentBundle,
                  onViewDetails: () {
                    // Navigate to dynamic details page layout using bundle id
                    if (currentBundle.id != null) {
                      BundleDetailsDialog.show(context, currentBundle.id ?? 0);
                    }
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}