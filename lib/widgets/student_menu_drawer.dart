import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/features/student/profile/controller/profile_controller.dart';
import 'package:sakeena/route/go_route.dart';
import 'package:shimmer/shimmer.dart';

/// -----------------------------
/// MENU MODEL
/// -----------------------------
class DrawerMenuItem {
  final String label;
  final IconData icon;
  final String route;

  const DrawerMenuItem({
    required this.label,
    required this.icon,
    required this.route,
  });
}

/// -----------------------------
/// MENU LIST
/// -----------------------------
final List<DrawerMenuItem> studentMenuItems = [
  DrawerMenuItem(
    label: 'Home',
    icon: Icons.home_outlined,
    route: AppRoutes.homeGuest,
  ),
  DrawerMenuItem(
    label: 'Courses',
    icon: Icons.school_outlined,
    route: AppRoutes.courseGuest,
  ),
  DrawerMenuItem(
    label: 'Faculty',
    icon: Icons.people_outline,
    route: AppRoutes.facultyGuest,
  ),
  DrawerMenuItem(
    label: 'Book',
    icon: Icons.menu_book_outlined,
    route: AppRoutes.bookGuest,
  ),
  DrawerMenuItem(
    label: 'Blog',
    icon: Icons.article_outlined,
    route: AppRoutes.blogsGuest,
  ),
   DrawerMenuItem(
    label: 'Video',
    icon: Icons.play_circle,
    route: AppRoutes.videoLibraryScreen,
  ),
  DrawerMenuItem(
    label: 'Profile',
    icon: Icons.person_outline,
    route: AppRoutes.studentProfilePage,
  ),
  DrawerMenuItem(
    label: 'Settings',
    icon: Icons.settings_outlined,
    route: AppRoutes.profileSettingsPage,
  ),
];

