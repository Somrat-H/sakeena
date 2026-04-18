import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/features/auth/controller/auth_controller.dart';
import 'package:sakeena/route/go_route.dart';
import 'package:sakeena/view_model/auth_view_model.dart';
import 'package:sakeena/view_model/user_provider.dart';
import 'package:sakeena/widgets/auth_background.dart';
import 'package:sakeena/widgets/custom_button.dart';
import 'package:sakeena/widgets/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthControlle>();
    return Scaffold(
      body: AuthBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50.h),

                  // Logo (replaced text 'Sakeena')
                  SvgPicture.asset(
                    'assets/images/sakeena_logo.svg',
                    height: 80.h,
                    // width: 180.w,   // ← uncomment & adjust if needed
                    fit: BoxFit.contain,
                    // Optional: color override if the SVG allows tinting
                    // colorFilter: ColorFilter.mode(
                    //   Colors.white,
                    //   BlendMode.srcIn,
                    // ),
                  ),

                  SizedBox(height: 10.h),

                  Column(
                    children: [
                      Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2C7A7B),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Begin your journey of healing and growth.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontFamily: 'Arimo',
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 32.h),

                      // Full name
                      CustomTextField(
                        hintText: 'Enter your full name',
                        prefixIcon: Icons.person_outline,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          controller.name = value;
                        },
                      ),
                      SizedBox(height: 20.h),

                      // Email
                      CustomTextField(
                        hintText: 'Enter your email',
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value.trim())) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          controller.email = value;
                        },
                      ),
                      SizedBox(height: 20.h),

                      // Password
                      CustomTextField(
                        hintText: 'Password',
                        prefixIcon: Icons.lock_outline,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        onChanged: (v){
                          controller.password  = v;
                        },
                      ),
                      SizedBox(height: 20.h),

                      // Confirm Password
                      CustomTextField(
                        hintText: 'Confirm Password',
                        prefixIcon: Icons.lock_outline,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm password';
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 28.h),

                      // Error message

                      // Sign up button
                      controller.isLoading
                          ? const CircularProgressIndicator()
                          : CustomButton(
                              text: 'Sign up',
                              textColor: Colors.white,
                              onPressed: () async {
                                if (controller.email.isNotEmpty &&
                                    controller.password.isNotEmpty &&
                                    controller.name.isNotEmpty) {
                                  final ok = await controller.signup(context);
                                  if (ok) {
                                    if (context.mounted) {
                                      context.go(AppRoutes.login);
                                    }
                                  }
                                }
                              },
                              isGradient: true,
                            ),

                      SizedBox(height: 20.h),

                      // Google sign up
                      CustomButton(
                        text: 'Sign up with Google',
                        onPressed: () {
                          // TODO: implement Google Sign-In
                        },
                        isOutlined: true,
                        icon: SvgPicture.asset(
                          'assets/images/google_ic.svg',
                          width: 20.w,
                          height: 20.w,
                        ),
                      ),

                      SizedBox(height: 28.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.go(AppRoutes.login),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xFF2C7A7B),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Center(
                        child: Text(
                          'By creating an account, you agree to our Terms of Service and Privacy Policy',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
