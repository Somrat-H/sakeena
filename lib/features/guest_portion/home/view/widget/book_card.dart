import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../model/books_model.dart';
// Ensure this points to your file destination

class BookCard extends StatelessWidget {
  final Results book;
  final VoidCallback? onViewDetails;

  const BookCard({
    super.key,
    required this.book,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    // Styling colors aligned with the brand guide assets
    const Color titleColor = Color(0xFF111827);
    const Color authorColor = Color(0xFF6B7280);
    const Color tealPrimary = Color(0xFF317773);
    const Color badgeBgColor = Color(0xFFE0E7FF);
    const Color badgeTextColor = Color(0xFF4338CA);

    // --- Format Badge Logic Determination ---
    String formatText = '';
    if ((book.hasPhysical ?? false) && (book.hasDigital ?? false)) {
      formatText = "BOTH";
    } else if (book.hasPhysical ?? false) {
      formatText = "PHYSICAL";
    } else if (book.hasDigital ?? false) {
      formatText = "DIGITAL";
    }

    // --- Dynamic Price Selection Logic ---
    // Prefers digital price string falling back to physical price safely
    String displayPrice = "0.00";
    if (book.hasDigital == true && book.digitalPrice != null) {
      displayPrice = book.digitalPrice!;
    } else if (book.hasPhysical == true && book.physicalPrice != null) {
      displayPrice = book.physicalPrice!;
    }

    return Container(
      width: 200, // Balanced fixed horizontal track layout footprint width
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // --- 1. Rounded Cover Image Frame ---
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: AspectRatio(
              aspectRatio: 1, // Matches the square graphic presentation scale perfectly
              child: CachedNetworkImage(
                imageUrl: book.coverImage!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[100],
                  child: const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2, color: tealPrimary),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: const Color(0xFFFCE8E6),
                  child: const Icon(Icons.book_outlined, color: Colors.grey, size: 40),
                ),
              ),
            ),
          ),

          // --- 2. Information Text Content Blocks ---
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Book Title
                Text(
                  book.title ?? 'Untitled Book',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: titleColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),

                // Author Subtitle Line
                Text(
                  book.author ?? 'Unknown Author',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: authorColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),

                // Format Available Capsule Badge
                if (formatText.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: badgeBgColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      formatText,
                      style: const TextStyle(
                        color: badgeTextColor,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                const SizedBox(height: 12),

                // Exact Layout Price String
                Text(
                  "\$ $displayPrice",
                  style: const TextStyle(
                    color: titleColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                // Outlined "View Details" Call Action Button
                SizedBox(
                  width: double.infinity,
                  height: 36,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: tealPrimary,
                      side: const BorderSide(color: tealPrimary, width: 1.2),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: onViewDetails,
                    child: const Text(
                      "View Details",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}