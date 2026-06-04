import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/features/guest_portion/home/provider/home_guest_provider.dart';

class BundleDetailsDialog extends StatefulWidget {
  final int bundleId;

  const BundleDetailsDialog({super.key, required this.bundleId});

  static void show(BuildContext context, int bundleId) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => BundleDetailsDialog(bundleId: bundleId),
    );
  }

  @override
  State<BundleDetailsDialog> createState() => _BundleDetailsDialogState();
}

class _BundleDetailsDialogState extends State<BundleDetailsDialog> {
  @override
  void initState() {
    super.initState();
    // Fetch data asynchronously right as the dialog initiates
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeGuestProvider>().getBundleDetails(widget.bundleId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeGuestProvider>();
    const tealColor = Color(0xFF2C7A7B);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      clipBehavior: Clip.antiAlias,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 250),
        child: provider.isDetailsLaoding
            ? Container(
                height: 200.h,
                color: Colors.white,
                child: const Center(child: CircularProgressIndicator(color: tealColor)),
              )
            : _buildDialogContent(context, provider, tealColor),
      ),
    );
  }

  Widget _buildDialogContent(BuildContext context, HomeGuestProvider provider, Color tealColor) {
    final detail = provider.bundleDetailsModel;
    
    // Parse values safely to calculate matching savings
    final double bundlePrice = double.tryParse(detail.price ?? '0') ?? 0.0;
    final double originalPrice = (detail.originalPrice ?? 0).toDouble();
    final double savings = originalPrice - bundlePrice;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ─── HEADER BANNER SECTION ──────────────────────────────────────────
          Container(
            color: tealColor,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detail.name ?? "The Healing Journey Bundle",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  detail.description ?? "A carefully curated collection of transformational experiences designed to support spiritual and mental well-being.",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 12.sp,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          // ─── MAIN CONTENT BODY ──────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // List out dynamic courses included inside the Bundle payload
                if (detail.coursesDetail != null && detail.coursesDetail!.isNotEmpty)
                  ...detail.coursesDetail!.map((course) => Padding(
                        padding: EdgeInsets.only(bottom:  10.h),
                        child: Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Mock thumbnail container representation matching design visual
                              Container(
                                width: 44.w,
                                height: 44.h,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF718096).withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      course.title ?? 'Untitled Course',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF1A202C),
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      course.category?.name ?? 'General',
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "\$${course.price ?? '0.00'}",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF4A5568),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                else
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: const Text("No courses available inside this bundle package.", textAlign: TextAlign.center),
                  ),

                SizedBox(height: 14.h),

                // ─── BUNDLE PREVIEW CARD SUMMARY ─────────────────────────────────
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDFBF7), // Warm mockup canvas shade
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFFF7FAFC)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "BUNDLE PREVIEW",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                          color: const Color(0xFF2D3748),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      _buildSummaryRow("Name:", detail.name ?? "Bundle Package"),
                      _buildSummaryRow("Courses:", "${detail.coursesDetail?.length ?? 0} courses"),
                      _buildSummaryRow("Original Value:", "\$${originalPrice.toStringAsFixed(2)}"),
                      _buildSummaryRow(
                        "Bundle Price:",
                        "\$${bundlePrice.toStringAsFixed(2)}",
                        isBoldValue: true,
                      ),
                      const Divider(color: Color(0xFFE2E8F0), height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Customer Saves:",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF2F855A),
                            ),
                          ),
                          Text(
                            "\$${savings > 0 ? savings.toStringAsFixed(2) : '0.00'}",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF2F855A),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 20.h),

                // ─── ACTION BUTTONS ────────────────────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(fontSize: 14.sp, color: const Color(0xFF4A5568), fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Perform Add to Cart implementation details
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tealColor,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                        ),
                        child: Text(
                          "Add to Cart",
                          style: TextStyle(fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBoldValue = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 13.sp, color: const Color(0xFF718096))),
          Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: isBoldValue ? FontWeight.bold : FontWeight.w500,
              color: const Color(0xFF1A202C),
            ),
          ),
        ],
      ),
    );
  }
}

// Quick helper extension extension to support clean inner-loop padding separations
extension on num {
  EdgeInsetsGeometry bottomOffset(double value) => EdgeInsets.only(bottom: value);
}