import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/features/auth/controller/auth_controller.dart';
import 'package:sakeena/route/go_route.dart';
import 'package:sakeena/widgets/auth_background.dart';
import 'package:sakeena/widgets/custom_button.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> _controllers = List.generate(
    5,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());

  @override
  void dispose() {
    for (var c in _controllers) c.dispose();
    for (var f in _focusNodes) f.dispose();
    super.dispose();
  }

  String get _otp => _controllers.map((c) => c.text).join();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthControlle>();
    final email = auth.resetEmail ?? 'example@gmail.com';

    return Scaffold(
          resizeToAvoidBottomInset: false,
          body: AuthBackground(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 100.h),
                  Text(
                    'Enter OTP',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C7A7B),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'We sent a reset link to $email',
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(5, (index) {
                      return SizedBox(
                        width: 50.w,
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 4) {
                              _focusNodes[index + 1].requestFocus();
                            } else if (value.isEmpty && index > 0) {
                              _focusNodes[index - 1].requestFocus();
                            }
                          },
                        ),
                      );
                    }),
                  ),

                  if (auth.errorMessage != null) ...[
                    SizedBox(height: 16.h),
                    Text(
                      auth.errorMessage!,
                      style: TextStyle(color: Colors.red, fontSize: 14.sp),
                    ),
                  ],

                  SizedBox(height: 32.h),

                  auth.isLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          text: 'Verify',
                          textColor: Colors.white,
                          onPressed: () {
                            if (_otp.length == 5) {
                              auth.verifyOtp(
                                otp: _otp,
                                onSuccess: () => context.go('/reset'),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter complete OTP'),
                                ),
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
                        context.go(AppRoutes.forgot);
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

                  SizedBox(height: 16.h),

                  TextButton(
                    onPressed: () {
                      // TODO: Resend OTP
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Code resent')),
                      );
                    },
                    child: Text(
                      "Didn't receive code? Resend",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }
    

  }



