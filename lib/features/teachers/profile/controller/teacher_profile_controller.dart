import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sakeena/features/teachers/profile/model/teacher_profile_response.dart';
import 'package:sakeena/features/teachers/profile/repository/teacher_profile_repository.dart';

class TeacherProfileController extends ChangeNotifier {
  TeacherProfileResponse teacherProfileResponse = TeacherProfileResponse();

  bool isLoading = false;

  Future<void> fetchTeacherProfile() async {
    isLoading = true;
    notifyListeners();
    final response = await TeacherProfileRepository().getTeacherProfile();
    teacherProfileResponse = response;
    isLoading = false;
    notifyListeners();
  }







}
