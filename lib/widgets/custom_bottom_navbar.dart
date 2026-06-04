import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena/route/go_route.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavItem {
  final String label;
  final IconData? icon;
  final String? svgPath;
  final String? route;
  final bool isMenu;

  const BottomNavItem({
    required this.label,
    this.icon,
    this.svgPath,
    this.route,
    this.isMenu = false,
  }) : assert(icon != null || svgPath != null);
}

// 🔹 Guest bottom nav items
 List<BottomNavItem> guestBottomNavItems = [
  BottomNavItem(
    label: 'Home',
    icon: Icons.home_outlined,
    route: AppRoutes.homeGuest,
  ),
  BottomNavItem(
    label: 'Courses',
    svgPath: 'assets/icons/course-icon.svg',
    route: AppRoutes.courseGuest,
  ),
  BottomNavItem(
    label: 'Consultation',
    svgPath: 'assets/icons/teacher-icon.svg',
    route: AppRoutes.consultation,
  ),
  BottomNavItem(
    label: 'Books',
    svgPath: 'assets/icons/open-book.svg', 
    route: AppRoutes.bookGuest,
  ),
    BottomNavItem(
    label: 'Blogs',
    svgPath: 'assets/icons/blog-icon.svg',
    route: AppRoutes.blogsGuest,
  ),
  BottomNavItem(
    label: 'Menu',
    svgPath: 'assets/icons/menu_icon.svg',
    isMenu: true,
  ),
];

// 🔹 Student bottom nav items
const List<BottomNavItem> studentBottomNavItems = [
  BottomNavItem(
    label: 'Home',
    icon: Icons.home_outlined,
    route: AppRoutes.studentHomeScreen,
  ),
  BottomNavItem(
    label: 'Courses',
    svgPath: 'assets/icons/course_nav_icon.svg',
    route: AppRoutes.myCourseScreen,
  ),
  BottomNavItem(
    label: 'Faculty',
    svgPath: 'assets/icons/nav_icon_three.svg',
    route: AppRoutes.teachersScreenForStudent,
  ),
  BottomNavItem(
    label: 'Books',
    svgPath: 'assets/icons/book_icon.svg',
    route: AppRoutes.studentLiveClass,
  ),
   BottomNavItem(
    label: 'Blogs',
    svgPath: 'assets/icons/blog.svg',
    route: AppRoutes.blogsGuest,
  ),
  BottomNavItem(
    label: 'Menu',
    svgPath: 'assets/icons/menu_icon.svg',
    isMenu: true,
  ),
];

class CustomBottomNavBar extends StatelessWidget {
  final List<BottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFBE7),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(items.length, (index) {
            final item = items[index];
            final isActive = index == currentIndex && !item.isMenu;
            return Expanded(
              child: _NavButton(
                item: item,
                isActive: isActive,
                onTap: () => onTap(index),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final BottomNavItem item;
  final bool isActive;
  final VoidCallback onTap;

  const _NavButton({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Label configurations based on selection states
    final textColor = isActive ? const Color(0xFF2C7A7B) : const Color(0xFF555555);
    final fontWeight = isActive ? FontWeight.bold : FontWeight.w500;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon container layout
            AnimatedContainer(
              duration: const Duration(milliseconds: 240),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 4.h,
              ),
              decoration: BoxDecoration(
                // Creates a clean, dynamic background pill behind the icon when active
                color: isActive ? const Color(0xFF2C7A7B).withOpacity(0.12) : Colors.transparent,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: _buildIcon(item, isActive),
            ),
            SizedBox(height: 4.h),
            // Text is permanently visible outside conditional barriers
            Text(
              item.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: textColor,
                fontSize: 11.sp,
                fontWeight: fontWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(BottomNavItem item, bool isActive) {
    final color = isActive ? const Color(0xFF2C7A7B) : const Color(0xFF555555);

    if (item.icon != null) {
      return Icon(item.icon, size: 20.sp, color: color);
    }

    return SvgPicture.asset(
      item.svgPath!,
      width: 20.sp,
      height: 20.sp,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}