/// -----------------------------
/// STUDENT DRAWER
/// -----------------------------
class StudentMenuDrawer extends StatelessWidget {
  const StudentMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.toString();
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: ListView(
                  children: studentMenuItems.map((item) {
                    final isActive = currentRoute.startsWith(item.route);
                    return _MenuTile(
                      label: item.label,
                      icon: item.icon,
                      isActive: isActive,
                      onTap: () {
                        Navigator.pop(context);
                        if (!isActive) {
                          context.push(item.route);
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

/// -----------------------------
/// HEADER
/// -----------------------------
Widget _buildHeader(BuildContext context) {
  const headerColor = Color(0xFF2C7A7B);
  // Use watch to listen for changes (like when isLoading becomes false)
  final profileProvider = context.watch<ProfileController>();
  final data = profileProvider.stundetProfileResponse;

  // 1. Show Shimmer while loading
  if (profileProvider.isLoading) {
    return _buildHeaderShimmer(headerColor);
  }

  // 2. Safely extract values with null-coalescing
  final String fullName = "${data.firstName ?? 'Student'} ${data.lastName ?? ''}".trim();
  final String? profilePic = data.profilePicture;
  final String email = data.email ?? "No email provided";

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
  // Added null-safe navigation (?.) to protect against uninitialized states safely
  child: (profileProvider.stundetProfileResponse?.email ?? '').isEmpty  
    ? Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Prevents column from eating vertical layout room
          children: [
          
            
            // --- Custom Brand Login Button ---
            SizedBox(
              width: 160.w,
              height: 40.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,      // Standout white container block
                  foregroundColor: headerColor,        // Direct matching branding teal ink color
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r), // Premium capsule look
                  ),
                ),
                onPressed: () {
                  context.push(AppRoutes.login);
                },
                child: Text(
                  "Login Now",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ) 
    : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 38.r,
            backgroundColor: Colors.white24,
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
            'Student',
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

/// -----------------------------
/// MENU TILE
/// -----------------------------
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
        margin: EdgeInsets.only(bottom: 8.h),
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
                fontWeight: FontWeight.w500,
                color: isActive ? Colors.white : const Color(0xFF333333),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:sakeena/route/go_route.dart';

// class StudentMenuDrawer extends StatelessWidget {
//   final String userName;
//   final String? avatarUrl;
//   final String? email;
//   final VoidCallback? onLogout;
//   final String? selectedRoute;

//   const StudentMenuDrawer({
//     super.key,
//     this.userName = 'Student',
//     this.avatarUrl,
//     this.email,
//     this.onLogout,
//     this.selectedRoute,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Column(
//         children: [
//           // ─── Header ───────────────────────────────────────
//           _buildHeader(context),

//           // ─── Menu Items ───────────────────────────────────
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children: _buildMenuItems(context),
//             ),
//           ),

//           // ─── Bottom section (Settings + Logout) ───────────
//           const Divider(height: 1),
//           _buildBottomSection(context),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     final headerColor = const Color(0xFF2C7A7B);

//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.fromLTRB(24.w, 60.h, 24.w, 28.h),
//       decoration: BoxDecoration(
//         color: headerColor,
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [headerColor, headerColor.withOpacity(0.85)],
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Avatar
//           CircleAvatar(
//             radius: 38.r,
//             backgroundColor: Colors.white24,
//             backgroundImage: avatarUrl != null
//                 ? NetworkImage(avatarUrl!)
//                 : null,
//             child: avatarUrl == null
//                 ? Icon(Icons.person, size: 44.sp, color: Colors.white70)
//                 : null,
//           ),
//           SizedBox(height: 16.h),

//           // Name & Role
//           Text(
//             userName,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 20.sp,
//               fontWeight: FontWeight.w600,
//               letterSpacing: 0.2,
//             ),
//           ),
//           SizedBox(height: 4.h),
//           Text(
//             'Student',
//             style: TextStyle(color: Colors.white70, fontSize: 14.sp),
//           ),
//           if (email != null) ...[
//             SizedBox(height: 4.h),
//             Text(
//               email!,
//               style: TextStyle(color: Colors.white60, fontSize: 13.sp),
//             ),
//           ],
//         ],
//       ),
//     );
//   }

//   List<Widget> _buildMenuItems(BuildContext context) {
//     final items = [
//       {
//         'icon': Icons.home_outlined,
//         'title': 'Home',
//         'route': AppRoutes.studentHomeScreen,
//       },
//       {
//         'icon': Icons.school_outlined,
//         'title': 'Courses',
//         'route': AppRoutes.myCourseScreen,
//       },
//       {
//         'icon': Icons.video_call_outlined,
//         'title': 'Class Joining',
//         'route': AppRoutes.studentLiveClass,
//       },
//       {
//         'icon': Icons.person_outline,
//         'title': 'Teachers',
//         'route': AppRoutes.teachersScreenForStudent,
//       },
//       {
//         'icon': Icons.auto_stories_outlined,
//         'title': 'Books',
//         'route': AppRoutes.booksPage,
//       },
//       {
//         'icon': Icons.article_outlined,
//         'title': 'Blog',
//         'route': AppRoutes.blogScreen,
//       },
//       {
//         'icon': Icons.person,
//         'title': 'Profile',
//         'route': AppRoutes.studentProfilePage,
//       },
//       {
//         'icon': Icons.settings_outlined,
//         'title': 'Settings',
//         'route': AppRoutes.profileSettingsPage,
//       },
//     ];

//     return items.map((item) {
//       final isSelected = selectedRoute == item['route'];
//       return ListTile(
//         leading: Icon(
//           item['icon'] as IconData,
//           color: isSelected ? const Color(0xFF2C7A7B) : null,
//           size: 26.sp,
//         ),
//         title: Text(
//           item['title'] as String,
//           style: TextStyle(
//             fontSize: 15.5.sp,
//             fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//             color: isSelected ? const Color(0xFF2C7A7B) : null,
//           ),
//         ),
//         selected: isSelected,
//         selectedTileColor: const Color(0xFF2C7A7B).withOpacity(0.08),
//         onTap: () {
//           Navigator.pop(context);
//           context.push(item['route'] as String);
//         },
//       );
//     }).toList();
//   }

//   Widget _buildBottomSection(BuildContext context) {
//     return SafeArea(
//       child: Column(
//         children: [
//           ListTile(
//             leading: const Icon(Icons.help_outline),
//             title: const Text('Help & Support'),
//             onTap: () {
//               Navigator.pop(context);
//               context.go(AppRoutes.supportScreen);
//             },
//           ),
//           const Divider(height: 8),
//           ListTile(
//             leading: const Icon(Icons.logout, color: Colors.redAccent),
//             title: const Text(
//               'Logout',
//               style: TextStyle(color: Colors.redAccent),
//             ),
//             onTap: () {
//               Navigator.pop(context);
//               if (onLogout != null) onLogout!();
//             },
//           ),
//           SizedBox(height: 16.h),
//         ],
//       ),
//     );
//   }
// }
