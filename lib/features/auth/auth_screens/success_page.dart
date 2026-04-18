import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena/route/go_route.dart';
import 'package:sakeena/widgets/auth_background.dart';
import 'package:sakeena/widgets/custom_button.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 100.sp,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 24.h),
              Text(
                'Password Changed!',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C7A7B),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Your password has been changed successfully.',
                style: TextStyle(fontSize: 14.sp, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 48.h),
              CustomButton(
                text: 'Back to Login',
                textColor: Colors.white,
                onPressed: () => context.go(AppRoutes.login),
                isGradient: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
