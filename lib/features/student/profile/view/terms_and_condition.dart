import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sakeena/widgets/custom_app_bar.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Center(
                  child: Text(
                    'Terms & Condition',
                    style: TextStyle(
                      fontSize: 28.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      
                    ),
                  ),
                ),
              SizedBox(height: 24.h),
          
              _Paragraph(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras condimentum quam et vestibulum porttitor, vestibulum tempor ac purus vitae felis. Cras tempus felis vitae sapien fermentum, et dapibus ligula interdum. Nunc mattis imperdiet libero, a eleifend nunc condimentum in. Etiam, '
                'habitasse platea dictumst, vestibulum placerat felis.',
              ),
              _Paragraph(
                'Sed neque libero, fringilla vitae nunc id, tristique vestibulum erat. Sed a tortor est. Sed sem libero, condimentum sed eu nisl, tristique vestibulum erat. Nunc mattis imperdiet libero, a eleifend nunc condimentum in. Etiam, '
                'tristique vestibulum erat. Nunc mattis imperdiet libero, a eleifend nunc condimentum in.',
              ),
          
              _Paragraph(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras condimentum quam et vestibulum porttitor, vestibulum tempor ac purus vitae felis. Cras tempus felis vitae sapien fermentum, et dapibus ligula interdum. Nunc mattis imperdiet libero, a eleifend nunc condimentum in. Etiam, '
                'habitasse platea dictumst, vestibulum placerat felis. Sed sem libero, condimentum sed eu nisl, tristique vestibulum erat.',
              ),
          
              _Paragraph(
                'Sed neque libero, fringilla vitae nunc id, tristique vestibulum erat. Sed a tortor est. Sed sem libero, condimentum sed eu nisl, tristique vestibulum erat. Nunc mattis imperdiet libero, a eleifend nunc condimentum in. Etiam, '
                'tristique vestibulum erat. Nunc mattis imperdiet libero, a eleifend nunc condimentum in. Maecenas tortor sapien aliquam.',
              ),
          
              _Paragraph(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras condimentum quam et vestibulum porttitor, vestibulum tempor ac purus vitae felis. Cras tempus felis vitae sapien fermentum, et dapibus ligula interdum. Nunc mattis imperdiet libero, a eleifend nunc condimentum in.',
              ),
          
              _Paragraph(
                'Sed neque libero, fringilla vitae nunc id, tristique vestibulum erat. Sed a tortor est. Sed sem libero, condimentum sed eu nisl, tristique vestibulum erat. Nunc mattis imperdiet libero, a eleifend nunc condimentum in.',
              ),
          
            ],
          ),
        ),
      ),
    );
  }


  Widget _Paragraph(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.sp,
        height: 1.55,
        color: Colors.grey.shade800,
      ),
    );
  }
}