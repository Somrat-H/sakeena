import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/features/guest_portion/cart/provider/cart_provider.dart';

class CartViewScreen extends StatelessWidget {
  const CartViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Exact structural brand design tokens
    const Color tealBrandBg = Color(0xFF386A6B);
    const Color backgroundBeige = Color(0xFFF3EFE3);
    const Color textSlateGray = Color(0xFF64748B);
    const Color darkSlateText = Color(0xFF1E293B);

    final cartProvider = context.watch<CartProvider>();
    final cartItems = cartProvider.items;
    final isDesktopOrTablet = MediaQuery.of(context).size.width > 768;

    return Scaffold(
      backgroundColor: backgroundBeige,
      resizeToAvoidBottomInset: true, 
    appBar: AppBar(
    backgroundColor: tealBrandBg,
    elevation: 0,
    centerTitle: true,
    leading: Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: IconButton(
        onPressed: () => context.pop(),
        style: IconButton.styleFrom(
          shape: const CircleBorder(),
        ),
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 20.r,
        ),
      ),
    ),
    title: Text(
      "Cart View",
      style: TextStyle(
        color: Colors.white,
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    ),
  ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                "Your cart is currently empty.",
                style: TextStyle(
                  color: textSlateGray,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dynamic Layout Engine (Adaptive Grid Table or Mobile Cards)
                    if (isDesktopOrTablet)
                      _buildWideTableLayout(context, cartItems, tealBrandBg, darkSlateText, textSlateGray)
                    else
                      _buildMobileListLayout(context, cartItems, tealBrandBg, darkSlateText, textSlateGray),
                    
                    SizedBox(height: 24.h),
                    
                    // Checkout, Summaries, and Coupon Section Matrix
                    _buildSummaryAndCouponSection(context, cartProvider, tealBrandBg, darkSlateText, textSlateGray),
                    
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
    );
  }

