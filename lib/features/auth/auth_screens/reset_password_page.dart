import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/features/auth/controller/auth_controller.dart';
import 'package:sakeena/route/go_route.dart';
import 'package:sakeena/widgets/auth_background.dart';
import 'package:sakeena/widgets/custom_button.dart';
import 'package:sakeena/widgets/custom_text_field.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthControlle>();

    return Scaffold(
          resizeToAvoidBottomInset: false,
          body: AuthBackground(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 100.h),
                    Text(
                      'Create new password',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C7A7B),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Your new password must be unique from those previously used.',
                      style: TextStyle(fontSize: 14.sp, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40.h),

                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'New Password',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Password is required';
                        if (value.length < 6) return 'At least 6 characters';
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),

                    CustomTextField(
                      controller: _confirmController,
                      hintText: 'Confirm Password',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),

                    if (auth.errorMessage != null) ...[
                      SizedBox(height: 16.h),
                      Text(
                        auth.errorMessage!,
                        style: TextStyle(color: Colors.red, fontSize: 14.sp),
                      ),
                    ],

                    SizedBox(height: 40.h),

                    auth.isLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            text: 'Reset Password',
                            textColor: Colors.white,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                auth.resetPassword(
                                  newPassword: _passwordController.text,
                                  onSuccess: () => context.go('/success'),
                                );
                              }
                            },
                            isGradient: true,
                          ),

                    SizedBox(height: 16.h),

                    CustomButton(
                      text: 'Go back',
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go(AppRoutes.otp);
                        }
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 24.sp,
                      ),
                      isOutlined: true,
                      textColor: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
  }

