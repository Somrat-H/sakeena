import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background SVG - fills the entire screen
        Positioned.fill(
          child: SvgPicture.asset(
            'assets/images/background.svg',
            fit: BoxFit.cover,    
           
                   // or BoxFit.fill / BoxFit.contain depending on your design
            // Optional: color filter if you want to tint the background
            // colorFilter: ColorFilter.mode(
            //   Colors.black.withOpacity(0.15),
            //   BlendMode.darken,
            // ),
          ),
        ),

        // SafeArea + scrollable content
        SafeArea(
          child: child,
        ),
      ],
    );
  }
}