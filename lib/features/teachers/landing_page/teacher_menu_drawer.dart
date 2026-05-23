import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/features/teachers/profile/controller/teacher_profile_controller.dart';
import 'package:sakeena/route/go_route.dart';
import 'package:sakeena/route/teachers_routes.dart';
import 'package:shimmer/shimmer.dart';

class TeacherDrawerMenuItem {
  final String label;
  final IconData icon;
  final String route;

  const TeacherDrawerMenuItem({
    required this.label,
    required this.icon,
    required this.route,
  });
}

const List<TeacherDrawerMenuItem> teacherMenuItems = [
  TeacherDrawerMenuItem(
    label: 'Home',
    icon: Icons.home_outlined,
    route: TeachersRoutes.dashboard,
  ),
  TeacherDrawerMenuItem(
    label: 'My Courses',
    icon: Icons.school_outlined,
    route: TeachersRoutes.myCourses,
  ),
  TeacherDrawerMenuItem(
    label: 'Consultations',
    icon: Icons.video_call_outlined,
    route: TeachersRoutes.consultation,
  ),
  TeacherDrawerMenuItem(
    label: 'Content Upload',
    icon: Icons.cloud_upload_outlined,
    route: TeachersRoutes.uploadContent,
  ),
  TeacherDrawerMenuItem(
    label: 'Earnings & Revenue',
    icon: Icons.attach_money_outlined,
    route: TeachersRoutes.earnings,
  ),
  TeacherDrawerMenuItem(
    label: 'Submissions',
    icon: Icons.file_upload_outlined,
    route: TeachersRoutes.submissions,
  ),
  TeacherDrawerMenuItem(
    label: 'Profile',
    icon: Icons.person_outline,
    route: TeachersRoutes.profile,
  ),
  TeacherDrawerMenuItem(
    label: 'Settings',
    icon: Icons.settings_outlined,
    route: TeachersRoutes.settings,
    // route: AppRoutes.profileSettingsPage,
  ),
];

class TeacherMenuDrawer extends StatelessWidget {
  final String selectedRoute;

  const TeacherMenuDrawer({super.key, required this.selectedRoute});

  @override
  Widget build(BuildContext context) {
    final profileController = context.watch<TeacherProfileController>();
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Header
              _buildHeader(context),

              // 🔹 Menu items
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: teacherMenuItems.map((item) {
                      final isActive = selectedRoute.startsWith(item.route);

                      return _MenuTile(
                        label: item.label,
                        icon: item.icon,
                        isActive: isActive,
                        onTap: () {
                          Navigator.pop(context);
                          if (!isActive) {
                            context.go(item.route);
                          }
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildHeaderShimmer(Color color) {
  return Shimmer.fromColors(
    baseColor: color.withOpacity(0.8),
    highlightColor: color.withOpacity(0.5),
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24.w, 50.h, 24.w, 28.h),
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 38.r, backgroundColor: Colors.white),
          SizedBox(height: 16.h),
          Container(width: 150.w, height: 20.h, color: Colors.white),
          SizedBox(height: 8.h),
          Container(width: 80.w, height: 14.h, color: Colors.white),
          SizedBox(height: 8.h),
          Container(width: 180.w, height: 12.h, color: Colors.white),
        ],
      ),
    ),
  );
}
Widget _buildHeader(BuildContext context) {
  const headerColor = Color(0xFF2C7A7B);
  // Use watch to listen for changes (like when isLoading becomes false)
  final profileProvider = context.watch<TeacherProfileController>();
  final data = profileProvider.teacherProfileResponse;

  // 1. Show Shimmer while loading
  if (profileProvider.isLoading) {
    return _buildHeaderShimmer(headerColor);
  }

  // 2. Safely extract values with null-coalescing
  final String fullName = "${data.user!.firstName ?? 'Student'} ${data.user!.lastName ?? ''}".trim();
  final String? profilePic = data.profilePicture;
  final String email = data.user!.email ?? "No email provided";
  final String role = data.user!.role ?? "N/A";

  return Container(
    width: double.infinity,
    padding: EdgeInsets.fromLTRB(24.w, 50.h, 24.w, 28.h),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [headerColor, headerColor.withOpacity(0.85)],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 38.r,
          backgroundColor: Colors.white24,
          // Improved logic: check if null OR empty
          backgroundImage: (profilePic != null && profilePic.isNotEmpty)
              ? NetworkImage(profilePic)
              : const NetworkImage("https://cdn-icons-png.flaticon.com/128/149/149071.png"),
        ),
        SizedBox(height: 16.h),
        Text(
          fullName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          role,
          style: TextStyle(color: Colors.white70, fontSize: 14.sp),
        ),
        SizedBox(height: 4.h),
        Text(
          email,
          style: TextStyle(color: Colors.white60, fontSize: 13.sp),
        ),
      ],
    ),
  );
}



class _MenuTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _MenuTile({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF2C7A7B) : Colors.transparent,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22.sp,
              color: isActive ? Colors.white : const Color(0xFF555555),
            ),
            SizedBox(width: 12.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive ? Colors.white : const Color(0xFF333333),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
