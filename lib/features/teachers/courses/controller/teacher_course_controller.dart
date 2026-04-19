import 'package:flutter/material.dart';
import 'package:sakeena/features/teachers/courses/model/teacher_course_response.dart';
import 'package:sakeena/features/teachers/courses/repository/teacher_couse_repository.dart';

class TeacherCourseController extends ChangeNotifier {
  TeacherCoruseResponse teacherCoruseResponse = TeacherCoruseResponse();

  bool isLoading = false;

  Future<void> getTeacherCourse() async {
    isLoading = true;
    notifyListeners();
    final response = await TeacherCouseRepository().getTeacherCourse();

    teacherCoruseResponse = response;
    isLoading = false;
    notifyListeners();
  }
}
