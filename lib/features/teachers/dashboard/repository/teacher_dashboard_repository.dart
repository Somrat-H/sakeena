import 'package:flutter/foundation.dart';
import 'package:sakeena/core/storage/token_manager.dart';
import 'package:sakeena/features/teachers/dashboard/model/teacher_dashboard_response.dart';
import 'package:sakeena/network/api_service/api_service.dart';
import 'package:sakeena/network/app_url/app_urls.dart';

class TeacherDashboardRepository {
  final ApiService _apiService = ApiService();
  Future<TeacherDashboardResponse> getTeacherDashboard()async{
    final response = await _apiService.getData(AppUrls.getTeacherDashboard, authToken: await TokenStorage.getAccessToken());
    if(kDebugMode){
      debugPrint(response.toString());
    }
    return TeacherDashboardResponse.fromJson(response); 
  }
}

