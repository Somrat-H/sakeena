import 'package:flutter/material.dart';
import 'package:sakeena/features/student/course/model/student_course_response.dart';
import 'package:sakeena/features/student/course/repository/student_course_repository.dart';
import 'package:sakeena/features/student/profile/model/student_profile_response.dart';
import 'package:sakeena/features/teachers/courses/model/teacher_course_response.dart';
import 'package:sakeena/features/teachers/courses/model/course_category_response.dart';
import 'package:sakeena/features/teachers/course_detail/model/course_details_response.dart';
import 'package:sakeena/features/teachers/courses/repository/teacher_couse_repository.dart';

class StudentCourseProvider extends ChangeNotifier {
  StudentCourseResponse stundeProfileResponse = StudentCourseResponse();
  CourseCategroyResponse courseCategroyResponse = CourseCategroyResponse();
  CouseDeatilsResponse courseDetailsResponse = CouseDeatilsResponse();

  bool isLoading = false;
  bool isCategoryLoading = false;
  String selectedCategory = 'All';

  // --- Pure Server-Side Pagination ---
  int currentPage = 1;
  
  /// TODO: Replace `.totalPages` with whatever field your [StudentCourseResponse] 
  /// model uses to store total pages or total count from the API metadata.
  /// If your backend doesn't return total pages, default it safely (e.g., 3).
  int get totalPagesCount => stundeProfileResponse.totalPages ?? 1;

  // 1. Pass the page number parameter directly to your updated repository
  Future<void> getStudentCourse() async {
    isLoading = true;
    notifyListeners();
    
    try {
      final response = await StudentCourseRepository().getStudentCourse(currentPage);
      // stundeProfileResponse = StudentCourseResponse();
      stundeProfileResponse = response;
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching student courses: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // 2. Simple page navigation hook that auto-triggers an API fetch
  Future<void> changePage(int newPage)async {
    if (newPage >= 1 && newPage <= totalPagesCount) {
      currentPage = newPage;
      notifyListeners();
    await  getStudentCourse(); // Fetch the new data chunk instantly
    }
  }

  bool _categoriesFetched = false;

  Future<void> getCourseCategory() async {
    if (_categoriesFetched) return;
    isCategoryLoading = true;
    notifyListeners();
    final response = await StudentCourseRepository().getCourseCategory();

    courseCategroyResponse = response;
    isCategoryLoading = false;
    _categoriesFetched = true;
    notifyListeners();
  }

  void setSelectedCategory(String category) {
    selectedCategory = category;
    currentPage = 1; // Reset pagination index back to page 1 on filter switch
    getStudentCourse(); // Fetch fresh data matching your category logic
  }
}