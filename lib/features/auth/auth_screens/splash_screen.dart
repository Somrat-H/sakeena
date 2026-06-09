import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena/core/storage/token_manager.dart';
import 'package:sakeena/route/go_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
@override
void initState() {
  super.initState();

  // Execute async route evaluation post frame rendering pipeline
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    // 1. Fetch token credentials out of internal storage cache
    final String? accessToken = await TokenStorage.getAccessToken();

    // 2. Validate current view target context is still alive inside widget tree
    if (!mounted) return;

    // 3. Evaluate conditional routing tracks based on presence of a token
    if (accessToken != null && accessToken.isNotEmpty) {
      context.go(AppRoutes.homeGuest); // Dynamic protected workspace route
    } else {
      context.go(AppRoutes.homeGuest); // The open-access carousel landing pad
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 0.70.sw,
          child: SvgPicture.asset(
            'assets/images/sakeena_logo.svg',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
