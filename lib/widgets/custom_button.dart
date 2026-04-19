import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double height;
  final bool isGradient;
  final bool isOutlined;
  final bool isWhiteOutlined;
  final Widget? icon;
  final Color? textColor;
  final bool isLoading; // 1. Added isLoading property

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height = 48,
    this.isGradient = false,
    this.isOutlined = false,
    this.isWhiteOutlined = false,
    this.icon,
    this.textColor,
    this.isLoading = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    // Determine effective text color
    final effectiveTextColor = textColor ??
        (isWhiteOutlined
            ? Colors.white.withOpacity(0.9) // Fixed logic for better visibility
            : isOutlined
                ? Colors.black
                : Colors.white);

    // Determine border side
    final borderSide = isWhiteOutlined
        ? BorderSide(color: Colors.white.withOpacity(0.7))
        : isOutlined
            ? const BorderSide(color: Colors.grey)
            : BorderSide.none;

    final bgColor = (isOutlined || isWhiteOutlined) ? Colors.transparent : null;

    return SizedBox(
      width: width,
      height: height.h,
      child: ElevatedButton(
        // 2. Disable button if isLoading is true
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          elevation: (isOutlined || isWhiteOutlined) ? 0 : 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
            side: borderSide,
          ),
          padding: EdgeInsets.zero,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: isGradient && !isWhiteOutlined && !isOutlined
                ? const LinearGradient(
                    colors: [Color(0xFF205A60), Color(0xFF3B8F97)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                : null,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Center(
            // 3. Toggle between Content and Loader
            child: isLoading
                ? SizedBox(
                    height: 18.h,
                    width: 18.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      // Matches the text color
                      valueColor: AlwaysStoppedAnimation<Color>(effectiveTextColor),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) ...[icon!, SizedBox(width: 8.w)],
                      Flexible(
                        child: Text(
                          text,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                            color: effectiveTextColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}