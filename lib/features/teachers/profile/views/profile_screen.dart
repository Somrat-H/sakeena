import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/core/app_theme.dart';
import 'package:sakeena/features/teachers/profile/controller/teacher_profile_controller.dart';
import 'package:sakeena/route/go_route.dart';
import 'package:sakeena/route/teachers_routes.dart';
import 'package:sakeena/widgets/achievement_item.dart';
import 'package:sakeena/widgets/custom_app_bar.dart';
import 'package:sakeena/widgets/education_item.dart';
import 'package:sakeena/widgets/profile_header.dart';
import 'package:sakeena/widgets/profile_section_card.dart';
import 'package:sakeena/widgets/specialty_tag.dart';
import 'package:sakeena/widgets/teacher_bottom_navigation.dart';

import '../../../../main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final specialtyController = TextEditingController();

  List<String> specialties = [
    'Family Management',
    'Anxiety Psychology',
    'Child-Informed Care',
    'Boundaries',
    'CBT',
  ];

  List<Map<String, String>> educations = [
    {
      'degree': 'PhD in Clinical Psychology',
      'institution': 'University of Cambridge',
    },
    {'degree': 'MA in Islamic Studies', 'institution': 'Al Azhar University'},
    {'degree': 'BA in Psychology', 'institution': 'University of London'},
  ];

  List<String> achievements = [
    'Published researcher in Islamic Psychology',
    'Speaker at International Islamic Psychology Conference',
    'Consultant for Muslim Mental Health Initiative',
    'Certified Mindfulness Instructor',
  ];

  @override
  Widget build(BuildContext context) {
    final profileController = context.watch<TeacherProfileController>();
    return Scaffold(
      appBar: CustomAppBar(onNotificationTap: () {}),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Center(
                    child: Text(
                      'Public Profile',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Center(
                    child: Text(
                      'Manage what students see on your profile',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  // Profile Header
                  ProfileHeaderTeacher(
                    initials:
                        profileController
                            .teacherProfileResponse
                            .profilePicture ??
                        "https://cdn-icons-png.flaticon.com/128/149/149071.png",
                    onUploadPhoto: () {
                      // open image picker / camera
                    },
                    initialFirstName:
                        profileController
                            .teacherProfileResponse
                            .user!
                            .firstName ??
                        "N/A",
                    initialLastName:
                        profileController
                            .teacherProfileResponse
                            .user!
                            .lastName ??
                        "N/A",
                    initialTitle:
                        profileController
                            .teacherProfileResponse
                            .user!
                            .firstName ??
                        "N/A",
                    initialEmail:
                        profileController.teacherProfileResponse.user!.email ??
                        "N/A",
                    initialLocation:
                        profileController.teacherProfileResponse.location ??
                        "N/A",
                  ),
                  // About & Professional Approach
                  ProfileSectionCard(
                    title:
                        profileController
                            .teacherProfileResponse
                            .professionalTitle ??
                        "N/A",
                    icon: Icons.info_outlined,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About Me',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          enabled: false,
                          initialValue:
                              profileController.teacherProfileResponse.about ??
                              "N/A",
                          maxLines: 4,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade50,
                          ),
                          
                        ),
                      ],
                    ),
                  ),
                  // Specialties & Tags
                  // ProfileSectionCard(
                  //   title: 'Specialties & Tags',
                  //   icon: Icons.local_offer_outlined,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Wrap(
                  //         spacing: 8.w,
                  //         runSpacing: 8.h,
                  //         children: specialties.map((specialty) {
                  //           return SpecialtyTag(
                  //             label: specialty,
                  //             onRemove: () {
                  //               setState(() {
                  //                 specialties.remove(specialty);
                  //               });
                  //             },
                  //           );
                  //         }).toList(),
                  //       ),
                  //       SizedBox(height: 16.h),
                  //       Row(
                  //         children: [
                  //           Expanded(
                  //             child: TextField(
                  //               controller: specialtyController,
                  //               decoration: InputDecoration(
                  //                 hintText:
                  //                     'Add a specialty tag (e.g., Anxiety Psychology)',
                  //                 hintStyle: TextStyle(
                  //                   fontSize: 12.sp,
                  //                   color: Colors.grey.shade400,
                  //                 ),
                  //                 border: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8.r),
                  //                 ),
                  //                 filled: true,
                  //                 fillColor: Colors.grey.shade50,
                  //                 contentPadding: EdgeInsets.symmetric(
                  //                   horizontal: 12.w,
                  //                   vertical: 10.h,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //           SizedBox(width: 8.w),
                  //           GestureDetector(
                  //             onTap: () {
                  //               if (specialtyController.text.isNotEmpty) {
                  //                 setState(() {
                  //                   specialties.add(specialtyController.text);
                  //                   specialtyController.clear();
                  //                 });
                  //               }
                  //             },
                  //             child: Container(
                  //               width: 40.w,
                  //               height: 40.h,
                  //               decoration: BoxDecoration(
                  //                 color: AppTheme.primaryColor,
                  //                 borderRadius: BorderRadius.circular(8.r),
                  //               ),
                  //               child: Center(
                  //                 child: Icon(
                  //                   Icons.add,
                  //                   color: Colors.white,
                  //                   size: 20.sp,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Education
                  ProfileSectionCard(
                    title: 'Education',
                    icon: Icons.school_outlined,
                    child: EducationItem(
                      degree: profileController
                          .teacherProfileResponse
                          .education!
                          .split(("@"))
                          .first,
                      institution: profileController
                          .teacherProfileResponse
                          .education!
                          .split(("@"))
                          .last,
                      icon: Icons.school,
                    ),
                  ),
                  // Achievements & Credentials
                  ProfileSectionCard(
                    title: 'Achievements & Credentials',
                    icon: Icons.star_outlined,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...profileController
                            .teacherProfileResponse
                            .achievements!
                            .map((achievement) {
                              return AchievementItem(
                                title: achievement,
                                icon: Icons.check_circle,
                                onRemove: () {
                                 
                                },
                              );
                            })
                            ,
                        

                           
                          
                        
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  // Action Buttons
                  Row(
                    children: [
                      // Expanded(
                      //   child: OutlinedButton(
                      //     onPressed: () {
                      //       context.push(TeachersRoutes.profilePreview);
                      //     },
                      //     style: OutlinedButton.styleFrom(
                      //       padding: EdgeInsets.symmetric(vertical: 12.h),
                      //       side: BorderSide(color: AppTheme.primaryColor),
                      //     ),
                      //     child: Text(
                      //       'Preview Profile',
                      //       style: TextStyle(
                      //         fontSize: 14.sp,
                      //         fontWeight: FontWeight.w600,
                      //         color: AppTheme.primaryColor,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(width: 12.w),
                      // Expanded(
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       // Handle save
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: AppTheme.primaryColor,
                      //       padding: EdgeInsets.symmetric(vertical: 12.h),
                      //     ),
                      //     child: Text(
                      //       'Save Public Profile',
                      //       style: TextStyle(
                      //         fontSize: 14.sp,
                      //         fontWeight: FontWeight.w600,
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
