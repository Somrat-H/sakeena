import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sakeena/features/auth/controller/auth_controller.dart';
import 'package:sakeena/route/go_route.dart';
import 'package:sakeena/route/teachers_routes.dart';
import 'package:sakeena/view_model/auth_view_model.dart';
import 'package:sakeena/view_model/user_provider.dart';
import 'package:sakeena/widgets/auth_background.dart';
import 'package:sakeena/widgets/custom_button.dart';
import 'package:sakeena/widgets/custom_snackbar.dart';
import 'package:sakeena/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthControlle>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: AuthBackground(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 65.h),

                // Logo (replaced text 'Sakeena')
                SvgPicture.asset(
                  'assets/images/sakeena_logo.svg',
                  height: 80.h,
                  // width: 180.w,
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
                    SvgPicture.asset(
                      'assets/images/Welcome_text.svg',
                      height: 30.h,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Please enter your email & password.',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 32.h),

                    // Email
                    CustomTextField(
                      labelText: 'Email',
                      onChanged: (value) {
                        controller.email = value;
                      },
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
                    ),
                    SizedBox(height: 20.h),

                    // Password
                    CustomTextField(
                      onChanged: (value) {
                        controller.password = value;
                      },
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
                    ),

                    SizedBox(height: 12.h),

                    // Remember me + Forgot Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // Checkbox(
                            //   value: _rememberMe,
                            //   activeColor: const Color(0xFF2C7A7B),
                            //   onChanged: (bool? value) {
                            //     setState(
                            //       () => _rememberMe = value ?? false,
                            //     );
                            //   },
                            // ),
                            Text(
                              'Remember me',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () => context.go('/forgot'),
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: const Color(0xFF2C7A7B),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Login button
                    controller.isLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            text: 'Login',
                            textColor: Colors.white,
                            onPressed: () async {
                              if (controller.email.isNotEmpty &&
                                  controller.password.isNotEmpty) {
                                final ok = await controller.login(
                                  context: context,
                                  email: controller.email,
                                  password: controller.password,
                                );
                                if (ok) {

                                  if(context.mounted){
                                      controller.userResponse.results!.first.role ==
                                          "teacher"
                                      ? context.go(AppRoutes.teachersScreen)
                                      : controller
                                                .userResponse
                                                .results!
                                                .first
                                                .role ==
                                            "student"
                                      ? context.go(AppRoutes.studentHomeScreen)
                                      : null;
                                  }
                                
                                }
                              } else {
                                CustomSnackbar.show(
                                  context,
                                  message: "Please, fill up email and password",
                                  backgroundColor: Colors.red,
                                );
                              }
                            },
                            isGradient: true,
                          ),

                    // CustomButton(
                    //   text: 'Login',
                    //   onPressed: () {
                    //     context.go(AppRoutes.studentHomeScreen);
                    //   },
                    //   textColor: Colors.white,
                    //   isGradient: true,
                    // ),
                    SizedBox(height: 20.h),
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
                    SizedBox(height: 20.h),
                    CustomButton(
                      text: 'Continue as a guest',
                      onPressed: () => context.go(AppRoutes.guestHome),
                      isOutlined: true,
                      // textColor: Colors.black,
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontFamily: 'Arimo',
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.go(AppRoutes.signup),
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: const Color(0xFF2C7A7B),
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
