import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sakeena/features/auth/controller/auth_controller.dart';
import 'package:sakeena/route/go_route.dart';
import 'package:sakeena/route/teachers_routes.dart';
import 'package:sakeena/widgets/auth_background.dart';
import 'package:sakeena/widgets/custom_button.dart';
import 'package:sakeena/widgets/custom_snackbar.dart';
import 'package:sakeena/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Fixed typo in AuthController class reference if applicable
    final controller = context.watch<AuthControlle>(); 
    
    return Scaffold(
      // Changed to true so your background content can adjust smoothly 
      // when the keyboard slides up
      resizeToAvoidBottomInset: true, 
      body: AuthBackground(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28.w),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        // Ensures content can stretch full height but scroll if smaller screens need it
                        minHeight: constraints.maxHeight, 
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 40.h),

                            // Logo
                            SvgPicture.asset(
                              'assets/images/sakeena_logo.svg',
                              height: 80.h,
                              fit: BoxFit.contain,
                            ),

                            SizedBox(height: 10.h),

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
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
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
                                Text(
                                  'Remember me',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey.shade800,
                                  ),
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
                                ? const Center(child: CircularProgressIndicator())
                                : CustomButton(
                                    text: 'Login',
                                    textColor: Colors.white,
                                    onPressed: () async {
                                      if (controller.email.isNotEmpty && controller.password.isNotEmpty) {
                                        final ok = await controller.login(
                                          context: context,
                                          email: controller.email,
                                          password: controller.password,
                                        );
                                        if (ok && context.mounted) {
                                          final role = controller.userResponse.results!.first.role;
                                          if (role == "teacher") {
                                            context.go(TeachersRoutes.dashboard);
                                          } else if (role == "student") {
                                            context.go(AppRoutes.studentHomeScreen);
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
                            
                            // Pushes footer down dynamically to balance spacing
                            const Spacer(), 
                            
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
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}