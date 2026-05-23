import 'package:sakeena/core/storage/token_manager.dart';
import 'package:sakeena/features/student/course/model/student_course_response.dart';
import 'package:sakeena/features/teachers/courses/model/course_category_response.dart';
import 'package:sakeena/features/teachers/courses/model/teacher_course_response.dart';
import 'package:sakeena/network/api_service/api_service.dart';
import 'package:sakeena/network/app_url/app_urls.dart';

class StudentCourseRepository {
  final ApiService _apiService = ApiService();
  Future<StudentCourseResponse> getStudentCourse(int page)async{
    final response = await _apiService.getData("${AppUrls.getTeacherCourse}?page=$page", authToken: await TokenStorage.getAccessToken());
    if(response["results"] != null){
      return StudentCourseResponse.fromJson(response);
    }else{
      return StudentCourseResponse();
    }
  }

  Future<CourseCategroyResponse> getCourseCategory()async{
    final response = await _apiService.getData(AppUrls.getCourseCategory, authToken: await TokenStorage.getAccessToken());
    if(response["results"] != null){
      return CourseCategroyResponse.fromJson(response);
    }else{
      return CourseCategroyResponse();
    }
  }


}