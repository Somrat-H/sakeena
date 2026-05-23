import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BlogDetailsShimmer extends StatelessWidget {
  const BlogDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                // 1. Background Banner Image Skeleton
                Container(
                  height: 220,
                  width: double.infinity,
                  color: Colors.white,
                ),

                // 2. Overlapping Author Card Skeleton
                Positioned(
                  top: 150,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title Shimmer
                        Container(width: 120, height: 24, color: Colors.white),
                        const SizedBox(height: 16),
                        // Author Row Shimmer
                        _buildShimmerAuthorRow(),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // 3. Match the spacing of your actual UI
            const SizedBox(height: 120),

            // 4. Content Body Skeleton
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Paragraph Lines
                  Container(width: double.infinity, height: 16, color: Colors.white),
                  const SizedBox(height: 8),
                  Container(width: double.infinity, height: 16, color: Colors.white),
                  const SizedBox(height: 8),
                  Container(width: 200, height: 16, color: Colors.white),
                  
                  const SizedBox(height: 20),

                  // Tag Shimmers
                  Row(
                    children: [
                      Container(width: 60, height: 25, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8))),
                      const SizedBox(width: 8),
                      Container(width: 60, height: 25, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8))),
                    ],
                  ),

                  const SizedBox(height: 40),
                  // Related Articles Header
                  Container(width: 150, height: 20, color: Colors.white),
                  const SizedBox(height: 20),
                  
                  // Related Article Card Skeleton
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerAuthorRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(radius: 25, backgroundColor: Colors.white),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: 140, height: 14, color: Colors.white),
              const SizedBox(height: 6),
              Container(width: 100, height: 12, color: Colors.white),
              const SizedBox(height: 12),
              // Meta info icons/text
              Row(
                children: [
                  Container(width: 50, height: 10, color: Colors.white),
                  const SizedBox(width: 12),
                  Container(width: 50, height: 10, color: Colors.white),
                ],
              ),
              const SizedBox(height: 12),
              // Career Advice Tag
              Container(width: 80, height: 18, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
            ],
          ),
        ),
      ],
    );
  }
}