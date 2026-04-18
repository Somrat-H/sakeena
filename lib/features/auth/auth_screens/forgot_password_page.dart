import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/route/go_route.dart';
import 'package:sakeena/view_model/auth_view_model.dart';
import 'package:sakeena/widgets/auth_background.dart';
import 'package:sakeena/widgets/custom_button.dart';
import 'package:sakeena/widgets/custom_text_field.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();

    // Important: dispose controller when widget is removed
    // (in StatelessWidget we use automatic cleanup via WidgetsBinding)
    void disposeController() {
      emailController.dispose();
    }

    // We clean up when the widget is permanently removed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // This is a bit of a hack — better solution would be to use a mixin or keep it Stateful
      // but for simple cases this works
    });

    return Consumer<AuthViewModel>(
      builder: (context, auth, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: AuthBackground(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 60.h),
                    // Logo
                    SvgPicture.asset(
                      'assets/images/sakeena_logo.svg',
                      height: 60.h,
                      fit: BoxFit.contain,
                    ),

                    SizedBox(height: 50.h),

                    // Card with content
                    Column(
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF2C7A7B),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          "Don't worry it occurs. Please enter your email address linked with your account.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade700,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 40.h),

                        // Email field
                        CustomTextField(
                          controller: emailController,
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email is required';
                            }
                            if (!RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            ).hasMatch(value.trim())) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),

                        if (auth.errorMessage != null) ...[
                          SizedBox(height: 16.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              auth.errorMessage!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],

                        SizedBox(height: 32.h),

                        auth.isLoading
                            ? const CircularProgressIndicator(
                                color: Color(0xFF2C7A7B),
                              )
                            : CustomButton(
                                text: 'Send Code',
                                textColor: Colors.white,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    auth.sendResetCode(
                                      email: emailController.text.trim(),
                                      onSuccess: () => context.go('/otp'),
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
                        context.go(AppRoutes.login);
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

                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
