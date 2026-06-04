import 'package:flutter/foundation.dart';
import 'package:sakeena/core/storage/token_manager.dart';
import 'package:sakeena/features/student/home/model/student_dashboard_response.dart';
import 'package:sakeena/network/api_service/api_service.dart';
import 'package:sakeena/network/app_url/app_urls.dart';

class StudentDashboardRepository {

  final ApiService _apiService = ApiService();
  Future<StudentDashboardResponse> getStudentDashboard()async{
    final response = await _apiService.getData(AppUrls.getStudentDashboard, authToken: await TokenStorage.getAccessToken());
    if(kDebugMode){
      debugPrint(response.toString());
    }
    return StudentDashboardResponse.fromJson(response); 
  }

}