  // --- WIDE TABLE LAYOUT (For Tablets / Big Viewports) ---
  Widget _buildWideTableLayout(BuildContext context, List<dynamic> cartItems, Color tealBrandBg, Color darkSlateText, Color textSlateGray) {
    final Map<int, TableColumnWidth> tableColumnProportions = {
      0: const FlexColumnWidth(3.5), 
      1: const FlexColumnWidth(1.2),  
      2: const FlexColumnWidth(1.2),  
      3: const FlexColumnWidth(1.0),    
      4: const FlexColumnWidth(1.5),  
      5: FixedColumnWidth(48.w), 
    };

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: 800.w, 
          child: Table(
            columnWidths: tableColumnProportions,
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1)),
                ),
                children: [
                  _tableHeaderCell("Name", textSlateGray),
                  _tableHeaderCell("Type", textSlateGray),
                  _tableHeaderCell("Price", textSlateGray),
                  _tableHeaderCell("Quantity", textSlateGray),
                  _tableHeaderCell("Subtotal", textSlateGray),
                  const Center(child: Padding(padding: EdgeInsets.all(16.0), child: Text(""))),
                ],
              ),
              ...cartItems.map((item) {
                return TableRow(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9), width: 1)),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: TextStyle(color: darkSlateText, fontSize: 14.sp, fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.h),
                          Text(item.category, style: TextStyle(color: textSlateGray, fontSize: 12.sp)),
                        ],
                      ),
                    ),
                    Text(item.type, style: TextStyle(color: textSlateGray, fontSize: 13.sp)),
                    Text("\$${item.price.toStringAsFixed(2)}", style: TextStyle(color: darkSlateText, fontSize: 13.sp, fontWeight: FontWeight.bold)),
                    Text("${item.quantity}", style: TextStyle(color: darkSlateText, fontSize: 13.sp)),
                    Text(
                      "\$${(item.price * item.quantity).toStringAsFixed(2)}",
                      style: TextStyle(color: tealBrandBg, fontSize: 13.sp, fontWeight: FontWeight.bold),
                    ),
                    Center(
                      child: IconButton(
                        onPressed: () => Provider.of<CartProvider>(context, listen: false).removeItem(item.id),
                        icon: Icon(Icons.delete_outline, size: 20.r, color: const Color(0xFFEF4444)),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // --- MOBILE LIST LAYOUT (Sliver-Free Layout) ---
  Widget _buildMobileListLayout(BuildContext context, List<dynamic> cartItems, Color tealBrandBg, Color darkSlateText, Color textSlateGray) {
    return Column(
      children: cartItems.map((item) {
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Container(
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 2)),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: TextStyle(color: darkSlateText, fontSize: 14.sp, fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Text(item.category, style: TextStyle(color: textSlateGray, fontSize: 12.sp)),
                          SizedBox(width: 8.w),
                          Container(width: 4, height: 4, decoration: BoxDecoration(shape: BoxShape.circle, color: textSlateGray.withOpacity(0.5))),
                          SizedBox(width: 8.w),
                          Text(item.type, style: TextStyle(color: textSlateGray, fontSize: 12.sp)),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Text(
                            "${item.quantity} × \$${item.price.toStringAsFixed(2)}",
                            style: TextStyle(color: darkSlateText, fontSize: 13.sp, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            "\$${(item.price * item.quantity).toStringAsFixed(2)}",
                            style: TextStyle(color: tealBrandBg, fontSize: 14.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Provider.of<CartProvider>(context, listen: false).removeItem(item.id),
                  icon: Icon(Icons.delete_outline, size: 20.r, color: const Color(0xFFEF4444)),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // --- DISCOUNTS & SUMMARY CHECKOUT FOOTER COMPONENT BLOCK ---
  Widget _buildSummaryAndCouponSection(BuildContext context, CartProvider cartProvider, Color tealBrandBg, Color darkSlateText, Color textSlateGray) {
    return Column(
      children: [
        // Coupon Box Matrix
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: const Color(0xFFEBF5F4),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFC7E2E0), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.local_offer_outlined, color: tealBrandBg, size: 18.r),
                  SizedBox(width: 8.w),
                  Text("Coupon Code", style: TextStyle(color: darkSlateText, fontSize: 14.sp, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
                      ),
                      child: TextField(
                        style: TextStyle(fontSize: 13.sp),
                        decoration: InputDecoration(
                          hintText: "Enter coupon code",
                          hintStyle: TextStyle(color: const Color(0xFF94A3B8), fontSize: 13.sp),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  SizedBox(
                    height: 40.h,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tealBrandBg,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                      ),
                      child: Text("Apply", style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        
        // Checkout Bill Aggregations Container
        Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Subtotal", style: TextStyle(color: textSlateGray, fontSize: 14.sp)),
                  Text("\$${cartProvider.subtotal.toStringAsFixed(2)}", style: TextStyle(color: darkSlateText, fontSize: 14.sp, fontWeight: FontWeight.bold)),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: const Divider(color: Color(0xFFF1F5F9), height: 1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Amount", style: TextStyle(color: darkSlateText, fontSize: 15.sp, fontWeight: FontWeight.bold)),
                  Text("\$${cartProvider.totalAmount.toStringAsFixed(2)}", style: TextStyle(color: tealBrandBg, fontSize: 16.sp, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),

        // Action Trigger Controls 
        ElevatedButton(
          onPressed: () => cartProvider.handleCheckoutAction(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: tealBrandBg,
            minimumSize: Size(double.infinity, 48.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
            elevation: 0,
          ),
          child: Text(
            cartProvider.isLoggedIn ? "Proceed to Checkout" : "Login to Checkout",
            style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8.h),
        TextButton(
          onPressed: () => cartProvider.toggleLoginStatus(),
          child: Text(
            "Simulate Status: [${cartProvider.isLoggedIn ? 'Logged In' : 'Guest Mode'}]",
            style: TextStyle(color: textSlateGray, fontSize: 11.sp, decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }

  Widget _tableHeaderCell(String label, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      child: Text(
        label, 
        style: TextStyle(color: color, fontSize: 13.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}