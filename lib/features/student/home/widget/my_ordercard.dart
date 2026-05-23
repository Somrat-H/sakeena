import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOrderCard extends StatelessWidget {
  final String statusText;      // e.g., "Pending"
  final String orderTitle;     // e.g., "Order #23 - Course"
  final int itemCount;         // e.g., 1
  final String dateText;       // e.g., "23 May 2026, 12:07"
  final double totalAmount;    // e.g., 150.00
  final VoidCallback onViewDetails;

  const MyOrderCard({
    super.key,
    required this.statusText,
    required this.orderTitle,
    required this.itemCount,
    required this.dateText,
    required this.totalAmount,
    required this.onViewDetails,
  });

  // Theme matching your primary teal tone
  final Color primaryTeal = const Color(0xFF2C7A7B);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Wrap content if the layout width shrinks excessively
          if (constraints.maxWidth < 450) {
            return _buildVerticalLayout();
          }
          return _buildHorizontalLayout();
        },
      ),
    );
  }

  // --- Layout Modes ---

  Widget _buildHorizontalLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: _buildOrderDetailsBody(),
        ),
        SizedBox(width: 16.w),
        _buildActionButton(),
      ],
    );
  }

  Widget _buildVerticalLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildOrderDetailsBody(),
        SizedBox(height: 16.h),
        SizedBox(
          width: double.infinity,
          child: _buildActionButton(),
        ),
      ],
    );
  }

  // --- Subcomponents ---

  Widget _buildOrderDetailsBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. Status Badge
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: const Color(0xFFE0F7FA), // Soft cyan background tint
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: primaryTeal,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 10.h),

        // 2. Order Header Title
        Text(
          orderTitle,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Arimo',
          ),
        ),
        SizedBox(height: 6.h),

        // 3. Item Count Meta Text
        Text(
          "$itemCount item(s)",
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 4.h),

        // 4. Timestamp Metadata
        Text(
          dateText,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey.shade500,
          ),
        ),
        SizedBox(height: 6.h),

        // 5. Total Pricing Section
        RichText(
          text: TextSpan(
            text: 'Total: ',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade800,
              fontFamily: 'Arimo',
            ),
            children: [
              TextSpan(
                text: '\$${totalAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: primaryTeal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    return ElevatedButton(
      onPressed: onViewDetails,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryTeal,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Text(
        "View Details",
        style: TextStyle(
          color: Colors.white,
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}