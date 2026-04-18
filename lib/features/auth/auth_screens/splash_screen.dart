// // features/auth_screens/splash_screen.dart
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';
// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(const Duration(seconds: 2), () {
//       context.go('/login');
//     });

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SizedBox(
//           width: 0.70.sw,
//           child: SvgPicture.asset(
//             'assets/images/sakeena_logo.svg',
//             fit: BoxFit.contain,
//           ),
//         ),
//       ),
//     );
//   }
// }

// features/auth_screens/splash_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
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

    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      context.go(AppRoutes.login);
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
