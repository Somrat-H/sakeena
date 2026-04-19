import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/core/app_theme.dart';
import 'package:sakeena/features/student/profile/controller/profile_controller.dart';
import 'package:sakeena/features/teachers/profile/controller/teacher_profile_controller.dart';
import 'package:sakeena/widgets/custom_snackbar.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProfileController>();
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28.r,
            backgroundImage: AssetImage('assets/images/teacher_image.png'),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Alex Thompson',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'alex.thompson@email.com',
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    _badge('Premium Member', Colors.purple),
                    SizedBox(width: 6.w),
                    // _badge('2 Courses', Colors.orange),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 10.sp, color: color),
      ),
    );
  }
}


class ProfileHeaderTeacher extends StatefulWidget {
  final String initials; // still used for avatar fallback
  final VoidCallback onUploadPhoto;
  final String initialFirstName;
  final String initialLastName;
  final String initialTitle;
  final String initialEmail;
  final String initialLocation;

  // You can pass initial values from parent / bloc / provider / firebase
  const ProfileHeaderTeacher({
    super.key,
    required this.initials,
    required this.onUploadPhoto,
    required this.initialFirstName,
    required this.initialLastName,
    required this.initialTitle,
    required this.initialEmail,
    required this.initialLocation,
  });

  @override
  State<ProfileHeaderTeacher> createState() => _ProfileHeaderTeacherState();
}

class _ProfileHeaderTeacherState extends State<ProfileHeaderTeacher> {
 

  @override
  Widget build(BuildContext context) {
    // Watch for loading and image changes, but use read for static data to avoid cursor jumps
    final controller = context.watch<TeacherProfileController>();
    final teacher = controller.teacherProfileResponse;

    return Column(
      children: [
        SizedBox(height: 24.h),

        // Profile Avatar
        CircleAvatar(
          radius: 50.r,
          backgroundColor: Colors.grey.shade200,
          backgroundImage:NetworkImage(teacher.profilePicture!)
        ),

        SizedBox(height: 16.h),

   

        SizedBox(height: 8.h),
        Text(
          'Professional photo recommended (JPG, PNG - Max. 5MB)',
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.grey.shade500,
          ),
        ),

        SizedBox(height: 20.h),

        // Fields
        _buildEditableField(
          label: 'First Name',
          initialValue: teacher.user?.firstName ?? "N/A",
          isEditing: false,
          onChanged: (val) => teacher.user?.firstName = val,
        ),
        SizedBox(height: 12.h),
        _buildEditableField(
          label: 'Last Name',
          initialValue: teacher.user?.lastName ?? "N/A",
          isEditing: false,
          onChanged: (val) => teacher.user?.lastName = val,
        ),
        SizedBox(height: 12.h),
        _buildEditableField(
          label: 'Public Email',
          initialValue: teacher.user?.email ?? "N/A",
          isEditing: false,
          onChanged: (val) => teacher.user?.email = val,
        ),
        SizedBox(height: 12.h),
        _buildEditableField(
          label: 'Location',
          initialValue: teacher.location ?? "N/A",
          isEditing: false,
          onChanged: (val) => teacher.location = val,
        ),
      ],
    );
  }

  Widget _buildEditableField({
    required String label,
    required String initialValue,
    required bool isEditing,
    required Function(String)? onChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8.r),
        border: isEditing ? Border.all(color: AppTheme.primaryColor.withOpacity(0.3)) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label, // Changed from initialValue to label for better UX
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 4.h),
          if (isEditing)
            TextFormField(
              key: ValueKey(label), // Ensures field doesn't dispose randomly
              onChanged: onChanged,
              initialValue: initialValue == "N/A" ? "" : initialValue,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 4),
                border: InputBorder.none,
              ),
            )
          else
            Text(
              initialValue,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
        ],
      ),
    );
  }
}

  


