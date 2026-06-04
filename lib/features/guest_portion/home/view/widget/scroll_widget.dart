import 'package:flutter/material.dart';

class CarouselNavigationButtons extends StatelessWidget {
  final VoidCallback onLeftTap;
  final VoidCallback onRightTap;
  final Color iconColor;
  final Color borderColor;
  final Color backgroundColor;
  final double iconSize;
  final double padding;

  const CarouselNavigationButtons({
    super.key,
    required this.onLeftTap,
    required this.onRightTap,
    this.iconColor = const Color(0xFF555555), // Matches your grey.shade600
    this.borderColor = const Color(0xFFEEEEEE), // Matches your grey.shade200
    this.backgroundColor = Colors.white,
    this.iconSize = 20.0,
    this.padding = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNavButton(
          icon: Icons.chevron_left,
          onTap: onLeftTap,
        ),
        const SizedBox(width: 16),
        _buildNavButton(
          icon: Icons.chevron_right,
          onTap: onRightTap,
        ),
      ],
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
          border: Border.all(color: borderColor),
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}