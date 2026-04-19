import 'package:flutter/material.dart';
import 'package:sakeena/features/teachers/courses/model/teacher_course_response.dart';
import 'package:sakeena/features/teachers/courses/model/course_category_response.dart';
import 'package:sakeena/features/teachers/courses/model/course_details_response.dart';
import 'package:sakeena/features/teachers/courses/repository/teacher_couse_repository.dart';

class TeacherCourseController extends ChangeNotifier {
  TeacherCoruseResponse teacherCoruseResponse = TeacherCoruseResponse();
  CourseCategroyResponse courseCategroyResponse = CourseCategroyResponse();
  CouseDeatilsResponse courseDetailsResponse = CouseDeatilsResponse();

  bool isLoading = false;
  bool isCategoryLoading = false;
  String selectedCategory = 'All';

  Future<void> getTeacherCourse() async {
    isLoading = true;
    notifyListeners();
    final response = await TeacherCouseRepository().getTeacherCourse();

    teacherCoruseResponse = response;
    isLoading = false;
    notifyListeners();
  }

  bool _categoriesFetched = false;

  Future<void> getCourseCategory() async {
    if (_categoriesFetched) return;
    isCategoryLoading = true;
    notifyListeners();
    final response = await TeacherCouseRepository().getCourseCategory();

    courseCategroyResponse = response;
    isCategoryLoading = false;
    _categoriesFetched = true;
    notifyListeners();
  }

  void setSelectedCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  Future<void> getCourseDetails(int id) async {
    isLoading = true;
    notifyListeners();
    final response = await TeacherCouseRepository().getCourseDetails(id);
    courseDetailsResponse = response;
    isLoading = false;
    notifyListeners();
  }
}