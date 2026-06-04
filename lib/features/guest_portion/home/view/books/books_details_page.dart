import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:sakeena/features/guest_portion/home/provider/home_guest_provider.dart';
import 'package:sakeena/features/guest_portion/home/view/widget/book_details_shimmer.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sakeena/route/go_route.dart';

class BookDetailsScreen extends StatefulWidget {
  final String slug;

  const BookDetailsScreen({super.key, required this.slug});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  // Local state to keep track of format selection ("digital" vs "physical")
  String selectedFormat = "physical";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeGuestProvider>().getBookDetails(widget.slug);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeGuestProvider>();
    const Color tealColor = Color(0xFF2C7A7B);
    const Color warmBackground = Color(0xFFFDFBF7);

    return Scaffold(
      backgroundColor: warmBackground,
      appBar: AppBar(
        backgroundColor: warmBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Back to Books",
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: provider.isDetailsLaoding
            ? const BookDetailsShimmer()
            : _buildBookContent(provider, tealColor),
      ),
    );
  }

  Widget _buildBookContent(HomeGuestProvider provider, Color tealColor) {
    final book = provider.bookDetailsModel;

    // Determine target prices safely
    final String displayPrice = selectedFormat == "physical"
        ? (book.physicalPrice ?? "0.00")
        : (book.digitalPrice ?? "0.00");

    // Format target published dates natively
    String formattedDate = "N/A";
    if (book.publishedDate != null) {
      try {
        DateTime parsedDate = DateTime.parse(book.publishedDate!);
        formattedDate = DateFormat("MMMM yyyy").format(parsedDate);
      } catch (_) {
        formattedDate = book.publishedDate!;
      }
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── COVER & TOP INFO ROW ───────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book Cover Layout Image Section
              Container(
                width: 125.w,
                height: 180.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: book.coverImage != null && book.coverImage!.isNotEmpty
                      ? Image.network(book.coverImage!, fit: BoxFit.cover)
                      : Container(
                          color: Colors.grey.shade300,
                          child: const Icon(
                            Icons.book,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                ),
              ),
              SizedBox(width: 20.w),
              // Meta Texts Column Block
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: tealColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        book.stockCount! > 0 ? "Available Now" : "Stock Out",
                        style: TextStyle(
                          color: tealColor,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      book.title ?? "Untitled Book",
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A202C),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10.r,
                          backgroundColor: tealColor,
                          child: Text(
                            (book.author ?? "J")[0].toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          book.author ?? "Unknown Author",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    if (book.category != null)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(color: tealColor.withOpacity(0.4)),
                        ),
                        child: Text(
                          book.category!.name ?? "",
                          style: TextStyle(color: tealColor, fontSize: 11.sp),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // ─── READ SAMPLE BUTTON WITH GO_ROUTER ───────────────────────────
          OutlinedButton.icon(
            onPressed: () {
              if (book.sampleFile != null && book.sampleFile!.isNotEmpty) {
                context.pushNamed(
                  AppRoutes.onlinePdfView,
                  queryParameters: {
                    'url': book.sampleFile!,
                    'title': book.title ?? "Book Sample",
                  },
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "No digital sample file available for this book.",
                    ),
                  ),
                );
              }
            },
            icon: const Icon(Icons.menu_book, size: 16),
            label: const Text("Read Sample"),
            style: OutlinedButton.styleFrom(
              minimumSize: Size(double.infinity, 42.h),
              foregroundColor: tealColor,
              side: BorderSide(color: tealColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.r),
              ),
            ),
          ),
          SizedBox(height: 8.h),

          // ─── WATCH VIDEO BUTTON WITH GO_ROUTER ───────────────────────────
          OutlinedButton.icon(
            onPressed: () {
              if (book.videoUrl != null && book.videoUrl!.isNotEmpty) {
                context.pushNamed(
                  AppRoutes.onlineVideoView,
                  queryParameters: {
                    'url': book.videoUrl!,
                    'title': book.title ?? "Video Preview",
                  },
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("No video preview available for this book."),
                  ),
                );
              }
            },
            icon: const Icon(Icons.play_circle_outline, size: 16),
            label: const Text("Watch Video"),
            style: OutlinedButton.styleFrom(
              minimumSize: Size(double.infinity, 42.h),
              foregroundColor: tealColor,
              side: BorderSide(color: tealColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.r),
              ),
            ),
          ),

          SizedBox(height: 24.h),

          // ─── BOOK METADATA SPECIFICATIONS SPEC SHEET ─────────────────────
          Text(
            "Book Details",
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10.h),
          _buildSpecRow("Language", book.language ?? "English"),
          _buildSpecRow("Pages", "${book.pageCount ?? 'N/A'}"),
          _buildSpecRow(
            "Format",
            book.hasPhysical == true && book.hasDigital == true
                ? "Digital & Physical"
                : (book.hasPhysical == true ? "Physical" : "Digital"),
          ),
          _buildSpecRow("Publisher", book.publisher ?? "N/A"),
          _buildSpecRow("Published", formattedDate),
          _buildSpecRow("ISBN", book.isbn ?? "N/A"),

          SizedBox(height: 24.h),

          // ─── ABOUT / DESCRIPTION INTRODUCTION SECTION ────────────────────
          Text(
            "About This Book",
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          SizedBox(height: 6.h),
          Html(
            data:
                book.description ??
                "<p>No summary details are loaded for this publication asset.</p>",
          ),
          SizedBox(height: 32.h),
          Center(
            child: Text(
              "Choose Your Format",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A202C),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // ─── FORMAT SELECTION CARDS (DIGITAL VS PHYSICAL) ────────────────
          Row(
            children: [
              // Digital Card
              if (book.hasDigital ?? true)
                Expanded(
                  child: _buildFormatCard(
                    title: "Digital Edition",
                    price: "\$${book.digitalPrice ?? '0'}",
                    icon: Icons.file_download_outlined,
                    bullets: [
                      "Instant download",
                      "PDF, EPUB, MOBI",
                      "Bonus audio version",
                    ],
                    isSelected: selectedFormat == "digital",
                    onTap: () => setState(() => selectedFormat = "digital"),
                    tealColor: tealColor,
                  ),
                ),
              if (book.hasDigital == true && book.hasPhysical == true)
                SizedBox(width: 12.w),
              // Physical Card
              if (book.hasPhysical ?? true)
                Expanded(
                  child: _buildFormatCard(
                    title: "Physical Book",
                    price: "\$${book.physicalPrice ?? '0'}",
                    icon: Icons.menu_book_outlined,
                    bullets: [
                      "Premium paperback",
                      "Ships in 2-3 days",
                      "${book.stockCount ?? 0} in stock",
                    ],
                    isSelected: selectedFormat == "physical",
                    onTap: () => setState(() => selectedFormat = "physical"),
                    tealColor: tealColor,
                  ),
                ),
            ],
          ),

          SizedBox(height: 24.h),

          // ─── TOTAL PRICE AND ADD TO CART BOTTOM BAR ─────────────────────
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Price",
                          style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          "\$$displayPrice",
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: tealColor,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.shopping_cart,
                        size: 16,
                        color: Colors.white,
                      ),
                      label: const Text("Add to Cart"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tealColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 12.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 24, color: Color(0xFFE2E8F0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildFooterBadge(
                      Icons.gpp_good_outlined,
                      "Secure Payment",
                    ),
                    _buildFooterBadge(
                      Icons.local_shipping_outlined,
                      "Fast Delivery",
                    ),
                    _buildFooterBadge(
                      Icons.assignment_return_outlined,
                      "Easy Refunds",
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Customer Reviews",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(height: 12.h),

                // ─── CUSTOMER RATING SUMMARY ROW (From image_01c3a2.png) ───────────
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Row of stars matching the unrated placeholder state
                    Row(
                      children: List.generate(
                        5,
                        (index) => Padding(
                          padding: EdgeInsets.only(right: 4.w),
                          child: Icon(
                            Icons.star_border_rounded,
                            size: 20.sp,
                            color: const Color(
                              0xFFCBD5E1,
                            ), // Soft layout grey-blue
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),

                    // Bold numerical average rating
                    Text(
                      "0.0",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F172A), // Deep near-black slate
                      ),
                    ),
                    SizedBox(width: 6.w),

                    // Total review count anchor string
                    Text(
                      "(0 reviews)",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF64748B), // Muted grey text
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

  Widget _buildSpecRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              label,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2D3748),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormatCard({
    required String title,
    required String price,
    required IconData icon,
    required List<String> bullets,
    required bool isSelected,
    required VoidCallback onTap,
    required Color tealColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? tealColor : const Color(0xFFE2E8F0),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: tealColor, size: 28.sp),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2D3748),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              price,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: tealColor,
              ),
            ),
            SizedBox(height: 12.h),
            ...bullets.map(
              (b) => Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, size: 12.sp, color: tealColor),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        b,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterBadge(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 14.sp, color: Colors.grey.shade500),
        SizedBox(width: 4.w),
        Text(
          label,
          style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}
