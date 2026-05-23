import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/features/student/profile/controller/profile_controller.dart';
import 'package:sakeena/route/go_route.dart';
import 'package:sakeena/widgets/custom_app_bar.dart';
import 'package:sakeena/widgets/custom_button.dart';
import 'package:sakeena/widgets/custom_snackbar.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage>
    with SingleTickerProviderStateMixin {
  late final Map<String, bool> passwordVisibility = {
    'current': false,
    'new': false,
    'confirm': false,
  };

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProfileController>();
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileAvatar(context, controller),
            SizedBox(height: 24.h),
            _buildProfileForm(),
            SizedBox(height: 24.h),
            _buildChangePasswordSection(),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileAvatar(BuildContext context, ProfileController controller) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        children: [
          Stack(
            children: [
             CircleAvatar(
  radius: 50, // ScreenUtil .r removed
  backgroundImage: context.read<ProfileController>().pickedImage != null
      ? FileImage(
          File(context.read<ProfileController>().pickedImage!.path),
        ) as ImageProvider
      : NetworkImage(
          // Safely fallback to a placeholder avatar if profilePicture is null
          context.read<ProfileController>().stundetProfileResponse.profilePicture ?? 
          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
        ),
),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    _showImageSourceSheet(context, controller);
                  },
                  child: Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF5B72EE),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'JPG, PNG or GIF (max. 2MB)',
            style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileForm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profile Information',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                _buildEditableField(
                  label: 'First Name',
                  icon: Icons.person_outline,
                  initialValue:
                      "${context.read<ProfileController>().stundetProfileResponse.firstName ?? ''} "
                          .trim(),
                  isEditing: true,
                  onChanged: (value) {
                    context.read<ProfileController>().stundetProfileResponse.firstName = value;
                  },
                ),
                SizedBox(height: 12.h),
                _buildEditableField(
                  label: 'Last Name',
                  icon: Icons.person_outline,
                  initialValue:
                      " ${context.read<ProfileController>().stundetProfileResponse.lastName ?? ''}"
                          .trim(),
                  isEditing: true,
                  onChanged: (value) {
                    context.read<ProfileController>().stundetProfileResponse.lastName = value;
                  },
                ),
                SizedBox(height: 12.h),
                // Email
                _buildEditableField(
                  label: 'Email Address',
                  icon: Icons.email_outlined,
                  initialValue:
                      context
                          .read<ProfileController>()
                          .stundetProfileResponse
                          .email ??
                      '',
                  isEditing: true,
                  onChanged: (value) =>
                      context
                              .read<ProfileController>()
                              .stundetProfileResponse
                              .email =
                          value,
                ),
                SizedBox(height: 12.h),
                // Phone
                _buildEditableField(
                  label: 'Phone Number',
                  icon: Icons.phone_outlined,
                  initialValue:
                      context
                          .read<ProfileController>()
                          .stundetProfileResponse
                          .phoneNumber ??
                      '',
                  isEditing: true,
                  onChanged: (value) =>
                      context
                              .read<ProfileController>()
                              .stundetProfileResponse
                              .phoneNumber =
                          value,
                ),
                SizedBox(height: 12.h),
                // Location
                _buildEditableField(
                  label: 'Location',
                  icon: Icons.location_on_outlined,
                  initialValue:
                      context
                          .read<ProfileController>()
                          .stundetProfileResponse
                          .location ??
                      '',
                  isEditing: true,
                  onChanged: (value) =>
                      context
                              .read<ProfileController>()
                              .stundetProfileResponse
                              .location =
                          value,
                ),
                SizedBox(height: 20.h),
              CustomButton(
  text: 'Save Changes',
  isLoading: context.watch<ProfileController>().isLoading, // Listens to loading state
  onPressed: () async {
    final ok = await context.read<ProfileController>().updateStundentProfile();
    if (context.mounted && ok) {
      CustomSnackbar.show(context, message: "Profile Updated Successfully");
    }
  },
  isGradient: true,
  width: double.infinity,
)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChangePasswordSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lock_outline, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                'Change Password',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                _buildPasswordField(
                  'currentPassword',
                  'Current Password',
                  'current',
                ),
                SizedBox(height: 16.h),
                _buildPasswordField('newPassword', 'New Password', 'new'),
                SizedBox(height: 16.h),
                _buildPasswordField(
                  'confirmPassword',
                  'Confirm New Password',
                  'confirm',
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  text: 'Update Password',
                  onPressed: () {},
                  isGradient: true,
                  width: double.infinity,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          SafeArea(
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account Actions',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.red.shade600,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  GestureDetector(
                    onTap: _showLogoutDialog,
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 18.sp,
                          color: Colors.red.shade600,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.red.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: _showDeleteAccountDialog,
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_forever_outlined,
                          size: 18.sp,
                          color: Colors.red.shade600,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'Delete account',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.red.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showImageSourceSheet(BuildContext context, ProfileController vm) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Select Profile Picture",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _imageSourceOption(
                icon: Icons.camera_alt_outlined,
                label: "Camera",
                onTap: () {
                  vm.pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              _imageSourceOption(
                icon: Icons.photo_library_outlined,
                label: "Gallery",
                onTap: () {
                  vm.pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          SizedBox(height: 20.h),
        ],
      ),
    ),
  );
}

Widget _imageSourceOption({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFF5B72EE), size: 28.sp),
        ),
        SizedBox(height: 8.h),
        Text(label, style: TextStyle(fontSize: 12.sp)),
      ],
    ),
  );
}

  Widget _buildEditableField({
    required String label,
    required IconData icon,
    required String initialValue, // Pass the string directly
    required bool isEditing,
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade700),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: isEditing ? Colors.white : Colors.grey.shade50,
            border: Border.all(
              color: isEditing ? const Color(0xFF5B72EE) : Colors.grey.shade200,
              width: isEditing ? 1.5 : 1,
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: TextFormField(
            // Switched from TextField to TextFormField
            initialValue: initialValue,
            enabled: isEditing,
            onChanged: onChanged,
            style: TextStyle(fontSize: 13.sp),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, size: 18.sp, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: 12.h,
                horizontal: 12.w,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(String key, String label, String visibilityKey) {
    final isVisible = passwordVisibility[visibilityKey] ?? false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: TextField(
            obscureText: !isVisible,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock_outline,
                size: 18.sp,
                color: Colors.grey,
              ),
              suffixIcon: GestureDetector(
                onTap: () => setState(
                  () => passwordVisibility[visibilityKey] = !isVisible,
                ),
                child: Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                  size: 18.sp,
                  color: Colors.grey,
                ),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: 12.h,
                horizontal: 12.w,
              ),
            ),
            style: TextStyle(fontSize: 13.sp),
          ),
        ),
      ],
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => context.go(AppRoutes.login),
            child: Text('Logout', style: TextStyle(color: Colors.red.shade600)),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to Delete account?\nThis action will delete your all data permanently!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => context.go(AppRoutes.signup),
            child: Text('Delete', style: TextStyle(color: Colors.red.shade600)),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
