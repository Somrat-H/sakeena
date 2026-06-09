import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/features/guest_portion/home/provider/guest_navbar_provider.dart';
import 'package:sakeena/widgets/custom_bottom_navbar.dart';
import 'package:sakeena/widgets/student_menu_drawer.dart';

import 'go_route.dart';

class GuestShell extends StatelessWidget {
  final Widget child;

  // Local static Key to manage EndDrawer requests from a stateless architecture safely
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GuestShell({super.key, required this.child});

  // Dynamic router sync tracker replacing the messy build-phase layout overrides
  int _calculateCurrentIndex(String location) {
    if (location.startsWith(AppRoutes.homeGuest) ||
        location.startsWith(AppRoutes.studentHomeScreen)) {
      return 0;
    } else if (location.startsWith(AppRoutes.courseGuest) ||
        location.startsWith(AppRoutes.myCourseScreen)) {
      return 1;
    } else if (location.startsWith(AppRoutes.consultationGuest)) {
      return 2;
    } else if (location.startsWith(AppRoutes.bookGuest)) {
      return 3; // Position index 3 allocated for dynamic blogs route tracker
    } else if (location.startsWith(AppRoutes.blogsGuest )) {
      return 4; // Shifted books down to index 4
    }
    return 0; // Standard layout fallback index
  }

  void _onTap(BuildContext context, int index) {
    // Menu item shifted to index 5 to support the new item addition cleanly
    if (index == 5) {
      _scaffoldKey.currentState?.openEndDrawer();
      return;
    }

    // Pass the index update downstream to our state layer matching architecture guidelines
    context.read<GuestNavProvider>().updateIndex(index);

    // Context-safe routing configurations
    switch (index) {
      case 0:
        context.go(AppRoutes.homeGuest);
        break;
      case 1:
        context.go(AppRoutes.courseGuest);
        break;
      case 2:
        context.go(AppRoutes.consultationGuest);
        break;
      case 3:
        context.go(AppRoutes.bookGuest);
        break;
      case 4:
        context.go(AppRoutes.blogsGuest);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Dynamic single-source of truth tracking route state directly from GoRouter lifecycle
    final String currentUri = GoRouterState.of(context).uri.toString();
    final int routingMatchedIndex = _calculateCurrentIndex(currentUri);

    // Sync state controller accurately without building infinite execution loops
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        context.read<GuestNavProvider>().updateIndex(routingMatchedIndex);
      }
    });

    // Watch the dynamic navigation provider state layer changes safely
    final activeIndex = context.watch<GuestNavProvider>().currentIndex;

    return Scaffold(
      key: _scaffoldKey,
      body: child,
      endDrawer: const StudentMenuDrawer(),
      bottomNavigationBar: CustomBottomNavBar(
        items: guestBottomNavItems,
        currentIndex: activeIndex,
        onTap: (index) => _onTap(context, index),
      ),
    );
  }
}
