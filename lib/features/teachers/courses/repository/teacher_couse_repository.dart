import 'dart:ffi';

import 'package:sakeena/core/storage/token_manager.dart';
import 'package:sakeena/features/teachers/courses/model/teacher_course_response.dart';
import 'package:sakeena/features/teachers/courses/model/course_category_response.dart';
import 'package:sakeena/features/teachers/courses/model/course_details_response.dart';
import 'package:sakeena/network/api_service/api_service.dart';
import 'package:sakeena/network/app_url/app_urls.dart';

class TeacherCouseRepository {
  final ApiService _apiService = ApiService();
  Future<TeacherCoruseResponse> getTeacherCourse()async{
    final response = await _apiService.getData(AppUrls.getTeacherCourse, authToken: await TokenStorage.getAccessToken());
    if(response["results"] != null){
      return TeacherCoruseResponse.fromJson(response);
    }else{
      return TeacherCoruseResponse();
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

  Future<CouseDeatilsResponse> getCourseDetails(int id)async{
    final response = await _apiService.getData(AppUrls.getCourseDetails(id), authToken: await TokenStorage.getAccessToken());
    return CouseDeatilsResponse.fromJson(response);
  }
}