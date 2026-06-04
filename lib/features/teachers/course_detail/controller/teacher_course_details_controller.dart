import 'package:flutter/material.dart';
import 'package:sakeena/features/guest_portion/home/model/course_review_model.dart';
import 'package:sakeena/features/teachers/course_detail/model/course_details_response.dart';
import 'package:sakeena/features/teachers/course_detail/repository/teacher_course_details_repository.dart';


class TeacherCourseDetailsController extends ChangeNotifier{
  CouseDeatilsResponse courseDetailsResponse = CouseDeatilsResponse();
  CourseReviewModel courseReviewModel = CourseReviewModel();
  bool isLoading = false;

    Future<void> getCourseDetails(int id) async {
    isLoading = true;
    notifyListeners();
    final response = await TeacherCourseDetailsRepository().getCourseDetails(id);
    courseDetailsResponse = response;
    isLoading = false;
    notifyListeners();
  }

   Future<void> fetchCourseReviews(int id) async {
    final response = await TeacherCourseDetailsRepository().getCourseReview(id);
    courseReviewModel = response;
  }


    Future<String> getDriectEnroll(Map<String, dynamic> data) async {
    isLoading = true;
    notifyListeners();
    final response = await TeacherCourseDetailsRepository().emorollment(data);
    if(response["checkout_url"] != null){
          isLoading = false;
    notifyListeners();
      return response["checkout_url"];
      
    }else{
    isLoading = false;
    notifyListeners();
      return "";
    }

  }


}